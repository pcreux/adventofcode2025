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

def day05_3(input)
  ranges_str, ingredients_str = input.split("\n\n")

  fresh_ranges = ranges_str.split("\n").map do
    b, e = _1.split("-").map(&:to_i)
    (b..e)
  end

  pp fresh_ranges.flat_map { _1.to_a }.uniq.size
end

def day05_4(input)
  ranges_str, _ingredients_str = input.split("\n\n")

  ranges = ranges_str.split("\n").map { _1.split("-").map(&:to_i) }

  puts "Sorting..."
  ranges.sort!

  fresh_ingredients = Set.new
  compressed_ranges = compress_ranges(ranges)

  previous_y = nil
  compressed_ranges.each do |r|
    x = r.first
    y = r.last
    raise "Compact failed: previous y is #{previous_y} but current x is #{x}" if previous_y && x <= previous_y
    previous_y = y
  end

  pp compressed_ranges.sum(&:size)
end

def compress_ranges(ranges)
  compressed_ranges = ranges.dup

  puts "Getting #{ranges.size}..."

  ranges.each_with_index do |(x, y), index_1|
    ranges[(index_1 + 1)..].each_with_index do |(i, j), index_2|
      if i.between?(x, y) && j > y
        # x ---- y      (extend to j)
        #   i ------ j  (drop)
        compressed_ranges[index_1] = [x, j]
        compressed_ranges[index_2] = nil
        puts "(#{x} - #{y}) + (#{i} - #{j}) => (#{x} - #{j}) (REPLACE)"
      elsif i.between?(x, y) && j.between?(x, y)
        # x ------- y
        #   i -- j  (drop)
        compressed_ranges[index_2] = nil
        puts "(#{x} - #{y}) + (#{i} - #{j}) => (#{x} - #{y}) (DROP)"
      end
    end
  end

  compressed_ranges.compact!

  puts "  => compressed to #{compressed_ranges.size}"

  return compressed_ranges.map { |x, y| (x..y) } if compressed_ranges.size == ranges.size

  compress_ranges(compressed_ranges)
end

day05(INPUT)

day05(File.read('day05.txt'))

day05_4(INPUT)

day05_4(File.read('day05.txt'))

