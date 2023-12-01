#!/usr/bin/env ruby
# Expected: 2286

require "scanf"

p STDIN
    .readlines()
    .map { |line| line[5..].split(/[:,;] /)[1..] }
    .sum { |line| line.map { |d| d.scanf("%d %s") }.group_by(&:pop).inject(1) { |p, (_, v)| p * v.flatten.max } }
