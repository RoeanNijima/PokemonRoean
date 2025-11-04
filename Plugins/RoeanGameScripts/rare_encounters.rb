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
    :LANDORUS => "bwlegend",
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
    :CHIYU => "svlegend",
    :TINGLU => "svlegend",
    :CHIENPAO => "svlegend",
    :WOCHIEN => "svlegend",
    :OKIDOGI => "svlegend",
    :FEZANDIPITI => "svlegend",
    :MUNKIDORI => "svlegend",
    :OGERPON => "svlegend",
    :TERAPAGOS => "svlegend",
    :PECHARUNT => "svlegend"
  }
}

ULTRA_ENCOUNTERS = [
  :NECROZMA,
  :ETERNATUS,
  :MEW,
  :YVELTAL,
  :XERNEAS,
  :LUNALA,
  :CELEBI,
  :NAGANADEL,
  :SOLGALEO,
  :RAYQUAZA,
  :SHAYMIN,
  :ZAMAZENTA,
  :ZACIAN,
  :DARKRAI,
  :MANAPHY,
  :VICTINI,
  :RESHIRAM,
  :ZEKROM,
  :KYUREM,
  :KELDEO,
  :MELOETTA,
  :GENESECT,
  :CRESSELIA,
  :GIRATINA,
  :ZYGARDE,
  :REGIGIGAS,
  :HOOPA,
  :VOLCANION,
  :SILVALLY,
  :HEATRAN,
  :PALKIA,
  :DIALGA,
  :DEOXYS,
  :JIRACHI,
  :GROUDON,
  :KYOGRE,
  :LATIOS,
  :LATIAS,
  :MAGEARNA,
  :MARSHADOW,
  :HOOH,
  :ZERAORA,
  :MELMETAL,
  :LUGIA,
  :ZARUDE,
  :MEWTWO,
  :KORAIDON,
  :MIRAIDON,
  :DIANCIE
]

RARE_ENCOUNTER_CHANCE = 1024
RARE_ENCOUNTER_BASE_LEVEL = 10
RARE_ENCOUNTER_BADGE_REQUIRED = 2
$rare_encounter_data = nil

def pbSampleUltraEncounter()
  return ULTRA_ENCOUNTERS.sample
end

def pbSampleRareEncounter()
  chosen_gen = RARE_ENCOUNTERS.keys.sample
  return RARE_ENCOUNTERS[chosen_gen].to_a.sample
end

EventHandlers.add(:on_wild_species_chosen, :choose_if_rare_species,
  proc { |encounter|
    next if $infinite_dungeon_mapids.include?($game_map.map_id)
    next unless $player.badge_count >= RARE_ENCOUNTER_BADGE_REQUIRED
    next unless rand(RARE_ENCOUNTER_CHANCE) == 1

    species, bgm = pbSampleRareEncounter()

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
