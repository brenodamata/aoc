class NumberSumCalculator
  def initialize(file_path)
    @file_path = file_path
  end

  def calculate_sum
    sum = 0
    lines = File.readlines(@file_path).map(&:chomp)
    # puts "Lines:"
    # lines.each { |line| puts line }
    lines.each_with_index do |line, line_index|
      puts "\n"
      puts "Line: #{line}"
      line.scan(/\d+/).each do |number|
        start_index = line.index(number)
        end_index = start_index + number.length - 1
        # puts "Number: #{number}"
        if adjacent_to_symbol?(lines, line_index, start_index, end_index)
          puts "#{number} is adjacent to symbol"
          sum += number.to_i
        end
      end
    end
    sum
  end

  private

  # TODO:
  def adjacent_to_symbol?(lines, current_line_index, start_index, end_index)
    (-1..1).each do |y|
      index = current_line_index + y
      next if index < 0
      next if index >= lines.length

      before_index = start_index - 1 < 0 ? false : start_index - 1
      after_index = end_index == lines[index].length - 1 ? false : end_index + 1

      if y.zero?
        adjacent = before_after_symbol?(lines, index, before_index, after_index)
        # adjacent = lines[index][before_index].match(/[^\w\s\.]/) || lines[index][after_index].match(/[^\w\s\.]/)
        if adjacent
          # puts 'Adjacent to symbol in same line'
          # log_match(adjacent, lines, index, current_line_index)
          return true
        else
          # puts 'NOT Adjacent to symbol in same line'
          # puts "line: #{lines[index]}"
          # puts "before: #{lines[index][before_index]}"
          # puts "after: #{lines[index][after_index]}"
        end
      else
        before_index = before_index ? before_index : 0
        after_index = after_index ? after_index : lines[index].length - 1
        match = lines[index][before_index..after_index].scan(/[^\w\s\.]/)
        if match.empty?
          # puts "NOT matched"
          # puts "line: #{lines[index]}"
          # puts "substring to find symbol: #{lines[index][before_index..after_index]}"
        else
          # puts "matched"
          # log_match(match, lines, index, current_line_index)
          return true 
        end
      end
    end

    false
  # rescue NoMethodError => e
  #   puts "Error: #{e}"
  #   puts "Current Line: #{lines[current_line_index]}"
  #   puts "Start Index: #{start_index}"
  #   puts "End Index: #{end_index}"
  #   raise
  end

  def before_after_symbol?(lines, index, before_index, after_index)
    match_before = before_index ? lines[index][before_index].match(/[^\w\s\.]/) : nil
    match_after = after_index ? lines[index][after_index].match(/[^\w\s\.]/) : nil
  # rescue NoMethodError => e
  #   puts "Error: #{e}"
  #   puts "Line: #{lines[index]}"
  #   puts "Before Index: #{before_index}"
  #   puts "After Index: #{after_index}"
  #   raise
  end

  def log_match(match, lines, index, current_line_index)
    puts "Match: #{match}"
    puts "On Line: #{lines[index]}"
    puts "For current line: #{lines[current_line_index]}"
  end
end

# calculator = NumberSumCalculator.new('../example_input.txt')
# puts "Total Sum: #{calculator.calculate_sum}"

calculator = NumberSumCalculator.new('../input.txt')
puts "Total Sum: #{calculator.calculate_sum}"
