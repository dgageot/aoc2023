#!/usr/bin/env ruby
# Expected: 145

def hash(text)
    hash = 0
    text.each_byte { |c| hash = ((hash + c) * 17) % 256 }
    hash
end

boxes = {}

STDIN
    .read()
    .split(",")
    .each { |op|
        _, text, sign, v = *(/(\w+)([=-])(\d*)/.match(op))

        h = hash(text)
        
        lenses = boxes[h]
        if lenses.nil?
            lenses = []
            boxes[h] = lenses
        end

        if sign == "="
            found = lenses.find { |t, v| t == text }
            if lenses.find { |t, v| t == text }.nil?
                boxes[h] << [text, v.to_i]
            else
                found[1] = v.to_i
            end
        else
            lenses.delete_if { |t, v| t == text }
        end
    }

count = 0
boxes.each { |k, list|
    list.each.with_index { |lens, i|
        count += ((k+1) * (i+1) * lens[1])
    }
}
p count