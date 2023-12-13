#!/usr/bin/env ruby
# Expected: 64

rows = STDIN.readlines(chomp: true).map { |line| line.chars }

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

def roll_south!(rows)
    loop do
        moved = false
        (0...(rows.length-1)).to_a.reverse.each { |y|
            row = rows[y]
            (0...row.length).each { |x|
                v = rows[y][x]
                next if v != "O"
                next if rows[y+1][x] != "."

                rows[y][x], rows[y+1][x] = ".", "O"
                moved = true
            }
        }
        break if !moved
    end
end

def roll_east!(rows)
    loop do
        moved = false
        (0...rows.length).to_a.reverse.each { |y|
            row = rows[y]
            (0...(row.length-1)).to_a.reverse.each { |x|
                v = rows[y][x]
                next if v != "O"
                next if rows[y][x+1] != "."

                rows[y][x], rows[y][x+1] = ".", "O"
                moved = true
            }
        }
        break if !moved
    end
end

def roll_west!(rows)
    loop do
        moved = false
        (0...rows.length).to_a.reverse.each { |y|
            row = rows[y]
            (1...row.length).each { |x|
                v = rows[y][x]
                next if v != "O"
                next if rows[y][x-1] != "."

                rows[y][x], rows[y][x-1] = ".", "O"
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

seen = {}
loads = {}

n = 1000000000
n.times do |i|
    loads[i] = load(rows)

    before = rows.map { |line| line.join }.join("\n")
    if seen[before] != nil
        cycle = seen[before]
        length = i - cycle
        p loads[cycle + (n - cycle) % length]
        return
    end
    seen[before] = i

    roll_north!(rows)
    roll_west!(rows)
    roll_south!(rows)
    roll_east!(rows)
end
