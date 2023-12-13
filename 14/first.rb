#!/usr/bin/env ruby
# Expected: 136

def roll_north!(rows)
    loop do
        moved = false
        (1...rows.length).each { |y|
            row = rows[y]
            (0...row.length).each { |x|
                v = rows[y][x]
                next if v != "O"
                next if rows[y-1][x] != "."

                rows[y][x], rows[y-1][x] = ".", "O"
                moved = true
            }
        }
        break if !moved
    end
end

def load(rows)
    load = 0
    rows.each.with_index { |row, y|
        row.each.with_index { |v, x|
            load += (rows.length - y) if v == "O"
        }
    }
    load
end

rows = STDIN.readlines(chomp: true).map { |line| line.chars }
roll_north!(rows)
p load(rows)
