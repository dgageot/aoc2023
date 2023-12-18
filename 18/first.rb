#!/usr/bin/env ruby
# Expected: 62

require "scanf"

directions = {
    "R" => [ 0, +1],
    "D" => [+1,  0],
    "L" => [ 0, -1],
    "U" => [-1,  0],
}

Point = Struct.new(:y, :x)

actions = STDIN.readlines(chomp: true).map { |line| line.scanf("%s %d") }

border = actions.sum(&:last)

y, x = 0, 0
points = [Point.new(y, x)]
actions.each do |d, n|
    dy, dx = directions[d]
    y += n * dy
    x += n * dx
    points << Point.new(y, x)
end

# Shoelace formula
p border / 2 + 1 + points.each_cons(3).sum { |from, mid, to| mid.x * (from.y - to.y) }.abs / 2