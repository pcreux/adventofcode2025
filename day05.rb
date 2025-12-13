require 'set'

INPUT = <<~STR
3-5
10-14
16-20
12-18

1
5
8
11
17
32
STR

def day05(input)
  ranges_str, ingredients_str = input.split("\n\n")

  fresh_ranges = ranges_str.split("\n").map do
    b, e = _1.split("-").map(&:to_i)
    (b..e)
  end

  ingredients = ingredients_str.split("\n").map(&:to_i)
  pp ingredients.count { |i| fresh_ranges.any? { |r| r.include?(i) } }
end

# Takes forever to run
def day05_2(input)
  ranges_str, ingredients_str = input.split("\n\n")

  fresh_ranges = ranges_str.split("\n").map do
    b, e = _1.split("-").map(&:to_i)
    (b..e)
  end

  fresh_ingredients = Set.new
  fresh_ranges.each do |range|
    range.each do |i|
      fresh_ingredients << i
    end
  end

  pp fresh_ingredients.size
end

def day05_4(input)
  ranges_str, _ingredients_str = input.split("\n\n")

  ranges = ranges_str.split("\n").map { _1.split("-").map(&:to_i) }

  puts "Sorting..."
  ranges.sort!

  compressed_ranges = compress_ranges(ranges)
  pp compressed_ranges.sum(&:size)
end

def compress_ranges(ranges)
  compressed_ranges = ranges.dup

  ranges.each_with_index do |(x, y), index_1|
    ranges[(index_1 + 1)..].each_with_index do |(i, j), index_2|
      compressed_index = index_1 + 1 + index_2

      if i.between?(x, y) && j > y
        # x ---- y      (replace by x --- j)
        #   i ------ j  (drop)
        compressed_ranges[index_1] = [x, j]
        compressed_ranges[compressed_index] = nil
      elsif i.between?(x, y) && j.between?(x, y)
        # x ------- y
        #   i -- j  (drop)
        compressed_ranges[compressed_index] = nil
      end
    end
  end

  compressed_ranges.compact!

  return compressed_ranges.map { |x, y| (x..y) } if compressed_ranges.size == ranges.size

  compress_ranges(compressed_ranges)
end

day05(INPUT)

day05(File.read('day05.txt'))

day05_4(INPUT)

day05_4(File.read('day05.txt'))

# 9200302749056
# 379171333752001
# 344771884978261 :star:
