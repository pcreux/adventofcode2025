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

def day05_2b(input)
  ranges_str, _ingredients_str = input.split("\n\n")

  ranges = ranges_str.split("\n").map { _1.split("-").map(&:to_i) }.sort

  compress_ranges_v1(ranges).sum(&:size)
end

def day05_2c(input)
  ranges_str, _ingredients_str = input.split("\n\n")

  ranges = ranges_str.split("\n").map { _1.split("-").map(&:to_i) }.sort.map { |i, j| (i..j) }
  compress_ranges_v2(ranges).sum(&:size)
end

def compress_ranges_v1(ranges)
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

  compress_ranges_v1(compressed_ranges)
end

def compress_ranges_v2(ranges)
  return ranges if ranges.all? { |r| ranges.select { _1.overlap?(r) }.size == 1 }

  range = ranges.first
  overlapping_ranges, non_overlapping_ranges = ranges.partition { |r| range.overlap?(r) }

  min = overlapping_ranges.map(&:first).min
  max = overlapping_ranges.map(&:last).max

  compress_ranges_v2(non_overlapping_ranges + [(min..max)])
end

day05(INPUT)

day05(File.read('day05.txt'))

pp day05_2b(INPUT)
pp day05_2b(File.read('day05.txt'))

pp day05_2c(INPUT)
pp day05_2c(File.read('day05.txt'))

# 9200302749056
# 379171333752001
# 344771884978261 :star: v1
#
# 352333738883927 v2?
