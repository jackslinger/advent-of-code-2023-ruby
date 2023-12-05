require "byebug"

# lines = File.read("./day4/example.txt").split("\n")
lines = File.read("./day4/input.txt").split("\n")

class Card
  attr_reader :number, :winning, :chosen

  def initialize(line)
    @line = line
    @number = line.match(/Card\s+(\d)+/)[1].to_i

    winning_string, check_string = line.sub(/Card\s+\d+: /, "").split(" | ")
    @winning = winning_string.split(/\s/).reject(&:nil?).reject{ |str| str == "" }.map(&:to_i)
    @chosen = check_string.split(/\s/).reject(&:nil?).reject{ |str| str == "" }.map(&:to_i)
  end

  def score
    count = chosen.select do |chosen_number|
      winning.include?(chosen_number)
    end.size
    if count > 0
      2 ** (count - 1)
    else
      0
    end
  end

  def to_s
    "Card #{number}: #{winning.join(" ")} | #{chosen.join(" ")} | Score: #{score}"
  end
end

cards = lines.map{ |line| Card.new(line) }
puts cards
puts "Total: #{cards.map(&:score).inject(&:+)}"