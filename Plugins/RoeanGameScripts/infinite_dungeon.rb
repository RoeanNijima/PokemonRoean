
$infinite_dungeon_mapids = [96, 97, 98, 99, 100]
$infinite_dungeon_floors = [97,98,99]
$infinite_dungeon_hubfloor = 100
$infinite_dungeon_bossfloor = 100

DUNGEON_BASE_LEVEL = 20 # what level to start pokemon from (1F onwards)
DUNGEON_BOSS_INTERVAL = 25 # multiple of floors to spawn legendary encounters
DUNGEON_HUB_INTERVAL = 5 # intervals to spawn a hub floor if NOT a boss floor among other conditions (hub floor lets you exit without blacking out and losing floor progress etc)
DUNGEON_BGMS = { # bgm => until_floor
  "tartarus_0d00" => 1,
  "tartarus_0d01" => 10,
  "tartarus_0d02" => 20,
  "tartarus_0d03" => 30,
  "tartarus_0d04" => 50,
  "tartarus_0d05" => 70,
  "tartarus_0d06" => 100,
  "tartarus_0d06" => 101 # >100 is not quest bound so its infinitely 0d03
}

DUNGEON_COMMON_LOOT = [
  :POKEBALL, :GREATBALL, :ULTRABALL,
  :POTION, :SUPERPOTION, :HYPERPOTION,
  :ANTIDOTE, :PARALYZEHEAL, :AWAKENING, :BURNHEAL, :ICEHEAL,
  :SUPERREPEL,
  :SITRUSBERRY, :LUMBERRY,
  :EGGRAFFLETICKET
]

DUNGEON_FOSSILS = [
  :HELIXFOSSIL, :DOMEFOSSIL, :OLDAMBER,
  :ROOTFOSSIL, :CLAWFOSSIL, :SKULLFOSSIL, :ARMORFOSSIL,
  :COVERFOSSIL, :PLUMEFOSSIL, :JAWFOSSIL, :SAILFOSSIL,
  :FOSSILIZEDBIRD, :FOSSILIZEDFISH, :FOSSILIZEDDRAKE, :FOSSILIZEDDINO
]

DUNGEON_LOOTPOOL = {
  # Floor 1 (Hub)
  1 => DUNGEON_COMMON_LOOT,

  # Floor 1–10
  10 => [
    :DUSKBALL, :TIMERBALL,
    :FIRESTONE, :WATERSTONE, :THUNDERSTONE, :LEAFSTONE,
    :CHARCOAL, :MIRACLESEED, :MYSTICWATER, :TWISTEDSPOON,
    :EVIOLITE
  ],

  # Floor 11–20
  20 => [
    :FULLRESTORE, :REVIVE,
    :MOONSTONE, :SUNSTONE, :DUSKSTONE, :DAWNSTONE, :ICESTONE,
    :BLACKBELT, :MAGNET, :LEFTOVERS, :SHELLBELL,
    :LIECHIBERRY, :SALACBERRY
  ],

  # Floor 21–30
  30 => [
    :MAXPOTION, :FULLRESTORE,
    :HPUP, :PROTEIN, :IRON, :CALCIUM, :ZINC, :CARBOS,
    :SCOPELENS, :LUCKYEGG, :EVIOLITE,
    :HEALTHFEATHER, :MUSCLEFEATHER, :RESISTFEATHER,
    :GENIUSFEATHER, :CLEVERFEATHER, :SWIFTFEATHER
  ],

  # Floor 31–50
  50 => [
    :ABILITYCAPSULE, :EXPCHARM, :LIFEORB, :FOCUSSASH,
    :BOLDMINT, :JOLLYMINT, :ADAMANTMINT, :MODESTMINT, :TIMIDMINT,
    :LEFTOVERS, :SCOPELENS
  ] + DUNGEON_FOSSILS.sample(4),

  # Floor 51–70
  70 => [
    :ABILITYCAPSULE, :ABILITYPATCH,
    :RARECANDY, :LIFEORB,
    :CHOICEBAND, :CHOICESPECS, :CHOICESCARF,
    :FOCUSSASH, :LEFTOVERS
  ] + DUNGEON_FOSSILS.sample(6),

  # Floor 71–100
  100 => [
    :ABILITYPATCH, :ABILITYCAPSULE,
    :RARECANDY, :LIFEORB, :CHOICEBAND, :CHOICESCARF, :CHOICESPECS,
    :LEFTOVERS, :FOCUSSASH, :SCOPELENS
  ] + DUNGEON_FOSSILS.sample(8),

  # Floor 101+ (Infinite)
  101 => DUNGEON_COMMON_LOOT + [
    :ABILITYPATCH, :RARECANDY,
    :LIFEORB, :CHOICEBAND, :CHOICESPECS, :CHOICESCARF,
    :LEFTOVERS, :FOCUSSASH, :SCOPELENS
  ] + DUNGEON_FOSSILS
}

DUNGEON_BETTERPOOL_MIN = 10.0  # 1 in 10 at floor 1
DUNGEON_BETTERPOOL_MAX = 3.0   # 1 in 3 at floor 85+
DUNGEON_BETTERPOOL_CAPFLOOR = 85
def pbGetDungeonLootPool
  floor = [$PokemonGlobal.current_dungeon_floor, DUNGEON_BETTERPOOL_CAPFLOOR].min

  # Linear interpolation of odds from 10 → 3 across 0–85 floors
  chance = DUNGEON_BETTERPOOL_MIN - ((DUNGEON_BETTERPOOL_MIN - DUNGEON_BETTERPOOL_MAX) * (floor / DUNGEON_BETTERPOOL_CAPFLOOR.to_f))
  chance = [chance, DUNGEON_BETTERPOOL_MAX].max

  use_better_pool = (rand(chance.ceil) == 0)

  if use_better_pool
    loot_choice = DUNGEON_LOOTPOOL.sort_by { |floor_req, _| floor_req }.find { |floor_req, _| floor < floor_req }
    loot_choice ||= DUNGEON_LOOTPOOL.to_a.last
    return loot_choice[1]
  else
    return DUNGEON_COMMON_LOOT
  end
end

def pbDungeonLoot
  loot_pool = pbGetDungeonLootPool
  return false if loot_pool.nil? || loot_pool.empty?

  item = loot_pool.sample
  return pbItemBall(:POTION, 1) if item.nil?

  quantity = 1
  item_name = GameData::Item.get(item).name

  if item_name.include?("Ball")
    quantity = 5
  end

  return pbItemBall(item, quantity)
end

def pbProgressDungeon
  next_map = pbGetInfiniteDungeonNext()
  $PokemonGlobal.current_dungeon_floor += 1
  $PokemonGlobal.highest_dungeon_floor = [$PokemonGlobal.highest_dungeon_floor, $PokemonGlobal.current_dungeon_floor].max

  goto_x = 0
  goto_y = 0
  current_floor = $PokemonGlobal.current_dungeon_floor

  if next_map == $infinite_dungeon_hubfloor || next_map == $infinite_dungeon_bossfloor
    if (current_floor % DUNGEON_BOSS_INTERVAL).zero?
      goto_x = 10
      goto_y = 23
    else
      goto_x = 28
      goto_y = 12
    end
  end

  pbFadeOutIn {
    $game_temp.player_new_map_id    = next_map
    $game_temp.player_new_x         = goto_x
    $game_temp.player_new_y         = goto_y
    $game_temp.player_new_direction = 8 # face up unless overridden
    $scene.transfer_player
  }

  # floor modifiers
  if current_floor > 100 then
    $TRAINER_MEGA_STONE_CHANCE = 8
    $TRAINER_RAREMON_CHANCE = 16
    $TRAINER_ULTRAMON_CHANCE = 32
  elsif current_floor > 50
    $TRAINER_MEGA_STONE_CHANCE = 32
    $TRAINER_RAREMON_CHANCE = 64
    $TRAINER_ULTRAMON_CHANCE = 128
  else
    $TRAINER_MEGA_STONE_CHANCE = 64
    $TRAINER_RAREMON_CHANCE = 128
    $TRAINER_ULTRAMON_CHANCE = 256
  end

  $DUNGEON_EXTRA_SHINY_ROLLS = [($PokemonGlobal.current_dungeon_floor / DUNGEON_BOSS_INTERVAL).floor + 1, 4].min

end

def pbGetDungeonLevelScale(is_boss = false)
  floor = $PokemonGlobal.current_dungeon_floor
  return 100 if floor > 100 && is_boss # infinite floors boss cap
  return rand(85..90) if floor > 100 # infinite floors non boss cap

  interval_index = (floor / DUNGEON_BOSS_INTERVAL).floor
  boss_level = [DUNGEON_BASE_LEVEL + 10 + (interval_index * 10), 70].min

  return boss_level if is_boss

  progress = (floor % DUNGEON_BOSS_INTERVAL).to_f / DUNGEON_BOSS_INTERVAL
  base_level = DUNGEON_BASE_LEVEL + (interval_index * 10) + (progress * 10)

  max_wild = [base_level.floor, boss_level - 5].min
  min_wild = [max_wild - 3, DUNGEON_BASE_LEVEL].max

  return rand(min_wild..max_wild)
end

def pbAttemptBoss()
  return WildBattle.start($PokemonGlobal.current_dungeon_boss, pbGetDungeonLevelScale(true))
end

def pbDecideDungeonBoss(evtid)
  $game_map.events[evtid].character_name = "Followers\\#{$PokemonGlobal.current_dungeon_boss.to_s}"
end

def pbPickPersistentBoss()
  $PokemonGlobal.defeated_floor_boss = false
  $PokemonGlobal.current_dungeon_boss = ( ($PokemonGlobal.current_dungeon_floor + 1) % 100 == 0) ? pbSampleUltraEncounter() : pbSampleRareEncounter()[0]
  $PokemonGlobal.current_dungeon_boss = :ARCEUS if ($PokemonGlobal.current_dungeon_floor + 1) % 1000 == 0
end

def pbGetInfiniteDungeonNext()
  current_floor = $PokemonGlobal.current_dungeon_floor || 0
  current_map   = $game_map.map_id

  # boss floor
  if (current_floor + 1) % DUNGEON_BOSS_INTERVAL == 0
    pbPickPersistentBoss()
    return $infinite_dungeon_bossfloor
  end

  # hub floor
  if (current_floor + 1) % DUNGEON_HUB_INTERVAL == 0
    return $infinite_dungeon_hubfloor
  end

  # random floor
  possible_floors = $infinite_dungeon_floors - [current_map]
  return possible_floors.sample
end

class PokemonGlobalMetadata
  attr_accessor :current_dungeon_floor
  attr_accessor :highest_dungeon_floor
  attr_accessor :current_dungeon_boss
  attr_accessor :defeated_floor_boss

  alias __o__initialize__ initialize
  def initialize
    __o__initialize__()
    @current_dungeon_floor  ||= 0
    @highest_dungeon_floor  ||= 0
    @current_dungeon_boss   ||= :ARTICUNO
    @defeated_floor_boss    ||= false
  end
end

class Game_Map
  alias __o__bgm_name__ bgm_name
  alias __o__autoplay__ autoplay

  def bgm_name # force progressive dungeon bgm
    return __o__bgm_name__ unless $infinite_dungeon_mapids.include?(@map_id)
    bgm_choice = DUNGEON_BGMS.sort_by { |_, until_floor| until_floor }.find { |_, until_floor| $PokemonGlobal.current_dungeon_floor < until_floor }

    bgm_choice ||= DUNGEON_BGMS.sort_by { |_, floor_req| floor_req }.last # bgm fallback (infinite bgm)
    bgm_name, _ = bgm_choice
    return bgm_name
  end
end

class Battle
  alias __o__initialize_infd__ initialize

  def initialize(*args)
    __o__initialize_infd__(*args)
    return unless $infinite_dungeon_mapids.include?($game_map.map_id)

    is_boss_floor = ($PokemonGlobal.current_dungeon_floor % DUNGEON_BOSS_INTERVAL).zero?
    @disablePokeBalls = !(@party2[0].shiny? || is_boss_floor)
  end
end

class GameData::Trainer
  alias __o__to_trainer_infd__ to_trainer

  def to_trainer
    unless $infinite_dungeon_mapids.include?($game_map.map_id)
      return __o__to_trainer_infd__()
    end

    team_size = pbGetDungeonTeamSize()
    @pokemon = []

    team_size.times do
      mon = pbGenerateDungeonTrainerMon()
      @pokemon << mon if mon
    end

    return __o__to_trainer_infd__()

  end
end

EventHandlers.add(:on_wild_pokemon_created, :dungeon_encounters,
  proc { |pkmn|
    next unless $infinite_dungeon_mapids.include?($game_map.map_id)
    next if ($PokemonGlobal.current_dungeon_floor % DUNGEON_BOSS_INTERVAL).zero?

    species = pbGetWeightResult(pbGetRafflePool())
    level   = pbGetDungeonLevelScale(false)
    evolved = pbEvolveEncounter(species, level)

    pkmn.species = evolved
    pkmn.level   = level
    pkmn.ability = nil
    pkmn.calc_stats
    pkmn.reset_moves

    # extra shiny rolls
    rolls = 0
    while !pkmn.shiny? && rolls < $DUNGEON_EXTRA_SHINY_ROLLS
      rolls += 1
      pkmn.shiny = nil
      pkmn.shiny? # make game reroll
    end
  }
)

EventHandlers.add(:on_map_or_spriteset_change, :show_location_window_infinite,
  proc { |scene, map_changed|
    next if !scene || !scene.spriteset
    next if !map_changed
    next unless $infinite_dungeon_mapids.include?($game_map.map_id)

    # incase not defined (Savefile compatibility)
    $PokemonGlobal.current_dungeon_floor ||= 0
    $PokemonGlobal.highest_dungeon_floor ||= 0
    $PokemonGlobal.current_dungeon_boss  ||= :ARTICUNO
    $PokemonGlobal.defeated_floor_boss   ||= false

    if $PokemonGlobal.current_dungeon_floor % 100 == 0
      $PokemonGlobal.nextBattleBGM = "TheAlmighty" if $PokemonGlobal.current_dungeon_floor != 0
    else
      $PokemonGlobal.nextBattleBGM = nil
    end

    #$PokemonGlobal.current_dungeon_floor = 99 #debug test

    if $PokemonGlobal.defeated_floor_boss && ($PokemonGlobal.current_dungeon_floor % DUNGEON_BOSS_INTERVAL == 0) then
      $game_player.moveto(10, 15) if $PokemonGlobal.current_dungeon_floor != 0
      # anti boss dupe, (basically in some conditions if the player captures or defeats the boss and then saves the temp switch could reset letting them have another attempt)
      # so the idea here is that we teleport them past the boss block so if it does respawn they cant challenge it and are forced to move on, preventing duplicate boss attempts
    end

    scene.spriteset.addUserSprite(LocationWindow.new($PokemonGlobal.current_dungeon_floor > 0 ? "#{$game_map.name} #{$PokemonGlobal.current_dungeon_floor}F" : "#{$game_map.name}"))
  }
)
