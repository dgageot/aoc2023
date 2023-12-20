#!/usr/bin/env ruby
# Expected: 32000000

Mod = Struct.new(:name, :type, :outputs, :state)

def parseModule(line)
    from, to = line.split(" -> ")
    _, type, name = /([&%])?(.*)/.match(from).to_a
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

previous = modules.values.select { |m| m.outputs.include?("rx")}.first
cycles = previous.state.keys.to_h { |k| [k, 0] }

(1..).each do |times|
    actions = [["button", "broadcaster", false]]
    while !actions.empty? do
        from, name, high = actions.shift

        mod = modules[name]
        next if mod.nil?

        case mod.type
        when "%"
            next if high
            mod.state = !mod.state
            high = mod.state
        when "&"
            if name == previous.name && high
                cycles[from] = times if cycles[from] == 0
                if !cycles.value?(0)
                    p cycles.values.inject(1, :lcm)
                    return
                end
            end
    
            mod.state[from] = high
            high = mod.state.value?(false)
        end

        for to in mod.outputs do
            actions << [name, to, high]
        end
    end
end
