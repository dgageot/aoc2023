#!/usr/bin/env ruby
# Expected: 6440

require "../common.rb"

def strength(card)
    "23456789TJQKA".index(card)
end

def kind(hand)
    count = hand.chars.tally
    return 6 if count.any? { |_,v| v == 5 }
    return 5 if count.any? { |_,v| v == 4 }
    return 4 if count.any? { |_,v| v == 3 } && count.any? { |_,v| v == 2 }
    return 3 if count.any? { |_,v| v == 3 }
    return 2 if count.count { |_,v| v == 2 } == 2
    return 1 if count.any? { |_,v| v == 2 }
    0
end

def compare(l, r)
    diff = kind(l) <=> kind(r)
    return diff if diff != 0
    l.chars.map { |c| strength(c) } <=> r.chars.map { |c| strength(c) }
end

p STDIN
    .readlines()
    .map { |line| line.scanf("%s %d") }
    .sort { |l, r| compare(l[0], r[0]) }
    .map.with_index { |h, i| h[1] * (i + 1) }
    .sum
