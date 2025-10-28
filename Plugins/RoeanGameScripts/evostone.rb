ItemHandlers::UseOnPokemon.add(:EVOSTONE, proc { |item, qty, pkmn, scene|
  if pkmn.shadowPokemon?
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end

  evolutions = pkmn.species_data.get_evolutions(true)
  trade_evo = nil

  evolutions.each do |evo|
    method = evo[1]
    next unless [:Trade, :TradeItem].include?(method)
    trade_evo = evo
    break
  end

  if !trade_evo
    scene.pbDisplay(_INTL("It won't have any effect."))
    next false
  end

  if pkmn.level >= GameData::GrowthRate.max_level
    if !Settings::RARE_CANDY_USABLE_AT_MAX_LEVEL
      scene.pbDisplay(_INTL("It won't have any effect."))
      next false
    end
  end

  new_species = trade_evo[0]
  pbFadeOutInWithMusic do
    evo = PokemonEvolutionScene.new
    evo.pbStartScreen(pkmn, new_species)
    evo.pbEvolution
    evo.pbEndScreen
    scene.pbRefresh if scene.is_a?(PokemonPartyScreen)
  end

  next true
})
