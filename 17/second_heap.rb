#!/usr/bin/env ruby
# Expected: 94

require "rb_heap"

grid = STDIN.readlines(chomp: true).map { |line| line.chars.map(&:to_i) }

in_grid = ->(y, x) { y >= 0 && y < grid.length && x >= 0 && x < grid[0].length }

seen = Set[]
pq = Heap.new { |l, r| l[0] < r[0] }
pq << [0, 0, 0, 0, 0, 0]

loop do
    hl, y, x, dy, dx, n = pq.pop

    if [y, x] == [grid.length - 1, grid[0].length - 1] && n >= 4
        p hl
        return
    end

    next if seen.add?([y, x, dy, dx, n]).nil?

    if n < 10 && [dy, dx] != [0, 0]
        ny = y + dy
        nx = x + dx
        pq << [hl + grid[ny][nx], ny, nx, dy, dx, n + 1] if in_grid[ny, nx]
    end

    if n >= 4 || [dy, dx] == [0, 0]
        for ndy, ndx in [[0, 1], [1, 0], [0, -1], [-1, 0]] - [[dy, dx], [-dy, -dx]]
            ny = y + ndy
            nx = x + ndx
            pq << [hl + grid[ny][nx], ny, nx, ndy, ndx, 1] if in_grid[ny, nx]
        end
    end
end