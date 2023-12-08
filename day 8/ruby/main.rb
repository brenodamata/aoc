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

current_node = 'AAA'
instruction_index = 0
max_instruction_index = instructions.size - 1
steps = 0

while current_node != 'ZZZ'
  current_node = nodes[current_node][instructions[instruction_index]]
  instruction_index = instruction_index >= max_instruction_index ? 0 : instruction_index + 1
  steps += 1
end

puts "Steps: #{steps}"