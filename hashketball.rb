# Write your code here!

require "yaml"
require "pry"

def game_hash
  YAML.load_file('./game_hash.yml')
end 

def num_points_scored(name)
  game_hash.reduce(nil) do |pts, (key, team)|
    team[:players].each do |player|
      if player[name]
        pts = player[name][:points]
      end 
    end
    pts
  end 
end 

def shoe_size(name)
  game_hash.reduce(nil) do |shoesize, (key, team)|
    team[:players].each do |player|
      if player[name]
        shoesize = player[name][:shoe]
      end 
    end
    shoesize
  end 
end 

def team_colors(teamname)
  game_hash.reduce(nil) do |teamcolors, (key, team)|
    teamcolors = team[:colors] if teamname == team[:team_name]
    teamcolors
  end 
end 

def team_names
  game_hash.reduce([]) do |teamnames, (key, team)|
    teamnames.push(team[:team_name])
    teamnames
  end 
end 

def player_numbers(teamname)
  game_hash.reduce([]) do |jersey_numbers, (key, team)|
    if teamname == team[:team_name]
      team[:players].each do |player|
        player.each do |name, stats|
          jersey_numbers.push(stats[:number])
        end 
      end 
    end 
    jersey_numbers
  end 
end 

def player_stats(name)
  game_hash.reduce({}) do |stathash, (key, team)|
    team[:players].each do |player|
      if player[name]
        stathash = player[name]
      end 
    end
    stathash
  end 
end 

def big_shoe_rebounds
  maxshoe = 0
  game_hash.reduce(nil) do |rebounds, (key, team)|
    team[:players].each do |player|
      player.each do |name, stats|
        if !rebounds || stats[:shoe] > maxshoe
          maxshoe = stats[:shoe]
          rebounds = stats[:rebounds] 
        end
      end 
    end 
    rebounds
  end 
end 


def most_points_scored
  maxpoints = 0
  game_hash.reduce(nil) do |point_leader, (key, team)|
    team[:players].each do |player|
      player.each do |name, stats|
        if !point_leader || stats[:points] > maxpoints
          maxpoints = stats[:points]
          point_leader = name
        end
      end 
    end 
    point_leader
  end 
end 

def winning_team
  winning_score = 0
  game_hash.reduce(nil) do |winner, (key, team)|
    team[:totalscore] = 
      team[:players].reduce(0) do |total, players|  
        players.each do |name, stats|
          total += stats[:points]
        end 
        total
      end
    if team[:totalscore] > winning_score
      winner = team[:team_name]
      winning_score = team[:totalscore]
    end 
    winner
  end 
end 

def player_with_longest_name
  longest_name_char = 0 
  game_hash.reduce(nil) do |name_leader, (key, team)|
    team[:players].each do |player|
      player.each do |name, stats|
        if name.length > longest_name_char
          longest_name_char = name.length
          name_leader = name
        end
      end 
    end 
    name_leader
  end 
end

def long_name_steals_a_ton?
  highest_steals = 0 
  
  game_hash.reduce(false) do |memo, (key, team)|
    team[:players].each do |player|
      player.each do |name, stats|
        if stats[:steals] > highest_steals
          highest_steals = stats[:steals]
          memo = false if memo
          memo = true if name == player_with_longest_name
        end
      end 
    end 
    memo
  end
end