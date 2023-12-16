#!/usr/bin/env ruby
# Expected: 46

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

p cast([0, -1], "R")
