#!/usr/bin/env ruby
# Expected: 405

require "../common.rb"

def v_axis?(rows, x)
    width = rows[0].length
    len = [x, width-x].min
    rows.all? { |row|
        left = row[x-len...x]
        right = row[x...x+len]
        left == right.reverse
    }
end

def v_axis(g)
    (1...g[0].length).each { |x| return x if v_axis?(g, x) }
    0
end

p STDIN
    .readlines(chomp: true)
    .slice_on("")
    .map { |group| group.map(&:chars) }
    .sum { |p| v_axis(p) + 100 * v_axis(p.transpose) }
