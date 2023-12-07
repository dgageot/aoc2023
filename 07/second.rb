#!/usr/bin/env ruby
# Expected: 5905

require "../common.rb"

def strength(card)
    "J23456789TQKA".index(card)
end

def tallyJ(hand)
    t = hand.chars.tally
    countJ = t['J']

    return t if countJ.nil?
    return {"A" => 5} if countJ == 5

    t.delete("J")
    max = t.max_by { |k,v| v * 100 + strength(k) }[0]
    t[max] += countJ
    t
end

def kind(hand)
    count = tallyJ(hand)
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
    .map.with_index { |hand, index| hand[1] * (index + 1) }
    .sum
