#!/usr/bin/env ruby
# Expected: 142

p STDIN
    .readlines(chomp: true)
    .map { |line| line.delete("^1-9") }
    .map { |line| (line[0] + line[-1]).to_i }
    .sum
