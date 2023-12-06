# frozen_string_literal: true

def total_ways_to_beat_record(file_path)
  time, distance = *get_puzzle_map(file_path)
  puts "time: #{time},\tdistance: #{distance}"
  get_winning_strategies(time, distance)
end

def get_puzzle_map(file_path)
  file = File.open(file_path)
  lines = file.readlines.map(&:chomp)
  file.close

  time = lines[0].split(':')[1].split(' ').join.to_i
  distance = lines[1].split(':')[1].split(' ').join.to_i
  [time, distance]
end

def get_winning_strategies(time, distance)
  ws = 0
  time.times do |button_press_time|
    mov_time = time - button_press_time
    range = button_press_time * mov_time
    ws += 1 if range > distance
  end

  ws
end

result = total_ways_to_beat_record('../input.txt')
# result = total_ways_to_beat_record('../example.txt')
# should be 71503
print("Total ways to beat the record:\t#{result}\n")
