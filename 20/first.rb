#!/usr/bin/env ruby
# Expected: 32000000

Mod = Struct.new(:name, :type, :outputs, :state)

def parseModule(line)
    from, to = line.split(" -> ")
    if from == "broadcaster"
        type = ""
        name = from
    else
        type = from[0]
        name = from[1..]
    end
    Mod.new(name, type, to.split(", "))
end

modules = STDIN
    .readlines(chomp: true)
    .map { |line| parseModule(line) }
    .to_h { |m| [m.name, m] }

modules.each do |name, mod|
    if mod.type == "&"
        mod.state = modules.values.select { |m| m.outputs.include?(name) }.to_h { |k| [k.name, false ] }
    elsif mod.type == "%"
        mod.state = false
    end
end

actions = []
highs = 0
lows = 0
1000.times do
    actions << ["button", "broadcaster", false]
    while !actions.empty? do
        from, name, high = actions.shift

        if high then highs += 1 else lows += 1 end

        mod = modules[name]
        next if mod.nil?

        case mod.type
        when "%"
            next if high
            mod.state = !mod.state
            high = mod.state
        when "&"
            mod.state[from] = high
            high = mod.state.value?(false)
        end

        for to in mod.outputs do
            actions << [name, to, high]
        end
    end
end
p highs * lows