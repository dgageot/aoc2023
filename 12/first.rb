#!/usr/bin/env ruby
# Expected: 21
# 7402

def combine(springs, prefix, &block)
    if springs.empty?
        yield prefix
        return
    end
    first, rest = springs[0], springs[1..]
    if first == "." || first == "#"
        combine(rest, prefix + first, &block)
    else
        combine(rest, prefix + ".", &block)
        combine(rest, prefix + "#", &block)
    end
end

def count_groups(line)
    line.split(".").map(&:length).reject(&:zero?)
end

rows = STDIN.readlines(chomp: true)
    .map { |line| line.split(" ") }
    .map { |first, last| [first, last.split(",").map(&:to_i)] }

count = 0
rows.each do |springs, groups|
    combine(springs, "") { |line| count += 1 if count_groups(line) == groups }
end
p count
