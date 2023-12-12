#!/usr/bin/env ruby
# Expected: 21

def enumerate(springs, groups, gi, gv)
    if springs.empty?
        return 1 if gi == groups.length-1 && gv == groups[gi]
        return 1 if gi == groups.length && gv == 0
    end

    count = 0
    first, rest = springs[0], springs[1..]
    if first == "." || first == "?"
        if gv == 0
            count += enumerate(rest, groups, gi, 0)
        elsif groups[gi] == gv
            count += enumerate(rest, groups, gi+1, 0)
        end
    end
    if first == "#" || first == "?"
        if (gi < groups.length) && (gv < groups[gi])
            count += enumerate(rest, groups, gi, gv+1)
        end
    end
    count
end

rows = STDIN.readlines(chomp: true)
    .map { |line| line.split(" ") }
    .map { |first, last| [first, last.split(",").map(&:to_i)] }

p rows.sum { |springs, groups| enumerate(springs, groups, 0, 0) }
