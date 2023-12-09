# frozen_string_literal: true

def ending_match?(nodes)
  nodes.all? { |node| node.match(/..Z/) }
end

def steps(instructions, nodes, current_node)
  instruction_index = 0
  max_instruction_index = instructions.size - 1
  steps = 0

  while !current_node.end_with?('Z')
    current_node = nodes[current_node][instructions[instruction_index]]
    instruction_index = instruction_index >= max_instruction_index ? 0 : instruction_index + 1
    steps += 1
  end

  steps
end

decode_instruction = {
  'L': 0,
  'R': 1
}

file_path = '../input.txt'
file = File.open(file_path)
lines = file.readlines.map(&:chomp)

instructions_line = lines.shift
lines.shift # skip empty line

instructions = instructions_line.chars.map { |c| decode_instruction[c.to_sym] }

nodes = lines.each_with_object({}) do |line, nodes|
  key, value = line.split(' = ')
  nodes[key] = value.split(', ').map{|c| c.tr('()', '')}
end

starting_nodes = nodes.select { |k, v| k.match(/..A/) }.keys
steps = starting_nodes.map { |node| steps(instructions, nodes, node) }

puts "LCM: #{steps.reduce(1, :lcm)}"