#!/usr/bin/env ruby
# Expected: 71503

time, distance = STDIN
    .readlines()
    .map { |line| line.split(":").last.gsub(/\s+/, "") }
    .map(&:to_i)

p (0..time).count { |hold| (time - hold) * hold > distance }
