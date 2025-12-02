class Dial
  attr_reader :position, :zero_clicks

  def initialize(position)
    @position = position
    @zero_clicks = 0
  end

  def move(string)
    direction = string.start_with?('R') ? 1 : -1
    steps = Integer(string[1..])

    new_position = position
    steps.times do
      new_position = (new_position + direction) % 100
      @zero_clicks += 1 if new_position == 0
    end

    Dial.new(new_position)
  end

  def position_is_zero?
    position == 0
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
