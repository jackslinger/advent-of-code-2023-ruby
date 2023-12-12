require "byebug"

# lines = File.read("./day4/example.txt").split("\n")
lines = File.read("./day4/input.txt").split("\n")

class Card
  attr_reader :number, :winning, :chosen

  def initialize(line)
    @line = line
    @number = line.match(/Card\s+(\d+)/)[1].to_i

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

card_counts = {}
cards.size.times.each do |i|
  card_counts[i + 1] = 1
end

cards.each do |card|
  card.cards_to_win.each do |extra_card_number|
    card_counts[extra_card_number] += card_counts[card.number]
  end
end

pp card_counts
puts "Number of cards: #{card_counts.values.sum}"