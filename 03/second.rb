#!/usr/bin/env ruby
# Expected: 467835

grid = STDIN.readlines(chomp: true).map { |line| line.chars }

def gear?(grid, y, x)
    (grid[y] || [])[x] == "*"
end

def search_gears(grid)
    grid.each.with_index do |row, y|
        x = 0
        groups = row.join.split(/(\d+)/)
        groups.each do |group|
            if /\d+/.match(group)
                (y-1..y+1).each do |yy|
                    (x-1..x+group.length).each do |xx|
                        yield [[yy, xx], group.to_i] if gear?(grid, yy, xx)
                    end
                end
            end

            x += group.length
        end
    end
end

found = []
search_gears(grid) { |gear| found << gear }
p found.group_by(&:shift).values.select { |v| v.length == 2}.map(&:flatten).sum { |pair| pair[0] * pair[1] }
