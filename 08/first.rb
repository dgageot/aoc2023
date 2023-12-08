#!/usr/bin/env ruby
# Expected: 6

require "../common.rb"

groups = STDIN.readlines(chomp: true).slice_on("")
steps = groups[0][0].chars.map { |c| "LR".index(c) }
nodes = groups[1].to_h { |line| f, l, r = line.scan(/\w+/); [f, [l, r]] }

node = "AAA"
p 1 + steps.cycle.find_index { |step|
    node = nodes[node][step]
    node == "ZZZ"
}
