INPUT = <<STR
123 328  51 64
 45 64  387 23
  6 98  215 314
*   +   *   +
STR

def solve(input)
  matrix = input.split("\n").map { _1.strip.split(/\s+/) }

  lines = matrix.transpose.to_a

  r = lines.sum do |l|
    l[0..-2].reduce(nil) do |acc, v|
      # puts "Value: #{v}; acc: #{acc}"
      case l.last
      when "+"
        acc = (acc || 0) + Integer(v)
      when "*"
        acc = (acc || 1) * Integer(v)
      else
        raise l.last.inspect!
      end

      acc
    end
  end
end

pp solve(INPUT)
pp solve(File.read("day06.txt"))

def solve_2(input)
  lines = input.split("\n")
  size = lines.map(&:size).max
  matrix = lines.map { _1.ljust(size, " ").reverse.split("") }
  transp = matrix.transpose.to_a

  running_total = 0
  current_numbers = []

  transp.each do |line|
    next if line.all?(" ")
    current_numbers << Integer(line[0..-2].join)

    case line.last
    when "+"
      running_total += current_numbers.sum
      current_numbers = []
    when "*"
      running_total += current_numbers.reduce(&:*)
      current_numbers = []
    end
  end

  running_total
end

pp solve_2(INPUT)
pp solve_2(File.read("day06.txt"))
