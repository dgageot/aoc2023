#!/usr/bin/env ruby
# Expected: 46

require "../common.rb"

lines = STDIN.readlines(chomp: true)

seeds = IntervalSet[*lines.first.scanInts.each_slice(2).map { |from, n| from...from+n }]
steps = lines[2..].slice_on("").map { |group| group[1..].map { |line| dst, src, n = line.scanInts; [src..src+n, dst - src] }}

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