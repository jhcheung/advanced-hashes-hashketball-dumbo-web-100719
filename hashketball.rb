# Write your code here!

require "yaml"
require "pry"

def game_hash
  YAML.load_file('./game_hash.yml')
end 

def num_points_scored(name)
  game_hash.reduce(nil) do |memo, (key, value)|
    value[:players].each do |player|
      if player[name]
        memo = player[name][:points]
      end 
    end
    memo
  end 
end 

def shoe_size(name)
  game_hash.reduce(nil) do |memo, (key, value)|
    value[:players].each do |player|
      if player[name]
        memo = player[name][:shoe]
      end 
    end
    memo
  end 
end 

def team_colors(teamname)
  game_hash.reduce(nil) do |memo, (key, value)|
    memo = value[:colors] if teamname == value[:team_name]
    memo
  end 
end 

def team_names
  game_hash.reduce([]) do |memo, (key, value)|
    memo.push(value[:team_name])
    memo
  end 
end 

def player_numbers(teamname)
  game_hash.reduce([]) do |memo, (key, value)|
    if teamname == value[:team_name]
      value[:players].each do |player|
        player.each do |key, value|
          memo.push(value[:number])
        end 
      end 
    end 
    memo
  end 
end 

def player_stats(name)
  game_hash.reduce({}) do |memo, (key, value)|
    value[:players].each do |player|
      if player[name]
        memo = player[name]
      end 
    end
    memo
  end 
end 

def big_shoe_rebounds
  maxshoe = 0
  game_hash.reduce(nil) do |memo, (key, value)|
    value[:players].each do |player|
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
  
end 