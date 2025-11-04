EXPEDITIONS = {
  "Twingrass Plains" => {
    "badges"  => 1,
    "map_id"  => 89,
    "map_x"   => 16,
    "map_y"   => 8,
    "map_dir" => 2,
    "script"  => proc {}
  },
  "Snowpoint Forest" => {
    "badges"  => 3,
    "map_id"  => 91,
    "map_x"   => 10,
    "map_y"   => 11,
    "map_dir" => 2,
    "script"  => proc {}
  },
  "Rimoto Badlands" => {
    "badges"  => 5,
    "map_id"  => 101,
    "map_x"   => 6,
    "map_y"   => 8,
    "map_dir" => 2,
    "script"  => proc {}
  }
}

def pbBeginExpedition
  options = EXPEDITIONS.keys + ["RETURN"]
  cmd = pbMessage("Select an Expedition.", options)
  return if cmd.nil? || cmd >= options.length - 1

  name = options[cmd]
  data = EXPEDITIONS[name]

  if $player.badge_count < data["badges"]
    pbMessage("You need at least #{data["badges"]} badge(s) to begin this expedition.")
    return
  end

  if pbConfirmMessage("Are you sure you want to begin an expedition to #{name}?")
    pbFadeOutIn {
      $game_temp.player_new_map_id    = data["map_id"]
      $game_temp.player_new_x         = data["map_x"]
      $game_temp.player_new_y         = data["map_y"]
      $game_temp.player_new_direction = data["map_dir"] || 2
      $scene.transfer_player
      data["script"].call if data["script"]
    }
  else
    pbMessage("Expedition canceled.")
  end
end
