# lines = File.read("./day1/example1.txt").split("\n")
# lines = File.read("./day1/example2.txt").split("\n")
lines = File.read("./day1/input.txt").split("\n")

def scan_for_word(input, index, word)
  word.chars.each_with_index.all? do |char, i|
    input[index + i] == char
  end
end

def words_to_numbers(input)
  index = 0
  output = ""
  while index < input.length
    if scan_for_word(input, index, "one")
      output << "1"
      index += 3
    elsif scan_for_word(input, index, "two")
      output << "2"
      index += 3
    elsif scan_for_word(input, index, "three")
      output << "3"
      index += 5
    elsif scan_for_word(input, index, "four")
      output << "4"
      index += 4
    elsif scan_for_word(input, index, "five")
      output << "5"
      index += 4
    elsif scan_for_word(input, index, "six")
      output << "6"
      index += 3
    elsif scan_for_word(input, index, "seven")
      output << "7"
      index += 5
    elsif scan_for_word(input, index, "eight")
      output << "8"
      index += 5
    elsif scan_for_word(input, index, "nine")
      output << "9"
      index += 4
    else
      output << input[index]
      index += 1
    end
  end
  return output
end

numbers = lines.map do |line|
  converted = words_to_numbers(line)

  # puts converted
  just_numbers = converted.gsub(/\D/, "").split("")
  (just_numbers.first.to_i * 10) + just_numbers.last.to_i
end


# puts "\n"
# puts numbers
puts "Total: #{numbers.inject(&:+)}"