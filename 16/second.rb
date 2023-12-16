#!/usr/bin/env ruby
# Expected: 51

require "../common.rb"

@moves = {
    "R" => [+0, +1],
    "L" => [+0, -1],
    "T" => [-1, +0],
    "B" => [+1, +0],
}

@reflect = {
    [".", "T"] => "T",
    [".", "B"] => "B",
    [".", "R"] => "R",
    [".", "L"] => "L",

    ["\\", "T"] => "L",
    ["\\", "B"] => "R",
    ["\\", "R"] => "B",
    ["\\", "L"] => "T",

    ["/", "T"] => "R",
    ["/", "B"] => "L",
    ["/", "R"] => "T",
    ["/", "L"] => "B",

    ["|", "T"] => "T",
    ["|", "B"] => "B",
    ["|", "R"] => "T",
    ["|", "L"] => "T",

    ["-", "T"] => "R",
    ["-", "B"] => "R",
    ["-", "R"] => "R",
    ["-", "L"] => "L",
}

@map = Grid.new(STDIN.readlines(chomp: true).map(&:chars))

def cast(pos, direction)
    seen = Set[]

    beams = [[pos, direction]]
    while !beams.empty? do
        pos, direction = *beams.shift
        loop do
            pos = pos.zip(@moves[direction]).map(&:sum)
            break if seen.include?([pos, direction])

            v = @map[*pos]
            break if v.nil?

            seen.add([pos, direction])
            
            beams << [pos, "B"] if v == "|" && (direction == "R" || direction == "L")
            beams << [pos, "L"] if v == "-" && (direction == "T" || direction == "B")
            direction = @reflect[[v, direction]]
        end
    end

    Set[*seen.map(&:first)].count
end

p [
    (0...@map.width).map { |x| cast([-1, x], "B") }.max,
    (0...@map.width).map { |x| cast([@map.height, x], "T") }.max,
    (0...@map.height).map { |y| cast([y, -1], "R") }.max,
    (0...@map.height).map { |y| cast([y, @map.height], "L") }.max,
].max
