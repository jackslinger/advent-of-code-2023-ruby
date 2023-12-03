# lines = File.read("./day3/example.txt").split("\n")
lines = File.read("./day3/input.txt").split("\n")

class Number
  attr_reader :grid, :start_x, :end_x, :y

  def initialize(grid:, start_x:, end_x:, y:)
    @grid = grid
    @start_x = start_x
    @end_x = end_x
    @y = y
  end

  def to_s
    "#{lexeme}: #{display_co_ordinates}"
  end

  def display_co_ordinates
    "(#{start_x}, #{y}) - (#{end_x}, #{y})"
  end

  def lexeme
    (start_x...(end_x + 1)).map do |x|
      @grid[y][x]
    end.join("")
  end

  def adjacent_cells
    width = @grid[0].size
    height = @grid.size
    cells = []
    if y > 0
      ((start_x - 1)...(end_x + 2)).each do |x|
        cells << @grid[y - 1][x]
      end
    end
    if start_x > 0
      cells << @grid[y][start_x - 1]
    end
    if end_x < (width - 1)
      cells << @grid[y][end_x + 1]
    end
    if y < (height - 1)
      ((start_x - 1)...(end_x + 2)).each do |x|
        cells << @grid[y + 1][x]
      end
    end
    cells
  end

  def part_number?
    !adjacent_cells.all?{ |cell| cell == "." }
  end

end

class Schematic
  attr_reader :grid
  attr_reader :numbers

  def initialize(lines)
    @grid = lines.map{ |line| line.split("") }
    @numbers = find_numbers
  end

  private

  def find_numbers
    numbers = []
    @grid.each_with_index do |row, y|
      found_number = false
      num_start = nil
      num_end = nil
      row.each_with_index do |cell, x|
        if found_number
          if ["1", "2", "3", "4", "5", "6", "7", "8", "9"].include?(cell)
            num_end = x
          else
            numbers << Number.new(grid: @grid, start_x: num_start, end_x: num_end, y: y)
            found_number = false
          end
        else
          if ["1", "2", "3", "4", "5", "6", "7", "8", "9"].include?(cell)
            found_number = true
            num_start = x
          end
        end
      end
    end
    numbers
  end

end

schematic = Schematic.new(lines)

# schematic.numbers.each do |number|
#   puts "#{number} part number: #{number.part_number?}"
# end

puts schematic.numbers.select{ |number| number.part_number? }.map{ |number| number.lexeme.to_i }.inject(&:+)