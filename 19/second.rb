#!/usr/bin/env ruby
# Expected: 167409079868000

require "../common.rb"

Check = Struct.new(:letter, :sign, :value, :dest)
Rule = Struct.new(:name, :checks, :fallback)

def parseCheck(s)
    m = /(\w+)([<>])(\d+):(\w+)/.match(s)
    Check.new(m[1], m[2], m[3].to_i, m[4])
end

def parseRule(s)
    name, *checks, fallback = s.split(/[{,}]/)
    checks = checks.map(&method(:parseCheck))
    Rule.new(name, checks, fallback)
end

first, second = STDIN.readlines(chomp: true).slice_on("")
rules = first.map { |line| rule = parseRule(line); [rule.name, rule]}.to_h

score = 0
parts = [["in", {"x" => (1..4000), "m" => (1..4000), "a" => (1..4000), "s" => (1..4000)}]]
while !parts.empty? do
    queue, part = parts.shift
    next if queue == "R"

    combinations = part.values.map(&:count).inject(:*)
    next if combinations == 0

    if queue == "A"
        score += combinations
        next
    end

    rule = rules[queue]
    rule.checks.each do |check|
        letter = check.letter
        range = part[letter]

        copy = part.clone
        if check.sign == "<"
            copy[letter] = (range.min..[range.max, check.value-1].min)
            part[letter] = ([range.min, check.value].max..range.max)
        else
            copy[letter] = ([range.min, check.value+1].max..range.max)
            part[letter] = (range.min..[range.max, check.value].min)
        end
        parts << [check.dest, copy]
    end
    parts << [rule.fallback, part.clone]
end
p score