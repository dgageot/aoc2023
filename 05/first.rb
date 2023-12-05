#!/usr/bin/env ruby
# Expected: 35

require "scanf"

specs = STDIN.readlines(chomp: true)

steps = []
pos = 2
while pos < specs.count do
    lines = specs[pos..].take_while { |line| !line.empty? }
    steps << lines[1..].map { |line| dest, source, range = line.scanf("%d %d %d"); [(source..source+range), dest - source] }
    pos += lines.count+1
end

seeds = specs.first.scan(/\d+/).map(&:to_i)
p seeds.map { |seed|
    steps.each { |step|
        match = step.find { |range, _| range.include?(seed) }
        seed += match[1] unless match.nil?
    }
    seed
}.min
