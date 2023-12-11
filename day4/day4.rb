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
    count = number_of_matches
    if count > 0
      2 ** (count - 1)
    else
      0
    end
  end

  def num_of_cards_to_win
    number_of_matches
  end

  def cards_to_win
    number_of_matches.times.map{ |i| i + number + 1 }
  end

  def to_s
    "Card #{number}: #{winning.join(" ")} | #{chosen.join(" ")} | Matches: #{number_of_matches} | Score: #{score}"
  end

  private

  def number_of_matches
    chosen.select do |chosen_number|
      winning.include?(chosen_number)
    end.size
  end
end

cards = lines.map{ |line| Card.new(line) }
puts cards
puts "\nPart 1"
puts "Total score: #{cards.map(&:score).inject(&:+)}"

puts "\nPart 2"
originals = cards.dup
cards_and_copies = cards.dup

# originals.each do |card|
#   puts "Card #{card.number}: #{card.cards_to_win.join(", ")}"
# end

i = 0
while i < cards_and_copies.length
  card = cards_and_copies[i]
  puts i.to_s if i % 100 == 0

  card.cards_to_win.each do |index|
    cards_and_copies.push(originals[index-1].dup)
  end
  
  i += 1
end

puts cards_and_copies.size