INPUT = <<~STR
..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
STR

class Grid
  def self.build(input)
    new(input.split("\n").map { _1.split("") })
  end

  attr_reader :grid

  def initialize(grid)
    @grid = grid
  end

  def max_x
    grid.first.size
  end

  def max_y
    grid.size
  end

  def get(x, y)
    return nil if x < 0 || y < 0

    row = grid[y]
    row[x] if row
  end

  def remove(x, y)
    return nil if x < 0 || y < 0

    row = grid[y]
    row[x] = "x" if row
  end

  def around(x, y)
    [-1, 0, 1, -1, 1].permutation(2).uniq.map do |shift_x, shift_y|
      next if shift_x == 0 && shift_y == 0

      get(x + shift_x, y + shift_y)
    end
  end
end

def run(input)
  grid = Grid.build(input)
  count = 0

  grid.max_x.times do |x|
    grid.max_y.times do |y|
      next unless grid.get(x, y) == "@"

      rolls = grid.around(x, y).count("@")
      # puts "At #{x}, #{y}: #{rolls} rolls around"
      if rolls < 4
        count += 1
      end
    end
  end

  puts count
end

def find_rolls(grid)
  rolls = []

  grid.max_x.times do |x|
    grid.max_y.times do |y|
      next unless grid.get(x, y) == "@"

      count = grid.around(x, y).count("@")
      rolls << [x, y] if count < 4
    end
  end

  rolls
end

def run_2(input)
  grid = Grid.build(input)
  count = 0

  loop do
    rolls = find_rolls(grid)
    break if rolls.empty?

    rolls.each do |x, y|
      grid.remove(x, y)
      count += 1
    end
  end

  puts count
end

run(INPUT)
run(File.read('day04.txt'))

run_2(INPUT)
run_2(File.read('day04.txt'))
