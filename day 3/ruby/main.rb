# frozen_string_literal: true

require 'minitest/autorun'

class EngineSchematic
  def initialize(file_dir)
    @text = File.read(file_dir)
    @numbers, @symbols = *get_engine_schematic
  end

  def calculate_sum_of_parts
    total = []
    @numbers.each do |line_number, numbers_and_positions|
      numbers_and_positions.each do |number_and_position|
        total << number_and_position[:number].to_i if is_part_number?(line_number, number_and_position)
      end
    end

    total.sum
  end

  def get_engine_schematic
    numbers_and_position = {}
    symbols_and_position = {}
    @text.each_line.with_index do |line, index|
      numbers_and_position.merge!(extract_numbers_and_positions(index, line))
      symbols_and_position.merge!(extract_symbols_and_positions(index, line))
    end

    [numbers_and_position, symbols_and_position]
  end

  def extract_numbers_and_positions(index, line)
    line.scan(/\d+/).each_with_object({}) do |number, position_hash|
      start_pos = line.index(number)
      end_pos = start_pos + number.length - 1
      position_hash[index] = [] unless position_hash[index]
      position_hash[index] << {
        number: number.to_i,
        start_pos: start_pos,
        end_pos: end_pos
      }
    end
  end

  def extract_symbols_and_positions(index, line)
    line.scan(/[^\w\s\.]/).each_with_object({}) do |symbol, position_hash|
      position = line.index(symbol)
      position_hash[index] = [] unless position_hash[index]
      position_hash[index] << {
        symbol: symbol,
        position: position
      }
    end
  end

  def _is_part_number?(line_number, number)
    positions_to_look_at = (number[:start_pos] - 1)..(number[:end_pos] + 1)
    line_above = @symbols[line_number - 1] || []
    line_below = @symbols[line_number + 1] || []
    before = @symbols[line_number] ? @symbols[line_number][number[:start_pos] - 1] : nil
    after = @symbols[line_number] ? @symbols[line_number][number[:end_pos] + 1] : nil

    # return false if line_above.nil? && line_below.nil? && before.nil? && after.nil?
    return false if line_above.empty? && line_below.empty? && before.nil? && after.nil?

    adjacent_positions = [line_above, line_below, before, after].compact.flatten
    diagonal_positions = [
      line_above[number[:start_pos] - 1], line_above[number[:end_pos] + 1],
      line_below[number[:start_pos] - 1], line_below[number[:end_pos] + 1]
    ].compact

    all_positions = adjacent_positions + diagonal_positions

    all_positions.any? { |line| positions_to_look_at.include? line[:position] }
  end
end


sum = EngineSchematic.new('../input.txt').calculate_sum_of_parts
print("Result:\t#{sum}\n")
# 220700 too low
# 314732 too low
# 469907 too low