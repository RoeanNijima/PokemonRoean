
def log_basic_species
  list = []
  GameData::Species.each_species do |species|
    next if species.form != 0
    next unless species.get_previous_species == species.species
    next unless species.base_stat_total <= 490
    next if species.has_flag?("Legendary") || species.has_flag?("Mythical") ||
            species.has_flag?("UltraBeast") || species.has_flag?("ExcludeFromDex")
    list << [species.species, species.catch_rate]
  end

  # Sort by catch rate descending (common first)
  list.sort_by! { |s| -s[1] }

  File.open("basic_species_log.txt", "w") do |f|
    f.puts("{")
    list.each_with_index do |(name, rate), i|
      comma = (i < list.length - 1) ? "," : ""
      f.puts("  :#{name} => #{rate}#{comma}")
    end
    f.puts("}")
  end

  pbMessage("Log saved to basic_species_log.txt")
end
