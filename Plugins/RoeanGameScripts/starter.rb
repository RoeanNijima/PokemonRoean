
POKE_STARTERS = [
  "BULBASAUR",
  "CHARMANDER",
  "SQUIRTLE",
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
  while true do
    starter_index = pbMessage("Choose a Pokemon.", POKE_STARTERS)
    choice = pbMessage("\\bDo I really want " + POKE_STARTERS[starter_index] + "?", ["YES", "NO"])

    if choice == 0 then break end
  end

  pbAddPokemon(POKE_STARTERS[starter_index].to_sym, 5)
end
