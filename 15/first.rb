#!/usr/bin/env ruby
# Expected: 1320

def hash(text)
    hash = 0
    text.each_byte { |c| hash = ((hash + c) * 17) % 256 }
    hash
end

p STDIN
    .read()
    .split(",")
    .sum(&method(:hash))
