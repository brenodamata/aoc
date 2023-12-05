# frozen_string_literal: true

def closest_location(file_path)
  lines = File.readlines(file_path).map(&:chomp)
  seeds = lines.first.split(':')[1].split(' ').map(&:to_i)
  config = map_ranges(lines[2..-1])
  seeds.each_with_object([]) do |seed, locations|
    soil = convert_source_to_destination('seed-to-soil', seed, config)
    fertilizer = convert_source_to_destination('soil-to-fertilizer', soil, config)
    water = convert_source_to_destination('fertilizer-to-water', fertilizer, config)
    light = convert_source_to_destination('water-to-light', water, config)
    temperature = convert_source_to_destination('light-to-temperature', light, config)
    humidity = convert_source_to_destination('temperature-to-humidity', temperature, config)
    location = convert_source_to_destination('humidity-to-location', humidity, config)
    locations << location

    puts "Seed: #{seed}\tLocation: #{location}"
  end.min
end

def map_ranges(lines)
  config = {}
  map_type = nil
  lines.each do |line|
    # puts "Line: #{line}"
    if line.include?('map:')
      map_type = line.split(' map:')[0]
      config[map_type] = []
      # puts "Map type: #{map_type}"
      # puts "Config: #{config[map_type]}"
    else
      next if line.empty?
      mapping_numbers = line.split(' ').map(&:to_i)
      # puts "Mapping numbers: #{mapping_numbers}"
      # config[map_type] = [] if config[map_type].nil?
      config[map_type] << {
        destin_rang_start: mapping_numbers[0],
        source_rang_start: mapping_numbers[1],
        range_length: mapping_numbers[2]
      }
    end
  end
  
  config
end

def seed_to_soil(seed, config)
  # ranges = config['seed-to-soil']
  # destine_range = ranges.map{|x| x[:destin_rang_start]..(x[:destin_rang_start] + x[:range_length] - 1)}
  config['seed-to-soil'].each do |range|
    source_range = range[:source_rang_start]..(range[:source_rang_start] + range[:range_length] - 1)
    if source_range.include?(seed)
      source_index = source_range.to_a.find_index(seed)
      destine_range = range[:destin_rang_start]..(range[:destin_rang_start] + range[:range_length] - 1)
      return destine_range.to_a[source_index]
    end
  end
end

def convert_source_to_destination(conversion_type, source_value, config)
  config[conversion_type].each do |range|
    source_range = range[:source_rang_start]..(range[:source_rang_start] + range[:range_length] - 1)
    if source_range.include?(source_value)
      source_index = source_range.to_a.find_index(source_value)
      destine_range = range[:destin_rang_start]..(range[:destin_rang_start] + range[:range_length] - 1)
      return destine_range.to_a[source_index]
    end
  end

  source_value
end

closest_location = closest_location('../input.txt')
# closest_location = closest_location('../example.txt')
print("Closest location:\t#{closest_location}\n")
