# frozen_string_literal: true

require 'minitest/autorun'

def calculate_calibration_sum(input)
  calibrations = input.each_line.with_object([]) do |line, sum|
    numbers = line.scan(/-?\d/).map(&:to_i)
    calibration = numbers.empty? ? 0 : "#{numbers.first}#{numbers.last}".to_i
    sum << calibration
  end

  calibrations.sum
end

# Test this script with:
class TestCalibrationSum < Minitest::Test
  def test_with_multiple_numbers
    input = 'a1b2c3d4e5f'
    assert_equal 15, calculate_calibration_sum(input)
  end

  def test_with_single_number
    input = 'treb7uchet'
    assert_equal 77, calculate_calibration_sum(input)
  end

  def test_with_no_numbers
    input = "no numbers here\nstill no numbers"
    assert_equal 0, calculate_calibration_sum(input)
  end

  def test_with_multiple_lines
    input = "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet"
    assert_equal 142, calculate_calibration_sum(input)
  end

  def test_with_puzzle_input
    input = File.read('../input.txt')
    assert_equal 54_916, calculate_calibration_sum(input)
  end
end

text = File.read('../input.txt')
sum = calculate_calibration_sum(text)
print("Result:\t#{sum}\n")
