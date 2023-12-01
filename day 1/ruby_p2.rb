# frozen_string_literal: true

require 'minitest/autorun'

NUMBERS_IN_WORDS = %w[zero one two three four five six seven eight nine].freeze
NUMBER_AND_WORD_RGX = /(?=(#{NUMBERS_IN_WORDS.join("|")}|\d))/

def calculate_calibration_sum(input)
  sum = 0

  input.each_line do |line|
    numbers_and_words = line.scan(NUMBER_AND_WORD_RGX).flatten
    numbers = numbers_and_words.map do |word|
      word.match?(/\d/) ? word.to_i : NUMBERS_IN_WORDS.find_index(word)
    end

    calibration = numbers.empty? ? 0 : ((numbers.first * 10) + numbers.last)
    sum += calibration
  end

  sum
end

# Test this script with:
class TestCalibrationSum < Minitest::Test
  EXAMPLE = "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\nn7pqrstsixnineight"
  EXAMPLE_CALIBRATIONS = [29, 83, 13, 24, 42, 14, 78].freeze

  def test_every_line_individually
    EXAMPLE.split("\n").each_with_index do |line, index|
      assert_equal EXAMPLE_CALIBRATIONS[index], calculate_calibration_sum(line)
    end
  end

  def test_full_input
    assert_equal 283, calculate_calibration_sum(EXAMPLE)
  end

  def test_with_puzzle_input
    input = File.read('input.txt')
    assert_equal 54_728, calculate_calibration_sum(input)
  end
end

text = File.read('input.txt')
sum = calculate_calibration_sum(text)
print("Result:\t#{sum}\n")
