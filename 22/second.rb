#!/usr/bin/env ruby
# Expected: 7

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
    fallen = Set.new
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
                fallen << i
            end
    
            # Put back
            for coord in coords_brick
                stack[coord] = true
            end
        end
        break unless changed
    end
    fallen
end

stack = used(bricks)
fall(bricks, stack)
orig_stack = stack
orig_bricks = bricks

would_fall = 0
orig_bricks.each_with_index do |removed, i|
    stack = orig_stack.clone
    bricks = orig_bricks.clone

    # Remove
    for coord in coords(removed)
        stack[coord] = false
    end
    bricks.delete_at(i)

    fallen = fall(bricks, stack)
    would_fall += fallen.count
end
p would_fall