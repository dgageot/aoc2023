#!/usr/bin/env ruby
# Expected: 16

require "../common.rb"

@grid = Grid.new(STDIN.readlines(chomp: true).map(&:chars))

@orig = []
@grid.each { |y, x, v| @orig << [y, x] if v == "S" }
@orig.each { |y, x| @grid[y, x] = "." }

def solve(n)
    final = Set.new
    plots = [@orig[0]]

    (1..n).each { |step|
        tmp = Set.new
        plots.each do |y, x|
            tmp << [y - 1, x] unless final.include?([y - 1, x])
            tmp << [y + 1, x] unless final.include?([y + 1, x])
            tmp << [y, x - 1] unless final.include?([y, x - 1])
            tmp << [y, x + 1] unless final.include?([y, x + 1])
        end

        plots = tmp.select { |y, x| @grid[y % @grid.height, x % @grid.width] == "." }

        if step % 2 == n % 2
            for plot in plots
                final << plot
            end
        end
    }
    final.count
end

mid = @orig[0][0]
a, b, c = [0, 1, 2].map { |i| solve(@grid.width * i + mid) }
p a, b, c

# https://www.wolframalpha.com/input?i=quadratic+polynomial+for+points+%280%2C+3916%29%2C+%281%2C+34870%29%2C+%282%2C+96644%29
# 15410 x^2 + 15544 x + 3916
# x = (26501365 - mid) / @grid.width = 202300
# =630661863455116

n = (26501365 - mid) / @grid.width
p a+(n*b)-(n*a)+n*(n-1)*(a-2*b+c)/2
