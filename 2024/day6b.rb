# thanks to https://gist.github.com/vincentwoo/bff280de0b1fb16d4e511d85c339879a#file-aoc_2024_06-rb

DIRS = [ [-1, 0], [0, 1], [1, 0], [0, -1] ]

def count_loops map, pos, dir, seen, recurse
  loops = 0
  while true
    next_pos = DIRS[dir].zip(pos).map(&:sum)
    case map[next_pos]
    when true
      if recurse
        map[next_pos] = false
        loops += 1 if seen.none? { |_pos, _| _pos == next_pos } &&
                      count_loops(map, pos, dir, seen.clone, false)
        map[next_pos] = true
      end
      pos = next_pos
      return true unless seen.add? [pos, dir]
    when false
      dir = (dir + 1) % 4
    when nil
      return recurse && loops
    end
  end
end

def run input
  map = {}
  start = nil
  input.split("\n").each.with_index { |line, row|
    line.chars.each.with_index { |c, col|
      map[[row, col]] = c != '#'
      start = [row, col] if c == '^'
    }
  }
  p count_loops map, start, 0, Set.new([[start, 0]]), true
end

run $stdin.read