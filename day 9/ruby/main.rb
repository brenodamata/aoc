# frozen_string_literal: true

def get_total_history(values)
  total_history = []
  step_differences = values

  while step_differences.uniq != [0]
    total_history << step_differences
    step_differences = step_differences.each_cons(2).map { |a, b| b - a }
  end

  total_history
end

def get_next_value(history)
  values = history.split.map(&:to_i)
  total_history = get_total_history(values)
  last_step = total_history.last.uniq.first
  total_history.reverse.each do |step_differences|
    next if step_differences.uniq == [last_step]
    
    last_step = step_differences.last + last_step
  end

  last_step
end

file_path = '../input.txt'
# file_path = '../example.txt'
file = File.open(file_path)
lines = file.readlines.map(&:chomp)

sum_of_extrapolated_values = lines.each_with_object([]) do |history, next_values|
  next_values << get_next_value(history)
end.sum

puts "Sum of extrapolated values: #{sum_of_extrapolated_values}"
# Should be 114