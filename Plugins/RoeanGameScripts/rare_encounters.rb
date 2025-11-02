RARE_ENCOUNTERS = {
  1 => {
    :ARTICUNO => "kantolegend",
    :ZAPDOS => "kantolegend",
    :MOLTRES => "kantolegend"
  },
  2 => {
    :RAIKOU => "raikoubattle",
    :ENTEI => "enteibattle",
    :SUICUNE => "suicunebattle"
  },
  3 => {
    :REGIROCK => "regibattle",
    :REGICE => "regibattle",
    :REGISTEEL => "regibattle"
  },
  4 => {
    :UXIE => "ddptlegend",
    :MESPRIT => "ddptlegend",
    :AZELF => "ddptlegend",
    :PHIONE => "ddptlegend"
  },
  5 => {
    :THUNDURUS => "bwlegend",
    :TORNADUS => "bwlegend",
    :VIRIZION => "bwlegend",
    :TERRAKION => "bwlegend",
    :COBALION => "bwlegend"
  },
  7 => {
    :COSMOG => "usumlegend",
    :TYPENULL => "usumlegend",
    :TAPUKOKO => "usumlegend",
    :TAPULELE => "usumlegend",
    :TAPUBULU => "usumlegend",
    :TAPUFINI => "usumlegend",
    :STAKATAKA => "ultrabeast",
    :CELESTEELA => "ultrabeast",
    :XURKITREE => "ultrabeast",
    :PHEROMOSA => "ultrabeast",
    :BUZZWOLE => "ultrabeast",
    :NIHILEGO => "ultrabeast",
    :GUZZLORD => "ultrabeast",
    :KARTANA => "ultrabeast",
    :POIPOLE => "ultrabeast",
    :BLACEPHALON => "ultrabeast"
  },
  8 => {
    :KUBFU => "swshlegend",
    :MELTAN => "swshlegend",
    :CALYREX => "swshlegend",
    :SPECTRIER => "swshlegend",
    :GLASTRIER => "swshlegend",
    :REGIDRAGO => "swshlegend",
    :REGIELEKI => "swshlegend",
    :ENAMORUS => "swshlegend"
  },
  9 => {
    :TERAPAGOS => "svlegend",
    :CHIYU => "svlegend",
    :TINGLU => "svlegend",
    :CHIENPAO => "svlegend",
    :WOCHIEN => "svlegend",
    :OKIDOGI => "svlegend",
    :FEZANDIPITI => "svlegend",
    :MUNKIDORI => "svlegend",
    :OGERPON => "svlegend"
  }
}

RARE_ENCOUNTER_CHANCE = 512
RARE_ENCOUNTER_BASE_LEVEL = 20
$rare_encounter_data = nil

EventHandlers.add(:on_wild_species_chosen, :choose_if_rare_species,
  proc { |encounter|
    next unless rand(RARE_ENCOUNTER_CHANCE) == 1

    chosen_gen = RARE_ENCOUNTERS.keys.sample
    species, bgm = RARE_ENCOUNTERS[chosen_gen].to_a.sample

    $rare_encounter_data = {
      :species => species,
      :bgm     => bgm
    }

    encounter[0] = species
    $game_temp.force_single_battle = true
  }
)

EventHandlers.add(:on_wild_pokemon_created, :rare_modify,
  proc { |pkmn|
    data = $rare_encounter_data
    next if data.nil?
    $rare_encounter_data = nil

    intended_species = data[:species]
    bgm = data[:bgm]
    was_shiny = pkmn.shiny?

    if pkmn.species != intended_species
      pkmn.species = intended_species
      pkmn.reset_moves
    end

    new_level = [RARE_ENCOUNTER_BASE_LEVEL + (5 * $player.badge_count), 70].min
    pkmn.level = new_level
    pkmn.calc_stats

    pkmn.shiny = true if was_shiny

    if pbResolveAudioFile("Audio/BGM/#{bgm}")
      $PokemonGlobal.nextBattleBGM = bgm
    end
  }
)
