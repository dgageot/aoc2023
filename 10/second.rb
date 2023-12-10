#!/usr/bin/env ruby
# Expected: 4

require "matrix.rb"

g = Matrix[*STDIN.readlines(chomp: true).map(&:chars)]

loop do
    removed = 0
    g.each_with_index do |v, y, x|
        remove =
            case v
            when "|"
                !(/[|7FS]/ =~ g[y-1, x+0] && /[|JLS]/ =~ g[y+1, x+0])
            when "7"
                !(/[-LFS]/ =~ g[y+0, x-1] && /[|JLS]/ =~ g[y+1, x+0])
            when "J"
                !(/[|7FS]/ =~ g[y-1, x+0] && /[-LFS]/ =~ g[y+0, x-1])
            when "-"
                !(/[-LFS]/ =~ g[y+0, x-1] && /[-J7S]/ =~ g[y+0, x+1])
            when "L"
                !(/[|7FS]/ =~ g[y-1, x+0] && /[-7JS]/ =~ g[y+0, x+1])
            when "F"
                !(/[-7JS]/ =~ g[y+0, x+1] && /[|JLS]/ =~ g[y+1, x+0])
            end
        if remove
            removed += 1
            g[y, x] = "."
        end
    end
    break if removed == 0
end

p g.each_with_index.count { |v, y, x|  v == "." && g[y, 0...x].count { |_| /[|JL]/.match(_) }.odd?}
