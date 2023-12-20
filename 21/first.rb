#!/usr/bin/env ruby
# Expected: 16

require "../common.rb"

@grid = Grid.new(STDIN.readlines(chomp: true).map(&:chars))

plots = Set.new
@grid.each { |y, x, v| plots << [y, x] if v == "S" }
plots.each { |y, x| @grid[y, x] = "." }

(1..6).each { |step|
    previous = plots.to_a
    plots = Set.new

    previous.each { |y, x|
        [[-1, 0], [+1, 0], [0, -1], [0, +1]].each { |dy, dx|
            if @grid[y + dy, x + dx] == "."
                plots << [y + dy, x + dx]
            end
        }
    }
}
p plots.count