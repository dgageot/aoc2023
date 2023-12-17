#!/usr/bin/env ruby
# Expected: 94

require "../common.rb"
require "rgl/adjacency"
require "rgl/dijkstra.rb"

def add_edges(directionF, y, x, directionT, dY, dX)
    from = "#{directionF} #{y} #{x}"
    heat = 0

    (1..10).each do |i|
        h = @grid[y+dY*i, x+dX*i]
        break if h.nil?
        heat += h

        if i >= 4
            to = "#{directionT} #{y+dY*i} #{x+dX*i}"
            e = @G.add_edge(from, to)
            @heat[[from, to]] = heat
        end
    end
end

@G = RGL::DirectedAdjacencyGraph.new
@heat = Hash.new(0)

@grid = Grid.new(STDIN.readlines(chomp: true).map { |line| line.chars.map(&:to_i) })
@grid.each do |y, x|
    ["W", "E"].each { |d| add_edges("N", y, x, d, +1,  0) }
    ["W", "E"].each { |d| add_edges("S", y, x, d, -1,  0) }
    ["N", "S"].each { |d| add_edges("E", y, x, d,  0, -1) }
    ["N", "S"].each { |d| add_edges("W", y, x, d,  0, +1) }
end

@G.add_edge("BEGIN", "N 0 0")
@G.add_edge("BEGIN", "W 0 0")
@G.add_edge("N #{@grid.height - 1} #{@grid.width - 1}", "END")
@G.add_edge("W #{@grid.height - 1} #{@grid.width - 1}", "END")

path = @G.dijkstra_shortest_path(@heat, "BEGIN", "END")
p path.each_cons(2).sum { |from, to| @heat[[from, to]] }
