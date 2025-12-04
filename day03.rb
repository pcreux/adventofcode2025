
INPUT = <<~STR
987654321111111
811111111111119
234234234234278
818181911112111
STR

def largest_number(digits)
  digit_1 = digits[0..-2].sort.reverse.first
  index_digit_1 = digits.index(digit_1)
  digit_2 = digits[(index_digit_1 + 1)..-1].sort.reverse.first

  digit_1 * 10 + digit_2
end

def run(input)
  input.split("\n").map do |line|
    digits = line.split("").map(&:to_i)
    largest_number(digits)
  end.sum
end

puts run(INPUT)
puts run(File.read('day03.txt'))
