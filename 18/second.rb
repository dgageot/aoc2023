#!/usr/bin/env ruby
# Expected: 952408144115

directions = {
    "0" => [ 0, +1],
    "1" => [+1,  0],
    "2" => [ 0, -1],
    "3" => [-1,  0],
}

Point = Struct.new(:y, :x)

actions = STDIN
    .readlines(chomp: true)
    .map { |line| line.split(" ") }
    .map { |line| [line[2][-2], line[2][2..-3].to_i(16)] }

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