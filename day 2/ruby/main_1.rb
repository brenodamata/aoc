# frozen_string_literal: true

require 'minitest/autorun'

BAG_OF_CUBES = {
  red: 12,
  green: 13,
  blue: 14
}

def calculate_id_sum(text)
  possible_ids = []
  id = 1
  text.each_line do |line|
    possible_ids << id if possible?(line)
    id += 1
  end

  possible_ids.sum
end

def possible?(line)
  game_match = line.match(/Game (\d+):/)[0]
  game_id = game_match.split(' ')[1].to_i
  sets = line.split(/Game \d+:/).last.strip.split('; ')
  sets.each do |set|
    set.scan(/(\d+) (\w+)/) do |number, color|
      return false if number.to_i > BAG_OF_CUBES[color.to_sym]
    end
  end
  
  true
end

# Test this script with:
class TestPuzzle < Minitest::Test
  EXAMPLE = File.read('../example_input.txt')
  POSSIBLE_LINES = [true, true, false, false, true].freeze

  def test_every_line_individually
    EXAMPLE.split("\n").each_with_index do |line, index|
      assert_equal POSSIBLE_LINES[index], possible?(line)
    end
  end

  def test_full_input
    assert_equal 8, calculate_id_sum(EXAMPLE)
  end

  def test_with_puzzle_input
    input = File.read('../input.txt')
    assert_equal 2283, calculate_id_sum(input)
  end
end

text = File.read('../input.txt')
sum = calculate_id_sum(text)
print("Result:\t#{sum}\n")