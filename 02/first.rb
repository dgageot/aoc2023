#!/usr/bin/env ruby
# Expected: 8

require "scanf"

p STDIN
    .readlines()
    .map { |line| line[5..].split /[:,;] / }
    .map { |first, *rest| [
        first,
        rest.map { |d| d.scanf("%d %s") }.group_by(&:pop).transform_values { |v| v.flatten.max },
    ]}
    .reject { |_, max| max["red"] > 12 || max["green"] > 13 || max["blue"] > 14 }
    .sum { |id, _| id.to_i }
