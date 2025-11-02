GUIDE_INFOS = ["Gym Challenges", "Expeditions", "League Facilities"]

def pbLeagueGuide
  pbMessage("Hello! I'm the official guide for the Pokemon League.")
  pbMessage("How can I help you today?")

  loop do
    cmd = pbMessage("Please select a topic.", GUIDE_INFOS + ["Exit"])
    case cmd
    when 0
      pbGuideGymChallenges()
    when 1
      pbGuideExpeditions()
    when 2
      pbGuideFacilities()
    else
      pbMessage("Good luck, challenger!")
      break
    end
  end
end

#===============================================================================
# Gym Challenges
#===============================================================================
def pbGuideGymChallenges
  gym_options = [
    "Gym 1 (Fighting)",
    "Gym 2 (Water)",
    "Gym 3 (Steel)",
    "Gym 4 (Rock)",
    "Gym 5 (Fairy)",
    "Gym 6 (Grass)",
    "Gym 7 (Fire)",
    "Gym 8 (Ghost)",
    "Beyond Gym 8"
  ]
  cmd = pbMessage("Select a Gym to learn more.", gym_options)
  case cmd
  when 0; pbMessage("\\c[1]Gym 1 - Fighting\\c[0]\nLevel Range: \\c[5]9-13\\c[0]")
  when 1; pbMessage("\\c[1]Gym 2 - Water\\c[0]\nLevel Range: \\c[5]14-21\\c[0]")
  when 2; pbMessage("\\c[1]Gym 3 - Steel\\c[0]\nLevel Range: \\c[5]23-28\\c[0]")
  when 3; pbMessage("\\c[1]Gym 4 - Rock\\c[0]\nLevel Range: \\c[5]31-36\\c[0]")
  when 4; pbMessage("\\c[1]Gym 5 - Fairy\\c[0]\nLevel Range: \\c[5]39-45\\c[0]")
  when 5; pbMessage("\\c[1]Gym 6 - Grass\\c[0]\nLevel Range: \\c[5]49-53\\c[0]")
  when 6; pbMessage("\\c[1]Gym 7 - Fire\\c[0]\nLevel Range: \\c[5]56-60\\c[0]")
  when 7; pbMessage("\\c[1]Gym 8 - Ghost\\c[0]\nLevel Range: \\c[5]62-67\\c[0]")
  when 8; pbMessage("Information beyond Gym 8 is \\c[2]CLASSIFIED\\c[0] under League regulations.")
  end
end

#===============================================================================
# Expeditions
#===============================================================================
def pbGuideExpeditions
  expedition_list = ["Twingrass Plains", "Back"]
  cmd = pbMessage("Select an Expedition area for details.", expedition_list)
  case cmd
  when 0
    pbMessage("\\c[1]Twingrass Plains\\c[0]\n" \
              "Environment: \\c[5]Grass, Cave\\c[0]\n" \
              "Level Range: \\c[5]8-12\\c[0]\n" \
              "Badge Requirement: \\c[5]1+\\c[0]\n" \
              "Encounter Types: \\c[5]NORMAL,GRASS,BUG,POISON,FLYING\\c[0]")
  end
end

#===============================================================================
# League Facilities
#===============================================================================
def pbGuideFacilities
  facility_list = [
    "League Elevator",
    "Medical Department",
    "League Store",
    "Back"
  ]
  cmd = pbMessage("Select a Facility for details.", facility_list)
  case cmd
  when 0
    pbMessage("\\c[1]League Elevator\\c[0]\n" \
              "The League Elevator connects every department of the Pokemon League together.\n" \
              "It provides access to key areas for registered Gym Challengers and League staff.")
  when 1
    pbMessage("\\c[1]Medical Department\\c[0]\n" \
              "Functions as the League's Pokemon Center.\n" \
              "Restores HP and status conditions for all party members free of charge.")
  when 2
    pbGuideLeagueStore()
  end
end

def pbGuideLeagueStore
  pbMessage("\\c[1]League Store\\c[0]\n" \
            "The League Store has three service counters:\n\n" \
            "\\c[5]Top Counter (Mart Clerk):\\c[0]\n" \
            "Sells League-approved supplies such as Poke Balls and Potions.\n\n" \
            "\\c[5]Middle Counter (Expeditions Clerk - Green Uniform):\\c[0]\n" \
            "Manages expedition access and registration.\n\n" \
            "\\c[5]Bottom Counter (Imports Manager):\\c[0]\n" \
            "Handles package redemptions and the \\c[1]Egg Raffle\\c[0] program.")
end
