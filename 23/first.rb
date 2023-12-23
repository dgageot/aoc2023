#!/usr/bin/env ruby
# Expected: 94

require "rb_heap"

@map = STDIN.readlines(chomp: true).map(&:chars)
# p @map

pq = Heap.new { |l, r| l[0] > r[0] }
pq << [0, 0, 1, ".", @map]

max = 0
loop do
    break if pq.empty?
    steps, y, x, previous, map = pq.pop

    if [y, x] == [map.length - 1, map[0].length - 2]
        max = steps if steps > max
        # puts "#{steps} #{max} #{pq.size}"
        # puts "\n" + map.map(&:join).join("\n")
        # return
    end

    options = []
    case previous
        when "."
            options = [[-1, 0], [+1, 0], [0, -1], [0, +1]]
        when "^"
            options = [[-1, 0]]
        when ">"
            options = [[0, +1]]
        when "v"
            options = [[+1, 0]]
        when "<"
            options = [[0, -1]]
    end

    for dy, dx in options
        ny = y + dy
        nx = x + dx
        if ny >= 0 && ny < map.length && nx >= 0 && nx < map[0].length
            v = map[ny][nx] 
            if v != "#" && v != "O"
                nmap = map.clone
                nmap[y] = nmap[y].clone
                nmap[y][x] = "O"
                pq << [steps + 1, ny, nx, v, nmap]
            end
        end
    end
end
p max
