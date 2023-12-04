# frozen_string_literal: true

# require 'minitest/autorun'

def calculate_scratchcards_sum(input)
  sum = 0

  input.each_line do |line|
    # puts "Line:\t\t\t#{line}"
    numbers_matched = 0
    wn = []
    winning_numbers, my_numbers = line.split(/Card\s+\d+\:/).last.split(' | ').map{|x| x.split(' ').map(&:to_i)}
    my_numbers.each do |number|
      wn << number if winning_numbers.include?(number)
      #   puts number
      #   numbers_matched += 1 
      # end
    end
    # puts "Winning Numbers:\t#{wn.join(', ')}"

    sum += 2 ** (wn.size - 1) unless wn.empty?
    # puts "\n"
  end

  sum
end

# Test this script with:
# class TestCalibrationSum < Minitest::Test
#   EXAMPLE = "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\nn7pqrstsixnineight"
#   EXAMPLE_CALIBRATIONS = [29, 83, 13, 24, 42, 14, 78].freeze

#   def test_every_line_individually
#     EXAMPLE.split("\n").each_with_index do |line, index|
#       assert_equal EXAMPLE_CALIBRATIONS[index], calculate_scratchcards_sum(line)
#     end
#   end

#   def test_full_input
#     assert_equal 283, calculate_scratchcards_sum(EXAMPLE)
#   end

#   def test_with_puzzle_input
#     input = File.read('../input.txt')
#     assert_equal 54_728, calculate_scratchcards_sum(input)
#   end
# end

text = File.read('../input.txt')
# text = File.read('../example.txt')
sum = calculate_scratchcards_sum(text)
print("Result:\t#{sum}\n")
