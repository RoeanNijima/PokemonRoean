
# cur_floor $game_variables[10]
# next_floor $game_variables[11]

GYM_CHALLENGES = [
    "THE HUB", # league floor (no challenge)
    "GYM 1",
    "GYM 2",
    "GYM 3",
    "GYM 4",
    "GYM 5",
    "GYM 6",
    "GYM 7",
    "GYM 8",
    "ELITE 1",
    "ELITE 2",
    "ELITE 3",
    "ELITE 4",
    "CHAMPION"
]

GYM_TRAINERS = [
  {
    "look" => "trainer_LEADER_Abel",
    "type" => "LEADER_Abel",
    "name" => "ABEL",
    "script" => proc {
      pbMessage("ABEL: Let's begin!")
    }
  }, # abel
  {
    "look" => "trainer_LEADER_Hudson",
    "type" => "LEADER_Hudson",
    "name" => "HUDSON",
    "script" => proc {
      pbMessage("HUDSON: It's my turn to win!")
      setBattleRule("midbattleScript", {
        "AfterLastSendOut_foe" => {
            "battlerHPCap" => 25
        },
        "BattlerReachedHPCap_CLOYSTER_foe" => {
            "speech" => "THIS CANT BE HAPPENING!",
            "text" => [1, "{1} powered up!"],
            "changeBGM" => ["JohtoGymRemix", 1],
            "battlerHP" => 100,
            "battlerStatus" => :NONE,
            "battlerStats" => [:DEFENSE, 1, :SPECIAL_DEFENSE, 1, :SPEED, 1],
            "playCry" => :CLOYSTER
        },
      })
    }
  }, # hudson
  {
    "look" => "trainer_LEADER_Clara",
    "type" => "LEADER_Clara",
    "name" => "CLARA",
    "script" => proc {
      pbMessage("CLARA: I hope you're ready to lose!")
    }
  }, # clara
  {
    "look" => "trainer_LEADER_Xhaka",
    "type" => "LEADER_Xhaka",
    "name" => "XHAKA",
    "script" => proc {
      pbMessage("XHAKA: Survive this!")
      setBattleRule("midbattleScript", {
        "AfterLastSendOut_foe" => {
            "disableMegas" => true,
            "battlerHPCap" => 25
        },
        "BattlerReachedHPCap_TYRANITAR_foe" => {
            "disableMegas" => false,
            "speech" => "I WONT LET IT END LIKE THIS!\nSHOW THEM TYRANITAR!",
            "text" => [1, "{1} powered up!"],
            "megaEvolve" => true,
            "changeBGM" => ["JohtoGymRemix", 1],
            "battlerHP" => 100,
            "battlerStatus" => :NONE,
            "battlerStats" => :ResetLowered,
            "playCry" => :TYRANITAR
        },
      })
    },
    "post_script" => proc {
      pbMessage("XHAKA: Before you leave you should take this.")
      pbItemBall(:MEGARING)
      pbMessage("XHAKA: This will let you channel the power of \\c[2]MEGA EVOLUTION\\c[0].")
    }}, # xhaka
  {
    "look" => "trainer_LEADER_Maya",
    "type" => "LEADER_Maya",
    "name" => "MAYA",
    "script" => proc {
      pbMessage("MAYA: My pokemon can be as fierce as they are kind!")
    }
  },
  {
    "look" => "trainer_LEADER_Erika",
    "type" => "LEADER_Erika",
    "name" => "ERIKA",
    "script" => proc {
      pbMessage("Erika: I am so glad that there are strong Trainers like you.")
      setBattleRule("midbattleScript", {
        "AfterLastSendOut_foe" => {
            "disableMegas" => true,
            "battlerHPCap" => 25
        },
        "BattlerReachedHPCap_VENUSAUR_foe" => {
            "disableMegas" => false,
            "speech" => "Let them feel the power of grass types VENUSAUR!",
            "text" => [1, "{1} powered up!"],
            "megaEvolve" => true,
            "changeBGM" => ["kantogymleaderemix", 1],
            "battlerHP" => 100,
            "battlerStatus" => :NONE,
            "battlerStats" => :ResetLowered,
            "playCry" => :TYRANITAR
        },
      })
    }
  },
]

def pbAttemptChallenge()
  selected_challenge = $game_variables[10] - 1
  challenge_data = GYM_TRAINERS[selected_challenge] || nil

  if challenge_data && $player.badge_count < (selected_challenge + 1) then
    if challenge_data["script"] then challenge_data["script"].call end
    if TrainerBattle.start(challenge_data["type"].to_sym, challenge_data["name"]) then
      $player.badges[selected_challenge] = true # give badge on win
      if challenge_data["post_script"] then challenge_data["post_script"].call end
    end
  else
    pbMessage("Well done. Proceed to the next challenge!")
  end
  return true
end

def pbDecideChallengeTrainer(evtid)
  challenge_data = GYM_TRAINERS[$game_variables[10] - 1] || nil

  if challenge_data then
    $game_map.events[evtid].character_name = challenge_data["look"]
  else
    pbMessage("(Seems like your opponent is away...)")
    pbMessage("\\b(Let's come back another time...)")
    pbFadeOutIn { # go back to elevator
      $game_temp.player_new_map_id    = 83
      $game_temp.player_new_x         = 2
      $game_temp.player_new_y         = 5
      $game_temp.player_new_direction = 8
      $scene.transfer_player
    }
  end
end

def pbSelectGym()
  while true do
    gym_index = pbMessage("Select Floor.", GYM_CHALLENGES)

    if gym_index == $game_variables[10] && gym_index > 0 then
        pbMessage("You are already on this floor!")
        break
    end

    if gym_index - 1 <= $player.badge_count then
      $game_variables[11] = gym_index
      break
    else
      pbMessage("You must complete all previous challenges before accessing this floor!")
    end
  end
end
