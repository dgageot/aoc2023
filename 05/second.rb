#!/usr/bin/env ruby
# Expected: 46

require "scanf"
require "stringio"
require "interval_set"

specs = STDIN.readlines(chomp: true)

steps = []
pos = 2
while pos < specs.count do
    lines = specs[pos..].take_while { |line| !line.empty? }
    steps << lines[1..].map { |line| dest, source, range = line.scanf("%d %d %d"); [IntervalSet[source..source+range], dest - source] }
    pos += lines.count+1
end

seeds = IntervalSet[*specs.first.scan(/\d+/).map(&:to_i).each_slice(2).map { |from, n| (from...from+n) }]
steps.each { |step|
    added = IntervalSet.new
    step.each { |range, shift|
        intersection = seeds.intersection(range)
        seeds.remove(range)
        intersection.each { |i| added.add((i.first+shift)..(i.last+shift)) }
    }
    seeds.add(added)
}
p seeds.first.first