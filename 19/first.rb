#!/usr/bin/env ruby
# Expected: 19114

require "../common.rb"

Check = Struct.new(:name, :sign, :value, :dest)
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

def parsePart(s)
    s[1..-2].split(",").map { |v| s = v.split("="); [s[0], s[1].to_i] }.to_h
end

def check?(p, c)
    c.sign == "<" ? p[c.name] < c.value : p[c.name] > c.value
end

first, second = STDIN.readlines(chomp: true).slice_on("")
rules = first.map { |line| rule = parseRule(line); [rule.name, rule]}.to_h
parts = second.map{ |line| parsePart(line) }

score = 0
parts.each do |part|
    queue = "in"
    while rules[queue] do
        rule = rules[queue]
        queue = rule.checks.find { |c| check?(part, c) }&.dest || rule.fallback
        score += part.values.sum if queue == "A"
    end
end
p score