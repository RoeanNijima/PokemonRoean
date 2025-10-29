# ======================================================
# Configuration
# ======================================================
WINDOWSKIN_NAME = ""    # Set to "" to use the default windowskin
DISPLAY_DAY = false     # Set to false to hide the week and month day
$show_clock_hud = false  # Set to false to disable the HUD by default
$show_clock_hud_now = false

# ======================================================
# Calendar HUD
# ======================================================

# roean show hud when pausing
class PokemonPauseMenu_Scene
  alias __orig_pbStartScene__ pbStartScene
  alias __orig_pbEndScene__ pbEndScene

  def pbStartScene(*args)
    $show_clock_hud = true
    $show_clock_hud_now = true
    __orig_pbStartScene__(*args)
  end

  def pbEndScene(*args)
      $show_clock_hud = false
      $show_clock_hud_now = true
    __orig_pbEndScene__(*args)
  end
end


class Calendar_HUD
  def initialize
    @viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
    @viewport.z = 10000
    @sprites = {}
    @icons = {}

    icon = PBDayNight.isNight? ? getMoonIcon : "sun"
    time = pbGetTimeNow
    skin = WINDOWSKIN_NAME == "" ? MessageConfig.pbGetSystemFrame : "Graphics/Windowskins/" + WINDOWSKIN_NAME
    @last_update_time = System.uptime

    @week = time.strftime("%A")[0..2]
    @day = time.day
    @time = _INTL("<icon=#{icon}>{1}", pbGetTimeNow.strftime("%H:%M"))
    @dayString = _INTL("{1}. {2}", @week, @day)

    # ===================================================
    # Top HUD
    # ===================================================

    @sprites["window_time"] = Window_AdvancedTextPokemon.newWithSize(@time, 0, 0, 0, 100, @viewport)
    @sprites["window_day"] = Window_AdvancedTextPokemon.newWithSize(@dayString, 0, 0, 0, 100, @viewport)

    @sprites["window_time"].resizeToFit(@time)
    @sprites["window_time"].width = 125

    @sprites["window_day"].resizeToFit(@dayString)
    @sprites["window_day"].height = 66
    @sprites["window_day"].x += @sprites["window_time"].width + 4

    @sprites["window_time"].visible = false
    @sprites["window_time"].setSkin(skin)

    @sprites["window_day"].visible = false
    @sprites["window_day"].setSkin(skin)
  end

  # Returns the icon name file for the current moon phase
  # returns [String]
  def getMoonIcon
    icon = "moon_"
    moonPhase = PluginManager.installed?("Unreal Time System") ? pbMoonPhaseUTS : pbGetTimeNow.moonphase
    case moonPhase
    when 0
      icon += "New"
    when 1
      icon += "WaxingCrescent"
    when 2
      icon += "FirstQuarter"
    when 3
      icon += "WaxingGibbous"
    when 4
      icon += "Full"
    when 5
      icon += "WaningGibbous"
    when 6
      icon += "LastQuarter"
    when 7
      icon += "WaningCrescent"
    end
    return icon
  end

  def updateClock
    icon = PBDayNight.isNight? ? getMoonIcon : "sun"
    pointer = (Graphics.frame_count / 180) % 2 == 0

    if pointer
      @time = _INTL("<icon=#{icon}>{1}", pbGetTimeNow.strftime("%H:%M"))
    else
      @time = _INTL("<icon=#{icon}>{1}", pbGetTimeNow.strftime("%H %M"))
    end
    @sprites["window_time"].text = @time

    if pbGetTimeNow.hour == 0 && pbGetTimeNow.min == 0
      @dayString = _INTL("{1}. {2}", pbGetTimeNow.strftime("%A")[0..2], pbGetTimeNow.day)
      @sprites["window_day"].text = @dayString
    end
  end

  def update
    if !@last_update_time || System.uptime - @last_update_time > 0.5 || $show_clock_hud_now
      updateClock; $show_clock_hud_now = false

      @sprites["window_time"].visible = $show_clock_hud
      if DISPLAY_DAY
        @sprites["window_day"].visible = $show_clock_hud
      end

      @last_update_time = System.uptime
    end
    pbUpdateSpriteHash(@sprites)
  end

  def dispose
    pbDisposeSpriteHash(@sprites)
  end
end

# ======================================================
# Custom pbMoonPhase to use if using UTS plugin
# ======================================================

def pbMoonPhaseUTS(time = nil)
  time = pbGetTimeNow if !time
  transitions = [
    1.8456618033125,
    5.5369854099375,
    9.2283090165625,
    12.9196326231875,
    16.6109562298125,
    20.3022798364375,
    23.9936034430625,
    27.6849270496875,
  ]
  yy = time.year - ((12 - time.mon) / 10.0).floor
  j = (365.25 * (4712 + yy)).floor + ((((time.mon + 9) % 12) * 30.6) + 0.5).floor + time.day + 59
  j -= (((yy / 100.0) + 49).floor * 0.75).floor - 38 if j > 2_299_160
  j += ((time.hour * 3600) + (time.min * 60) + time.sec) / 86_400.0  # fix

  v = (j - 2_451_550.1) / 29.530588853
  v = v % 1  # normalizado
  ag = v * 29.53

  transitions.length.times do |i|
    return i if ag <= transitions[i]
  end
  return 0
end

# =======================================================
# Override Spriteset_Map to update and dispose the HUD
# =======================================================

class Spriteset_Map
  alias calendar_dispose dispose
  alias calendar_update update

  def dispose
    @hud.dispose if @hud
    calendar_dispose
  end

  def update
    @hud = Calendar_HUD.new if !@hud
    @hud.update
    calendar_update
  end
end
