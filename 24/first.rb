#!/usr/bin/env ruby
# Expected: 2

Stone = Struct.new(:x, :y, :z, :vx, :vy, :vz)


stones = STDIN
    .readlines(chomp: true)
    .map { |line| Stone.new(*line.split(/[,@]/).map(&:to_i)) }

if stones.count == 5
    MIN = 7
    MAX = 27
else
    MIN = 200000000000000
    MAX = 400000000000000
end
    
def line_intersection(x1, y1, x2, y2, x3, y3, x4, y4)
    a1 = y2 - y1
    b1 = x1 - x2
    c1 = a1 * x1 + b1 * y1
    
    a2 = y4 - y3
    b2 = x3 - x4
    c2 = a2 * x3 + b2 * y3
    
    determinant = (a1 * b2 - a2 * b1).to_f
    
    return nil if determinant.zero?
    
    x = (b2 * c1 - b1 * c2) / determinant
    y = (a1 * c2 - a2 * c1) / determinant
    [x, y]
end

def cross?(x1, y1, x2, y2, x3, y3, x4, y4)
    inter = line_intersection(x1, y1, x2, y2, x3, y3, x4, y4)
    return false if inter.nil?

    x, y = inter
    return false if x < MIN || x > MAX || y < MIN || y > MAX

    return false if x < x1 if x1 < x2
    return false if x > x1 if x1 > x2
    return false if x < x3 if x3 < x4
    return false if x > x3 if x3 > x4
    return false if y < y1 if y1 < y2
    return false if y > y1 if y1 > y2
    return false if y < y3 if y3 < y4
    return false if y > y3 if y3 > y4

    true
end

p stones
    .map { |stone| [[stone.x, stone.y], [stone.x + stone.vx, stone.y + stone.vy]] }
    .combination(2)
    .count { |l, r| cross?(*l.flatten, *r.flatten) }
