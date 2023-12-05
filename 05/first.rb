#!/usr/bin/env ruby
# Expected: 35

require "../common.rb"

lines = STDIN.readlines(chomp: true)

seeds = lines.first.scanInts()
steps = lines[2..].slice_on("").map { |group| group[1..].map { |line| dst, src, n = line.scanInts; [src..src+n, dst - src] }}
p seeds.map { |seed|
    steps.inject(seed) { |seed, step|
        match = step.find { |range, _| range.include?(seed) }
        seed += match[1] unless match.nil?
        seed
    }
}.min
