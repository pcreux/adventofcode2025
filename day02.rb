require 'active_support/all' # in_groups_of

SAMPLE_INPUT = <<~DATA
  11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
  1698522-1698528,446443-446449,38593856-38593862,565653-565659,
  824824821-824824827,2121212118-2121212124
DATA

REAL_INPUT = <<~DATA
492410748-492568208,246-390,49-90,16-33,142410-276301,54304-107961,12792-24543,3434259704-3434457648,848156-886303,152-223,1303-1870,8400386-8519049,89742532-89811632,535853-567216,6608885-6724046,1985013826-1985207678,585591-731454,1-13,12067202-12233567,6533-10235,6259999-6321337,908315-972306,831-1296,406-824,769293-785465,3862-5652,26439-45395,95-136,747698990-747770821,984992-1022864,34-47,360832-469125,277865-333851,2281-3344,2841977-2953689,29330524-29523460
DATA

def ids(input)
  ranges = input.split(',').map do |pair|
    start, finish = pair.split('-').map { Integer(_1) }
    (start..finish)
  end

  ranges.map(&:to_a).flatten
end

def valid_01?(id)
  id = id.to_s

  index = id.size / 2

  id[0...index] != id[index..]
end

def valid_02?(id)
  return false unless valid_01?(id)

  digits = id.to_s.split("")

  (1..(digits.size / 2)).each do |chunk_size|
    slices = digits.in_groups_of(chunk_size).to_a
    return false if slices.all? { _1 == slices.first }
  end

  true
end

def run(input, strategy: :valid_01?)
  invalid_ids = ids(input).reject { method(strategy).call(_1) }

  puts "Invalid ids:"
  pp invalid_ids
  puts
  puts "Sum:"
  pp invalid_ids.sum
end

[ :valid_01?, :valid_02? ].each do |strategy|
  puts strategy
  puts "Sample input:"
  run(SAMPLE_INPUT, strategy:)
  puts "Real input:"
  run(REAL_INPUT, strategy:)
  puts
end
