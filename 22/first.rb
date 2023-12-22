#!/usr/bin/env ruby
# Expected: 5

bricks = STDIN
    .readlines(chomp: true)
    .map { |line| line.split("~").map { |coord| coord.split(",").map(&:to_i) } }

def coords(brick)
    from, to = brick
    x1, y1, z1 = from
    x2, y2, z2 = to
    dx = (x2 - x1) <=> 0
    dy = (y2 - y1) <=> 0
    dz = (z2 - z1) <=> 0

    current = from
    coords = []
    loop do
        coords << current
        break if current == to
        current = [current[0] + dx, current[1] + dy, current[2] + dz]
    end
    coords
end

def used(bricks)
    stack = {}
    bricks.each do |brick|
        for coord in coords(brick)
            stack[coord] = true
        end
    end
    stack
end

def fall(bricks, stack)
    loop do
        changed = false
        bricks.each_with_index do |brick, i|
            coords_brick = coords(brick)
    
            # Can fall?
            next if coords_brick.any? { |_, _, z| z == 1 }
    
            # Remove
            for coord in coords_brick
                stack[coord] = false
            end
    
            # Test fall by one
            if coords_brick.none? { |coord| stack[[coord[0], coord[1], coord[2] - 1]] }
                changed = true
                bricks[i] = [[brick[0][0], brick[0][1], brick[0][2]-1], [brick[1][0], brick[1][1], brick[1][2]-1]]
                coords_brick = coords(bricks[i])
            end
    
            # Put back
            for coord in coords_brick
                stack[coord] = true
            end
        end
        break unless changed
    end
end

stack = used(bricks)
fall(bricks, stack)

result = 0
bricks.each_with_index do |removed, i|
    # Remove
    coords_removed = coords(removed)
    for coord in coords_removed
        stack[coord] = false
    end

    safe = true
    bricks.each_with_index do |brick, j|
        next if i == j

        coords_brick = coords(brick)
        next if coords_brick.any? { |_, _, z| z == 1 }

        # Remove
        for coord in coords_brick
            stack[coord] = false
        end

        safe = coords_brick.any? { |coord| stack[[coord[0], coord[1], coord[2] - 1]] }

        # Put back
        for coord in coords_brick
            stack[coord] = true
        end

        break if !safe
    end
    result += 1 if safe

    # Put back
    for coord in coords_removed
        stack[coord] = true
    end
end
p result