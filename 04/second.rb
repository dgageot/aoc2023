#!/usr/bin/env ruby
# Expected: 30

wins = STDIN
.readlines()
.map.with_index { |line, i| [i+1, line.scan(/\d+/)[1..].tally.count{ |_,v| v == 2}] }.to_h

p Enumerator.new { |found|
    won = (1..wins.count).to_a
    loop do
        found << won.count
        won = won.flat_map { |card| (card+1..card+wins[card]).to_a }
    end
}.take_while(&:positive?).sum
