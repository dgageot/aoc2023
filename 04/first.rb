#!/usr/bin/env ruby
# Expected: 13

p STDIN.readlines().map { |line| line.scan(/\d+/)[1..].tally.count{ |_,v| v == 2} }.reject(&:zero?).sum { |n| 2 ** (n-1) }
