
def pickRandomSpecies()
  arr = []
  GameData::Species.each_species { |s| arr << s }
  return arr.sample
end

SHINY_ODDS_RAW = [
  16,
  8,
  32,
  64,
  128,
  1 # debug odds
]

EventHandlers.add(:on_enter_map, :mutator_expall,
  proc { |_old_map_id|
    $player.has_exp_all = $game_switches[62] # exp.all toggle
  }
)

EventHandlers.add(:on_wild_pokemon_created, :extra_shinyodds,
  proc { |pkmn|
    pkmn.shiny = (rand(SHINY_ODDS_RAW[$game_variables[27] || 0]) == 0) # shiny odds option
  }
)

EventHandlers.add(:on_wild_species_chosen, :mutator_randomizer,
  proc { |encounter|
    if $game_switches[59] then # if randomizer
      $game_temp.force_single_battle = true
      encounter[0] = pickRandomSpecies()
    end
})

class Battle # NoItemsInBattle mutator
    alias __o__pbItemMenu__ pbItemMenu

    def pbItemMenu(*args)
      if $game_switches[61] && trainerBattle? then
        pbDisplay("Can't use items in battle!")
        return false
      end
      return __o__pbItemMenu__(*args)
    end
end
