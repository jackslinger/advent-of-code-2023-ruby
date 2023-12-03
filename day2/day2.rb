# lines = File.read("./day2/example.txt").split("\n")
lines = File.read("./day2/input.txt").split("\n")

class Game
  attr_reader :number
  attr_reader :draws

  def initialize(line)
    @line = line
    @number = line.match(/Game (\d+):/)[1].to_i
    @draws = parse_draws
  end

  def highest_counts
    @highest_counts ||= begin
      highest = {}
      draws.each do |draw|
        draw.data.each do |colour, value|
          if highest[colour].nil?
            highest[colour] = value
          else
            highest[colour] = [highest[colour], value].max
          end
        end
      end
      highest
    end
  end

  def possible_with(bag)
    bag.all? do |colour, count|
      highest_counts[colour] <= count
    end
  end

  def power
    highest_counts.map { |colour, count| count }.inject(&:*)
  end

  private

  def parse_draws
    remaining_line = @line.gsub(/Game \d+: /, "")
    draw_strings = remaining_line.split("; ")
    @draws = draw_strings.map{ |string| Draw.new(string) }
  end

end

class Draw
  attr_reader :data

  def initialize(string)
    @string = string
    @data = parse_data
  end

  def to_s
    data.inspect
  end

  def inspect
    data.inspect
  end

  private

  def parse_data
    data = @string.split(", ").map do |marble|
      # TODO: Should we combine if the same colour is drawn before putting back?
      temp = marble.split(" ")
      [temp.last, temp.first.to_i]
    end.to_h
  end

end

games = lines.map { |line| Game.new(line) }

bag = { "red" => 12, "green" => 13, "blue" => 14 }
# games.each do |game|
#   if game.possible_with(bag)
#     puts "Game #{game.number} possible"
#   else
#     puts "Game #{game.number} impossible"
#   end
# end

possible_games = games.select{ |game| game.possible_with(bag) }
puts "Sum of possible game IDs #{possible_games.map(&:number).inject(&:+)}"

games.each do |game|
  puts "Game #{game.number} power: #{game.power}"
end
puts "Sum of game powers: #{games.map(&:power).inject(&:+)}"
