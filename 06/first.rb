#!/usr/bin/env ruby
# Expected: 288

require "../common.rb"

lines = STDIN
    .readlines()
    .map { |line| line.split(":").last }
    .map { |line| line.scanInts }

races = lines[0].zip(lines[1])

p races.map { |time, distance|
    (0..time).count { |hold| (time - hold) * hold > distance }
}.inject(:*)
