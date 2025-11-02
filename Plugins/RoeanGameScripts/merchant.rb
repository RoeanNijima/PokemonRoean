
MAX_TM = 100
LEAGUE_ITEMS = {
  "POKEBALLS" => [
    { "item" => :POKEBALL,    "badges" => 0 },   # Standard
    { "item" => :GREATBALL,   "badges" => 1 },   # Better catch rate
    { "item" => :ULTRABALL,   "badges" => 2 },   # High catch rate
    { "item" => :MASTERBALL,  "badges" => 4 },   # Guaranteed catch
    { "item" => :FASTBALL,    "badges" => 2 },   # 4× vs fast Pokémon
    { "item" => :LEVELBALL,   "badges" => 2 },   # Based on level comparison
    { "item" => :NETBALL,     "badges" => 2 },   # 3.5× vs Water/Bug types
    { "item" => :HEAVYBALL,   "badges" => 3 },   # Weight-based modifier
    { "item" => :LOVEBALL,    "badges" => 3 },   # 8× vs same species opposite gender
    { "item" => :FRIENDBALL,  "badges" => 3 },   # Sets friendship to 200
    { "item" => :MOONBALL,    "badges" => 3 },   # 4× vs Moon Stone evolvers
    { "item" => :DIVEBALL,    "badges" => 3 },   # 3.5× in water battles
    { "item" => :NESTBALL,    "badges" => 3 },   # Better vs low-level Pokémon
    { "item" => :REPEATBALL,  "badges" => 4 },   # 3.5× if already caught
    { "item" => :TIMERBALL,   "badges" => 4 },   # Increases catch rate over turns
    { "item" => :LUXURYBALL,  "badges" => 4 },   # Boosts friendship gain
    { "item" => :DUSKBALL,    "badges" => 4 },   # 3× in caves or at night
    { "item" => :HEALBALL,    "badges" => 4 },   # Fully restores caught Pokémon
    { "item" => :QUICKBALL,   "badges" => 4 }    # 5× if used on first turn
  ],

  "POTIONS" => [
    { "item" => :POTION,        "badges" => 0 },
    { "item" => :SUPERPOTION,   "badges" => 1 },
    { "item" => :HYPERPOTION,   "badges" => 3 },
    { "item" => :MAXPOTION,     "badges" => 5 },
    { "item" => :FULLRESTORE,   "badges" => 7 },
    { "item" => :REVIVE,        "badges" => 4 },
    { "item" => :MAXREVIVE,     "badges" => 8 },
    # Status heals
    { "item" => :ANTIDOTE,      "badges" => 0 },
    { "item" => :PARALYZEHEAL,  "badges" => 0 },
    { "item" => :AWAKENING,     "badges" => 1 },
    { "item" => :BURNHEAL,      "badges" => 1 },
    { "item" => :ICEHEAL,       "badges" => 1 },
    { "item" => :FULLHEAL,      "badges" => 3 }
  ],

  "ITEMS" => [
    { "item" => :ESCAPEROPE,    "badges" => 1 },
    { "item" => :REPEL,         "badges" => 0 },
    { "item" => :SUPERREPEL,    "badges" => 1 },
    { "item" => :MAXREPEL,      "badges" => 2 },
    { "item" => :FIRESTONE,     "badges" => 2 },
    { "item" => :WATERSTONE,    "badges" => 2 },
    { "item" => :THUNDERSTONE,  "badges" => 2 },
    { "item" => :LEAFSTONE,     "badges" => 2 },
    { "item" => :MOONSTONE,     "badges" => 2 },
    { "item" => :SUNSTONE,      "badges" => 2 },
    { "item" => :DUSKSTONE,     "badges" => 2 },
    { "item" => :DAWNSTONE,     "badges" => 2 },
    { "item" => :ICESTONE,      "badges" => 2 },
    { "item" => :EVOSTONE,      "badges" => 2 },
  ],

  "TRAINING" => [
    # EV ITEMS
    { "item" => :POWERWEIGHT, "badges" => 0 },
    { "item" => :POWERBRACER, "badges" => 0 },
    { "item" => :POWERBELT,   "badges" => 0 },
    { "item" => :POWERLENS,   "badges" => 0 },
    { "item" => :POWERBAND,   "badges" => 0 },
    { "item" => :POWERANKLET, "badges" => 0 },
    { "item" => :HEALTHFEATHER, "badges" => 4 },
    { "item" => :MUSCLEFEATHER, "badges" => 4 },
    { "item" => :RESISTFEATHER, "badges" => 4 },
    { "item" => :GENIUSFEATHER, "badges" => 4 },
    { "item" => :CLEVERFEATHER, "badges" => 4 },
    { "item" => :SWIFTFEATHER,  "badges" => 4 },
    { "item" => :HPUP,          "badges" => 8 },
    { "item" => :PROTEIN,       "badges" => 8 },
    { "item" => :IRON,          "badges" => 8 },
    { "item" => :CALCIUM,       "badges" => 8 },
    { "item" => :ZINC,          "badges" => 8 },
    { "item" => :CARBOS,        "badges" => 8 },
    # NATURE ITEMS
    { "item" => :ADAMANTMINT,      "badges" => 8 },
    { "item" => :BOLDMINT,         "badges" => 8 },
    { "item" => :BRAVEMINT,        "badges" => 8 },
    { "item" => :CALMMINT,         "badges" => 8 },
    { "item" => :CAREFULMINT,      "badges" => 8 },
    { "item" => :GENTLEMINT,       "badges" => 8 },
    { "item" => :HARDYMINT,        "badges" => 8 },
    { "item" => :HASTYMINT,        "badges" => 8 },
    { "item" => :IMPISHMINT,       "badges" => 8 },
    { "item" => :JOLLYMINT,        "badges" => 8 },
    { "item" => :LAXMINT,          "badges" => 8 },
    { "item" => :LONELYMINT,       "badges" => 8 },
    { "item" => :MILDMINT,         "badges" => 8 },
    { "item" => :MODESTMINT,       "badges" => 8 },
    { "item" => :NAIVEMINT,        "badges" => 8 },
    { "item" => :NAUGHTYMINT,      "badges" => 8 },
    { "item" => :QUIETMINT,        "badges" => 8 },
    { "item" => :RASHMINT,         "badges" => 8 },
    { "item" => :RELAXEDMINT,      "badges" => 8 },
    { "item" => :SASSYMINT,        "badges" => 8 },
    { "item" => :SERIOUSMINT,      "badges" => 8 },
    { "item" => :TIMIDMINT,        "badges" => 8 }
  ],

  "BERRIES" => [
    { "item" => :CHERIBERRY,    "badges" => 0 },
    { "item" => :CHESTOBERRY,   "badges" => 0 },
    { "item" => :PECHABERRY,    "badges" => 0 },
    { "item" => :RAWSTBERRY,    "badges" => 0 },
    { "item" => :ASPEARBERRY,   "badges" => 0 },
    { "item" => :LEPPABERRY,    "badges" => 0 },
    { "item" => :ORANBERRY,     "badges" => 0 },
    { "item" => :PERSIMBERRY,   "badges" => 0 },
    { "item" => :LUMBERRY,      "badges" => 0 },
    { "item" => :SITRUSBERRY,   "badges" => 0 },
    { "item" => :FIGYBERRY,     "badges" => 0 },
    { "item" => :WIKIBERRY,     "badges" => 0 },
    { "item" => :MAGOBERRY,     "badges" => 0 },
    { "item" => :AGUAVBERRY,    "badges" => 0 },
    { "item" => :IAPAPABERRY,   "badges" => 0 },
    { "item" => :RAZZBERRY,     "badges" => 0 },
    { "item" => :BLUKBERRY,     "badges" => 0 },
    { "item" => :NANABBERRY,    "badges" => 0 },
    { "item" => :WEPEARBERRY,   "badges" => 0 },
    { "item" => :PINAPBERRY,    "badges" => 0 },
    { "item" => :POMEGBERRY,    "badges" => 0 },
    { "item" => :KELPSYBERRY,   "badges" => 0 },
    { "item" => :QUALOTBERRY,   "badges" => 0 },
    { "item" => :HONDEWBERRY,   "badges" => 0 },
    { "item" => :GREPABERRY,    "badges" => 0 },
    { "item" => :TAMATOBERRY,   "badges" => 0 },
    { "item" => :OCCABERRY,     "badges" => 0 },
    { "item" => :PASSHOBERRY,   "badges" => 0 },
    { "item" => :WACANBERRY,    "badges" => 0 },
    { "item" => :RINDOBERRY,    "badges" => 0 },
    { "item" => :YACHEBERRY,    "badges" => 0 },
    { "item" => :CHOPLEBERRY,   "badges" => 0 },
    { "item" => :KEBIABERRY,    "badges" => 0 },
    { "item" => :SHUCABERRY,    "badges" => 0 },
    { "item" => :COBABERRY,     "badges" => 0 },
    { "item" => :PAYAPABERRY,   "badges" => 0 },
    { "item" => :TANGABERRY,    "badges" => 0 },
    { "item" => :CHARTIBERRY,   "badges" => 0 },
    { "item" => :KASIBBERRY,    "badges" => 0 },
    { "item" => :HABANBERRY,    "badges" => 0 },
    { "item" => :COLBURBERRY,   "badges" => 0 },
    { "item" => :BABIRIBERRY,   "badges" => 0 },
    { "item" => :CHILANBERRY,   "badges" => 0 },
    { "item" => :LIECHIBERRY,   "badges" => 0 },
    { "item" => :GANLONBERRY,   "badges" => 0 },
    { "item" => :SALACBERRY,    "badges" => 0 },
    { "item" => :PETAYABERRY,   "badges" => 0 },
    { "item" => :APICOTBERRY,   "badges" => 0 },
    { "item" => :LANSATBERRY,   "badges" => 0 },
    { "item" => :STARFBERRY,    "badges" => 0 },
    { "item" => :ENIGMABERRY,   "badges" => 0 },
    { "item" => :MICLEBERRY,    "badges" => 0 },
    { "item" => :CUSTAPBERRY,   "badges" => 0 },
    { "item" => :JABOCABERRY,   "badges" => 0 },
    { "item" => :ROWAPBERRY,    "badges" => 0 },
    { "item" => :ROSELIBERRY,   "badges" => 0 },
    { "item" => :KEEBERRY,      "badges" => 0 },
    { "item" => :MARANGABERRY,  "badges" => 0 },
    { "item" => :HOPOBERRY,     "badges" => 0 }
  ],

  "HELDITEMS" => [
    { "item" => :FOCUSSASH,     "badges" => 0 },
    { "item" => :AIRBALLOON,    "badges" => 0 },
    { "item" => :EVERSTONE,     "badges" => 0 },
    { "item" => :EVIOLITE,      "badges" => 2 },
    { "item" => :LEFTOVERS,     "badges" => 2 },
    { "item" => :SCOPELENS,     "badges" => 3 },
    { "item" => :LUCKYEGG,      "badges" => 0 },
    { "item" => :BLACKBELT,     "badges" => 3 },
    { "item" => :CHARCOAL,      "badges" => 3 },
    { "item" => :MYSTICWATER,   "badges" => 3 },
    { "item" => :MIRACLESEED,   "badges" => 3 },
    { "item" => :MAGNET,        "badges" => 3 },
    { "item" => :NEVERMELTICE,  "badges" => 3 },
    { "item" => :TWISTEDSPOON,  "badges" => 3 },
    { "item" => :BLACKGLASSES,  "badges" => 3 },
    { "item" => :SOFTSAND,      "badges" => 3 },
    { "item" => :SHELLBELL,     "badges" => 3 },
    { "item" => :FOCUSBAND,     "badges" => 3 },

    # --- Mega Stones (unlock at 4+ badges) ---
    { "item" => :GENGARITE,       "badges" => 4 },
    { "item" => :GARDEVOIRITE,    "badges" => 4 },
    { "item" => :AMPHAROSITE,     "badges" => 4 },
    { "item" => :VENUSAURITE,     "badges" => 4 },
    { "item" => :CHARIZARDITEX,   "badges" => 4 },
    { "item" => :BLASTOISINITE,   "badges" => 4 },
    { "item" => :BLAZIKENITE,     "badges" => 4 },
    { "item" => :MEDICHAMITE,     "badges" => 4 },
    { "item" => :HOUNDOOMINITE,   "badges" => 4 },
    { "item" => :AGGRONITE,       "badges" => 4 },
    { "item" => :BANETTITE,       "badges" => 4 },
    { "item" => :TYRANITARITE,    "badges" => 4 },
    { "item" => :SCIZORITE,       "badges" => 4 },
    { "item" => :PINSIRITE,       "badges" => 4 },
    { "item" => :AERODACTYLITE,   "badges" => 4 },
    { "item" => :LUCARIONITE,     "badges" => 4 },
    { "item" => :ABOMASITE,       "badges" => 4 },
    { "item" => :KANGASKHANITE,   "badges" => 4 },
    { "item" => :GYARADOSITE,     "badges" => 4 },
    { "item" => :ABSOLITE,        "badges" => 4 },
    { "item" => :CHARIZARDITEY,   "badges" => 4 },
    { "item" => :ALAKAZITE,       "badges" => 4 },
    { "item" => :HERACRONITE,     "badges" => 4 },
    { "item" => :MAWILITE,        "badges" => 4 },
    { "item" => :MANECTITE,       "badges" => 4 },
    { "item" => :GARCHOMPITE,     "badges" => 4 },
    { "item" => :LATIASITE,       "badges" => 4 },
    { "item" => :LATIOSITE,       "badges" => 4 },
    { "item" => :SWAMPERTITE,     "badges" => 4 },
    { "item" => :SCEPTILITE,      "badges" => 4 },
    { "item" => :SABLENITE,       "badges" => 4 },
    { "item" => :ALTARIANITE,     "badges" => 4 },
    { "item" => :GALLADITE,       "badges" => 4 },
    { "item" => :AUDINITE,        "badges" => 4 },
    { "item" => :METAGROSSITE,    "badges" => 4 },
    { "item" => :SHARPEDONITE,    "badges" => 4 },
    { "item" => :SLOWBRONITE,     "badges" => 4 },
    { "item" => :STEELIXITE,      "badges" => 4 },
    { "item" => :PIDGEOTITE,      "badges" => 4 },
    { "item" => :GLALITITE,       "badges" => 4 },
    { "item" => :CAMERUPTITE,     "badges" => 4 },
    { "item" => :LOPUNNITE,       "badges" => 4 },
    { "item" => :SALAMENCITE,     "badges" => 4 },
    { "item" => :BEEDRILLITE,     "badges" => 4 },
    # POST ELITE CHALLENGES
    { "item" => :REDORB,          "badges" => 12},
    { "item" => :BLUEORB,         "badges" => 12},
    { "item" => :MEWTWONITEX,     "badges" => 12},
    { "item" => :MEWTWONITEY,     "badges" => 12},
    { "item" => :DIANCITE,        "badges" => 12},
  ]
}

def pbLeagueMarket()
  badge_count = $player.badge_count
  categories = LEAGUE_ITEMS.keys + ["TMS"] + ["RETURN"]
  choice = pbMessage("Welcome to the League Market.\nWhich category would you like to browse?",
                     categories, -1)
  return if choice < 0

  chosen = categories[choice]
  items = []

  return if chosen == "RETURN"

  if chosen == "TMS"
    for i in 1..MAX_TM
      tm_id = format("TM%02d", i).to_sym
      items << tm_id
    end
  else
    LEAGUE_ITEMS[chosen].each do |data|
      items << data["item"] if badge_count >= data["badges"]
    end
  end

  pbPokemonMart(items)
end
