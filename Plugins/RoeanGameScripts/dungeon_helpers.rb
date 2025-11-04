
$DUNGEON_VALID_HELD_ITEMS  ||= nil
$TRAINER_MEGA_STONE_CHANCE = 32 # 1/x
$TRAINER_RAREMON_CHANCE = 128 # 1/x
$TRAINER_ULTRAMON_CHANCE = 256 # 1/x
$DUNGEON_EXTRA_SHINY_ROLLS = 0

def pbGetDungeonTeamSize
  floor = $PokemonGlobal.current_dungeon_floor
  return 6 if floor >= 100
  return rand(4..6) if floor >= 75
  return rand(3..4) if floor >= 50
  return rand(2..3) if floor >= 25
  return rand(1..2)
end

def pbGetDungeonHeldItems
  return $DUNGEON_VALID_HELD_ITEMS if $DUNGEON_VALID_HELD_ITEMS

  valid_items = []
  GameData::Item.each do |item|
    next if item.is_key_item?
    next valid_items << item.id if item.has_flag?("Berry")
    next valid_items << item.id if item.has_flag?("Fling_10")
    next valid_items << item.id if item.has_flag?("Fling_30")
    next valid_items << item.id if item.has_flag?("Fling_80")
    next valid_items << item.id if item.has_flag?("Fling_100")
    next valid_items << item.id if item.is_mega_stone?
  end

  $DUNGEON_VALID_HELD_ITEMS = valid_items.uniq
  return $DUNGEON_VALID_HELD_ITEMS
end

def pbGetDungeonMegaStonesForSpecies(species)
  stones = []
  GameData::Species.each do |form_data|
    next unless form_data.mega_stone
    next unless form_data.species == species
    stones << form_data.mega_stone
  end
  return stones.uniq
end

def pbGetDungeonHeldItemForSpecies(species)
  valid_items = pbGetDungeonHeldItems
  item = valid_items.sample

  mega_stones = pbGetDungeonMegaStonesForSpecies(species)
  if mega_stones.any? && rand($TRAINER_MEGA_STONE_CHANCE) == 0
    item = mega_stones.sample
  end
  return item
end

def pbEvolveEncounter(species, level)
  species = species.species if species.is_a?(Pokemon)

  loop do
    evo_data = GameData::Species.get(species).get_evolutions
    break if evo_data.empty?

    valid_evos = evo_data.select do |evo_species, method, param|
      (method == :Level && level >= param) ||
      (method != :Level && level >= 35)
    end
    break if valid_evos.empty?

    species, = valid_evos.sample
  end

  return species
end

def pbGenerateDungeonTrainerMon
  species =
    if rand($TRAINER_ULTRAMON_CHANCE).zero?
      pbSampleUltraEncounter()
    elsif rand($TRAINER_RAREMON_CHANCE).zero?
      pbSampleRareEncounter()[0]
    else
      pbGetWeightResult(pbGetRafflePool)
    end

  return nil unless species

  base_level = $PokemonGlobal.current_dungeon_floor > 100 ? pbGetDungeonLevelScale(true) : pbGetDungeonLevelScale(false)
  level = (base_level + rand(-2..2)).clamp(1, Settings::MAXIMUM_LEVEL)

  evolved_species = pbEvolveEncounter(species, level)
  item = pbGetDungeonHeldItemForSpecies(evolved_species)

  {
    :species => evolved_species,
    :level   => level,
    :item    => item
  }
end
