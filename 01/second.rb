#!/usr/bin/env ruby
# Expected: 281

digits = %w(1 2 3 4 5 6 7 8 9 one two three four five six seven eight nine)

p STDIN
    .readlines()
    .map { |line| (0...line.length).filter_map { |i| digits.find_index { |digit| line[i..].start_with?(digit) } }.values_at(0, -1) }
    .sum { |first, last| (first%9+1)*10+(last%9+1) }
