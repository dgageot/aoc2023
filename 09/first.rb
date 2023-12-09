#!/usr/bin/env ruby
# Expected: 114

def predict(line)
    return 0 if line.all?(&:zero?)
    diff = line.each_cons(2).map { |l, r| r - l }
    line.last + predict(diff)
end

p STDIN
    .readlines(chomp: true)
    .map { |line| line.split(" ").map(&:to_i) }
    .sum(&method(:predict))
