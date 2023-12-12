#!/usr/bin/env ruby
# Expected: 525152

require "parallel.rb"

def enumerate(cache, springs, groups, gi, gv)
    if springs.empty?
        return 1 if gi == groups.length-1 && gv == groups[gi]
        return 1 if gi == groups.length && gv == 0
    end

    cached = cache[[springs.length, gi, gv]]
    return cached unless cached.nil?

    count = 0
    first, rest = springs[0], springs[1..]
    if first == "." || first == "?"
        if gv == 0
            count += enumerate(cache, rest, groups, gi, 0)
        elsif groups[gi] == gv
            count += enumerate(cache, rest, groups, gi+1, 0)
        end
    end
    if first == "#" || first == "?"
        if (gi < groups.length) && (gv < groups[gi])
            count += enumerate(cache, rest, groups, gi, gv+1)
        end
    end

    cache[[springs.length, gi, gv]] = count
    count
end

rows = STDIN.readlines(chomp: true)
    .map { |line| line.split(" ") }
    .map { |first, last| [([first] * 5).join("?"), last.split(",").map(&:to_i) * 5] }

p Parallel.map(rows) { |springs, groups| enumerate({}, springs, groups, 0, 0) }.sum
