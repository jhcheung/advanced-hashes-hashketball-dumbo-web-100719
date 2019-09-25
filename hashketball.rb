# Write your code here!

require "yaml"
require "pry"

def game_hash
  YAML.load_file('./game_hash.yml')
end 

def num_points_scored(name)
  game_hash.reduce(nil) do |memo, (key, team)|
    team[:players].each do |player|
      if player[name]
        memo = player[name][:points]
      end 
    end
    memo
  end 
end 

def shoe_size(name)
  game_hash.reduce(nil) do |memo, (key, team)|
    team[:players].each do |player|
      if player[name]
        memo = player[name][:shoe]
      end 
    end
    memo
  end 
end 

def team_colors(teamname)
  game_hash.reduce(nil) do |memo, (key, team)|
    memo = team[:colors] if teamname == team[:team_name]
    memo
  end 
end 

def team_names
  game_hash.reduce([]) do |memo, (key, team)|
    memo.push(team[:team_name])
    memo
  end 
end 

def player_numbers(teamname)
  game_hash.reduce([]) do |memo, (key, team)|
    if teamname == team[:team_name]
      team[:players].each do |player|
        player.each do |name, stats|
          memo.push(stats[:number])
        end 
      end 
    end 
    memo
  end 
end 

def player_stats(name)
  game_hash.reduce({}) do |memo, (key, team)|
    team[:players].each do |player|
      if player[name]
        memo = player[name]
      end 
    end
    memo
  end 
end 

def big_shoe_rebounds
  maxshoe = 0
  game_hash.reduce(nil) do |memo, (key, team)|
    team[:players].each do |player|
      player.each do |name, stats|
        if !memo || stats[:shoe] > maxshoe
          maxshoe = stats[:shoe]
          memo = stats[:rebounds] 
        end
      end 
    end 
    memo
  end 
end 

def most_points_scored
  maxpoints = 0
  game_hash.reduce(nil) do |memo, (key, team)|
    team[:players].each do |player|
      player.each do |name, stats|
        if !memo || stats[:points] > maxpoints
          maxpoints = stats[:points]
          memo = name
        end
      end 
    end 
    memo
  end 
end 

def winning_team
  winning_score = 0
  game_hash.reduce(nil) do |memo, (key,team)|
    team[:totalscore] = 
      team[:players].reduce(0) do |total, players|  
        players.each do |name, stats|
          total += stats[:points]
        end 
        total
      end
    if team[:totalscore] > winning_score
      memo = team[:team_name]
      winning_score = team[:totalscore]
    end 
    memo
  end 
end 

def player_with_longest_name
  
end 