
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
    "look" => "trainer_ELITEFOUR_Bruno",
    "type" => "LEADER_Bruno",
    "name" => "KEI"
  }
]

def pbAttemptChallenge()
  challenge_data = GYM_TRAINERS[$game_variables[10] - 1] || nil

  if challenge_data then
    TrainerBattle.start(challenge_data["type"].to_sym, challenge_data["name"])
  end
end

def pbDecideChallengeTrainer(evtid)
  challenge_data = GYM_TRAINERS[$game_variables[10] - 1] || nil

  if challenge_data then
    $game_map.events[evtid].character_name = challenge_data["look"]
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
