
POKE_STARTERS = [
  "BULBASAUR",
  "CHARMANDER",
  "SQUIRTLE",
  "PIKACHU",
  "EEVEE",
  "CHIKORITA",
  "CYNDAQUIL",
  "TOTODILE",
  "TREECKO",
  "TORCHIC",
  "MUDKIP",
  "TURTWIG",
  "CHIMCHAR",
  "PIPLUP",
  "SNIVY",
  "TEPIG",
  "OSHAWOTT",
  "CHESPIN",
  "FENNEKIN",
  "FROAKIE",
  "ROWLET",
  "LITTEN",
  "POPPLIO",
  "GROOKEY",
  "SCORBUNNY",
  "SOBBLE",
  "SPRIGATITO",
  "FUECOCO",
  "QUAXLY",
]

def beginStarterSelect()
  viewport = Viewport.new(0, 0, Graphics.width, Graphics.height)
  viewport.z = 99999
  sprite = PokemonSprite.new(viewport)
  sprite.visible = false

  starters = POKE_STARTERS.map { |s| Pokemon.new(s.to_sym, 5) }
  chosen_index = nil

  sprite_x = Graphics.width / 2
  sprite_y = Graphics.height / 2

  loop do
    starter_index = pbMessage("Choose a Pokémon.", POKE_STARTERS)
    chosen_pokemon = starters[starter_index]

    sprite.setPokemonBitmap(chosen_pokemon)
    sprite.ox = sprite.bitmap.width / 2
    sprite.oy = sprite.bitmap.height / 2
    sprite.x = sprite_x
    sprite.y = sprite_y
    sprite.visible = true

    pbSEPlay("Shiny sparkle") if chosen_pokemon.shiny?
    pbMessage("There is something different about this pokemon...") if chosen_pokemon.shiny?

    Graphics.update
    Input.update

    choice = pbMessage("\\bDo I really want #{chosen_pokemon.name}?", ["YES", "NO"])
    if choice == 0
      chosen_index = starter_index
      break
    end
    sprite.visible = false
  end

  pbAddPokemon(starters[chosen_index]) if chosen_index
  sprite.dispose
  viewport.dispose
end
