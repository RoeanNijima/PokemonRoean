
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
    #pkmn.shiny = (rand(SHINY_ODDS_RAW[$game_variables[27] || 0]) == 0) # shiny odds option
    # deprecated in favour of hooking the shiny? function
  }
)

EventHandlers.add(:on_wild_species_chosen, :mutator_randomizer,
  proc { |encounter|
    if $game_switches[59] then # if randomizer
      $game_temp.force_single_battle = true
      encounter[0] = pickRandomSpecies()
    end
})

class Pokemon
  alias __o__shiny__ shiny?
  alias __o__hp__ hp=

  def shiny?
    if @shiny.nil?
      @shiny = (rand(SHINY_ODDS_RAW[$game_variables[27] || 0]) == 0) # shiny odds modifier
    end
    return @shiny
  end

  def hp=(value) # Permadeath modifier (excludes shiny pokemon)
    __o__hp__(value)

    if self.shiny? then return end

    if $game_switches[60] && @hp <= 0
      if $player && $player.party.include?(self)
        idx = $player.party.index(self)
        $player.party.delete_at(idx)
      end
    end
  end

end

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
