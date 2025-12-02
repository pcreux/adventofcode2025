class Dial
  attr_reader :position, :clicks

  def initialize(position, clicks = [])
    @position = position
    @clicks = clicks
  end

  def move(string)
    direction = string.start_with?('R') ? 1 : -1
    steps = Integer(string[1..])

    new_position = position
    clicks = steps.times.map do
      new_position = (new_position + direction) % 100
    end

    Dial.new(new_position, clicks)
  end

  def position_is_zero?
    position == 0
  end

  def zero_clicks
    clicks.select(&:zero?).count
  end
end

def solve(moves)
  dial = Dial.new(50)

  dials = moves.map do |move|
    dial = dial.move(move)
  end

  puts "Stopped on 0: #{dials.select(&:position_is_zero?).count}"
  puts "Clicked on 0: #{dials.sum(&:zero_clicks)}"
end

SAMPLE = %w[
  L68
  L30
  R48
  L5
  R60
  L55
  L1
  L99
  R14
  L82
]

solve(SAMPLE)

solve(File.read('day01_input.txt').split("\n"))
