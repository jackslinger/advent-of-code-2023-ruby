require "byebug"

# file = File.read("./day5/example.txt")
file = File.read("./day5/input.txt")

class Mapping
  attr_reader :source_start, :dest_start, :length

  def initialize(source_start:, dest_start:, length:)
    @source_start = source_start
    @dest_start = dest_start
    @length = length
  end

  def source_in_range?(source)
    source >= source_start && source <= source_start + length
  end

  def source_to_destination(source)
    diff = source - source_start
    return dest_start + diff
  end
end

class Mapper
  attr_reader :mappers

  # TODO: This method is too slow
  def initialize(lines)
    @mappers = lines.map do |line|
      dest_range_start, source_range_start, length = line.split(" ").map(&:to_i)
      Mapping.new(source_start: source_range_start, dest_start: dest_range_start, length: length)
    end
  end

  def source_to_destination(source)
    matching = mappers.select{ |mapper| mapper.source_in_range?(source) }
    if matching.any?
      matching.first.source_to_destination(source)
    else
      source
    end
  end

end

chunks = file.split("\n\n")

seeds = chunks[0].sub(/seeds:\s*/, "").split(" ").map(&:to_i)

def chunk_to_mapper(chunk)
  # Remove the first line
  lines = chunk.split("\n")[1..-1]
  Mapper.new(lines)
end

puts "#{chunks.size} Chunks"

mappers = chunks[1..-1].map do |chunk|
  chunk_to_mapper(chunk)
end

puts "Mappers count #{mappers.size}"
puts "Seeds count #{seeds.count}"

locations = seeds.map do |seed|
  value = seed
  mappers.each do |mapper|
    value = mapper.source_to_destination(value)
  end
  value
end

# puts locations.join(" ")
puts locations.sort.first