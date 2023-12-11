#!/usr/bin/env ruby
# Expected: 374

def cost(line)
    line.all? { |c| c == "." } ? 2 : 1
end

g = *STDIN.readlines(chomp: true).map(&:chars)

cost_rows = g.map(&method(:cost))
cost_cols = g.transpose.map(&method(:cost))
travel_cost = ->(from, to) {
    ([from[0], to[0]].min...[from[0], to[0]].max).sum { |y| cost_rows[y] } +
    ([from[1], to[1]].min...[from[1], to[1]].max).sum { |y| cost_cols[y] }
}

coords = []
g.each.with_index { |row, y| row.each.with_index { |v, x| coords << [y, x] if v == "#" } }

p coords.combination(2).sum { |from, to| travel_cost[from, to] }