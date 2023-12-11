#!/usr/bin/env ruby
# Expected: 4361

grid = STDIN.readlines(chomp: true).map { |line| line.chars }

def symbol?(grid, y, x)
    v = grid.dig(y, x)
    !(v.nil? || /[\.\d]/.match(v))
end

def near_symbol?(grid, group, y, x)
    (y-1..y+1).any? { |yy| (x-1..x+group.length).any? { |xx| symbol?(grid, yy, xx) } }
end

def find_numbers(grid)
    grid.each.with_index do |row, y|
        x = 0
        groups = row.join.split(/(\d+)/)
        groups.each do |group|
            yield group.to_i if /\d+/.match(group) && near_symbol?(grid, group, y, x)
            x += group.length
        end
    end
end

sum = 0
find_numbers(grid) { |n| sum += n }
p sum
