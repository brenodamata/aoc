# frozen_string_literal: true

def get_product_of_possible_wins(file_path)
  array_of_time_and_distance = get_puzzle_map(file_path)
  number_of_winning_strategies = []
  array_of_time_and_distance.each do |time_and_distance|
    number_of_winning_strategies << get_winning_strategies(time_and_distance)
  end

  number_of_winning_strategies.inject(:*)
end

def get_puzzle_map(file_path)
  file = File.open(file_path)
  lines = file.readlines.map(&:chomp)
  file.close

  time = lines[0].split(':')[1].split(' ').map(&:to_i)
  distance = lines[1].split(':')[1].split(' ').map(&:to_i)
  time.each_with_object([]) do |t, arr|
    arr << [t, distance[time.index(t)]]
  end
end

def get_winning_strategies(time_and_distance)
  ws = 0
  time = time_and_distance[0]
  distance = time_and_distance[1]
  time.times do |button_press_time|
    mov_time = time - button_press_time
    range = button_press_time * mov_time
    ws += 1 if range > distance
  end

  ws
end


result = get_product_of_possible_wins('../input.txt')
# result = get_product_of_possible_wins('../example.txt')
# should be 288
print("Result:\t#{result}\n")
