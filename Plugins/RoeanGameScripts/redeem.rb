#overrides
class Player
  attr_accessor :redeemed_codes
end

# functions

def getCodesList
  timestamp = Time.now.to_i
  url = "https://raw.githubusercontent.com/RoeanNijima/PokemonRoeanAPI/main/codes.rb?#{timestamp}"
  begin
    ruby_text = pbDownloadToString(url)
    return eval(ruby_text)
  rescue => e
    pbMessage("Failed to connect to server. Try again later.")
    return {}
  end
end

def pbBeginRedeemCode
  message = pbMessageFreeText(
    _INTL("Enter Code."),
    _INTL(""),
    false,
    256,
    Graphics.width
  )
  code = message.strip

  $player.redeemed_codes ||= []
  if $player.redeemed_codes.include?(code)
     pbMessage(_INTL("You’ve already redeemed this code!"))
     return
  end
  codes = getCodesList

  if codes.has_key?(code)
    data = codes[code]

    if data["pokemon"]
      for pkmn_entry in data["pokemon"]
        parts = pkmn_entry.split(",")
        species = parts[0].upcase
        level = parts[1].to_i || 1
        shiny = parts[2].to_i || 0 == 1
        nick = parts[3]

        pkmn = Pokemon.new(species.to_sym, level)
        pkmn.shiny = shiny

        pkmn.owner.id = $player.make_foreign_ID
        pkmn.owner.gender = 3
        if nick then pkmn.name = nick end
        pkmn.owner.name = "Gift"
        pkmn.obtain_text = "Gift"

        pbAddPokemon(pkmn)
      end
    end

    if data["items"]
      for item_entry in data["items"]
        parts = item_entry.split(",")
        item = parts[0].upcase
        qty = parts[1].to_i || 1

        pbReceiveItem(item.to_sym, qty)
      end
    end
    $player.redeemed_codes << code
    pbMessage(_INTL("Code redeemed successfully!"))
  else
    pbMessage(_INTL("Invalid or expired code."))
  end
end
