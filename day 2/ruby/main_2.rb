# frozen_string_literal: true

require 'minitest/autorun'

def calculate_power_sum(text)
  lines = []
  text.each_line do |line|
    power = get_line_power(line)
    lines << power
  end

  lines.sum
end

def get_line_power(line)
  # TODO: calculate minimum necessary cubes
  cubes = { red: 0, green: 0, blue: 0 }
  sets = line.split(/Game \d+:/).last.strip.split('; ')
  sets.each do |set|
    set.scan(/(\d+) (\w+)/) do |number, color|
      cubes[color.to_sym] = number.to_i if number.to_i > cubes[color.to_sym]
    end
  end

  cubes.values.inject(:*)
end

# Test this script with:
class TestPuzzle < Minitest::Test
  EXAMPLE = File.read('../example_input.txt')
  POWER_SET = [48, 12, 1560, 630, 36].freeze

  def test_every_line_individually
    EXAMPLE.split("\n").each_with_index do |line, index|
      assert_equal POWER_SET[index], get_line_power(line)
    end
  end

  def test_full_input
    assert_equal 2286, calculate_power_sum(EXAMPLE)
  end

  def test_with_puzzle_input
    input = File.read('../input.txt')
    assert_equal 78669, calculate_power_sum(input)
  end
end

text = File.read('../input.txt')
sum = calculate_power_sum(text)
print("Result:\t#{sum}\n")