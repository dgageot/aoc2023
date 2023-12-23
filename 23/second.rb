#!/usr/bin/env ruby
# Expected: 154

require "../common.rb"

@map = Grid.new(STDIN.readlines(chomp: true).map(&:chars))

points = [[0, 1], [@map.height - 1, @map.width - 2]]
@map.each do |y, x, v|
    next if v == "#"
    neighbors = [[-1, 0], [+1, 0], [0, -1], [0, +1]].count do |dy, dx|
        n = @map[y + dy, x + dx]
        n != nil && n != "#"
    end
    points << [y, x] if neighbors >= 3
end

Node = Struct.new(:seen, :out, :final)
@nodes = points.to_h { |point| [point, Node.new(false, [])] }

for src in @nodes.keys
    seen = [src].to_set
    stack = [[0, src]]

    while !stack.empty?
        n, dest = stack.pop

        if n != 0 && @nodes[dest]
            @nodes[src].out << [@nodes[dest], n]
            next
        end

        for dy, dx in [[-1, 0], [+1, 0], [0, -1], [0, +1]]
            npt = [dest[0] + dy, dest[1] + dx]

            v = @map[*npt]
            if v != nil && v != "#" && !seen.include?(npt)
                stack << [n + 1, npt]
                seen << npt
            end
        end
    end
end

def dfs(pt)
    return 0 if pt.final

    pt.seen = true
    max = pt.out.filter_map { |dest, n| dfs(dest) + n if !dest.seen }.max || -Float::INFINITY
    pt.seen = false
    max
end

@nodes[[@map.height - 1, @map.width - 2]].final = true
p dfs(@nodes[[0, 1]])
