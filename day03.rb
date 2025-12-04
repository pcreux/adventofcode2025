
INPUT = <<~STR
987654321111111
811111111111119
234234234234278
818181911112111
STR

def largest_number(digits, max: , acc: 0)
  # puts "largest_number(#{digits}, max: #{max}, acc: #{acc}"
  digit = digits[0..-max].sort.last
  index_digit = digits.index(digit)

  current = acc * 10 + digit
  return current if max == 1

  largest_number(digits[(index_digit+1)..-1], max: max - 1, acc: current)
end

def run(input, max: 2)
  input.split("\n").map do |line|
    digits = line.split("").map(&:to_i)
    largest_number(digits, max:)
  end.sum
end

puts "With 2:"
puts run(INPUT)
puts run(File.read('day03.txt'))

puts "With 12:"
puts run(INPUT, max: 12)
puts run(File.read('day03.txt'), max: 12)
