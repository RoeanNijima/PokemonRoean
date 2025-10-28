
# Difficulty $game_variables[26]
DIFFICULTY_TABLE = [
  "EASY",
  "NORMAL",
  "HARD",
]

MUTATORS = [
    {
      "name" => "Exp. All",
      "switch" => 62
    },
    {
      "name" => "Randomizer",
      "switch" => 59
    },
    {
      "name" => "Permadeath",
      "switch" => 60
    },
    {
      "name" => "NoBattleItems",
      "switch" => 61
    }
]

EXTRA = [
  {
    "name" => "Shiny Odds",
    "options" => ["1/4096 (DEFAULT)", "1/8192", "1/2048", "1/1024", "1/512"],
    "variable" => 27
  }
]

def confirmSettings()
  cmd = pbMessage("Are you sure you want to confirm these settings?\nSettings cannot be changed later!", ["YES", "NO"])

  if cmd == 0 then return true else return false end
end

def selectDifficulty()
  cmd = pbMessage("Select Difficulty\nCurrent Difficulty: " + DIFFICULTY_TABLE[$game_variables[26]], DIFFICULTY_TABLE + ["CANCEL"])

  if cmd == DIFFICULTY_TABLE.length() then return end

  $game_variables[26] = cmd
  pbMessage("Difficulty has been set to " + DIFFICULTY_TABLE[$game_variables[26]] + ".")
end

def pbGetMutatorEnabled(name)
  for mutator in MUTATORS do
    if $game_switches[mutator["switch"]] && mutator["name"] == name then
      return true
    end
  end
  return false
end

def getMutatorEnabled(idx)
  return $game_switches[MUTATORS[idx]["switch"]] ? true : false
end

def selectMutator(idx)
  cmd = pbMessage("Enable " + MUTATORS[idx]["name"] + "?\nCurrent Status: " + (getMutatorEnabled(idx) ? "Enabled" : "Disabled"), ["ENABLE", "DISABLE", "CANCEL"])

  if cmd == 0 then
    $game_switches[MUTATORS[idx]["switch"]] = true
  elsif cmd == 1
    $game_switches[MUTATORS[idx]["switch"]] = false
  else
    return
  end

  pbMessage(MUTATORS[idx]["name"] + " has been set to " + (getMutatorEnabled(idx) ? "Enabled" : "Disabled") + ".")
end

def getExtraState(idx)
  return EXTRA[idx]["options"][$game_variables[EXTRA[idx]["variable"]]]
end

def selectExtra(idx)
  cmd = pbMessage("Enable " + EXTRA[idx]["name"] + "?\nCurrent Status: " + getExtraState(idx), EXTRA[idx]["options"] + ["CANCEL"])

  if cmd == EXTRA[idx]["options"].length() then return end

  $game_variables[EXTRA[idx]["variable"]] = cmd

  pbMessage(EXTRA[idx]["name"] + " has been set to " + getExtraState(idx) + ".")
end

def pbConfigureWorld()
  while true do
    cmd = pbMessage("Configure World.", [
        "Difficulty",
        "Mutators",
        "Extra",
        "Confirm"
    ])

    case cmd
    when 0
      selectDifficulty()
    when 1
      cmd_mutator = pbMessage("Select a Mutator.", MUTATORS.map { |m| m["name"] } + ["BACK"])
      if cmd_mutator == MUTATORS.length() then next end
      selectMutator(cmd_mutator)
    when 2
      cmd_extra = pbMessage("Select an Option.", EXTRA.map { |m| m["name"] } + ["BACK"])
      if cmd_extra == EXTRA.length() then next end
      selectExtra(cmd_extra)
    when 3
      if confirmSettings() then break end
    else
      nil
    end

  end
end
