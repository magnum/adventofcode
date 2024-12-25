
require "pry"   
require "matrix"              

@debug = ARGV.index("--debug") || false
day = __FILE__.split("/").last.split(".").first.gsub("day","").to_i
filename = "day#{day}.txt"
filename = "day#{day}.test.txt" if ARGV.index("--test")
puts "filename: #{filename} debug: #{@debug}" 

def pause
  STDIN.gets.chomp if @debug
end
                    
@data = File.open(filename).read
.split("\n")
.each_with_index.with_object({}) { |(line, y), grid|
  line.chars.each_with_index { |c, x|
    grid[Vector[x, y]] = c
  }
}



def find_path
  start = @data.select { |k, v| v == 'S' }.keys.first
  goal = @data.select { |k, v| v == 'E' }.keys.first
  walls = @data.select { |k, v| v == '#' }.keys.to_set
  
  stepCnt = { start => 0 }
  visited = Set.new

  queue = [start]
  until queue.empty?
    pos = queue.shift
    visited << pos
    steps = stepCnt[pos]
    
    [Vector[-1,0], Vector[1,0], Vector[0,-1], Vector[0,1]].each do |d|
      newPos = pos + d
      next if (walls.include?(newPos) || visited.include?(newPos))
      stepCnt[newPos] = steps + 1
      queue << newPos
    end
  end
  stepCnt
end

def part_1
  maxCheat = 2
  stepCnt = find_path()
  stepCnt.to_a.sum { |pos, steps|
    # part 1 is faster to check all points on grid by max distance
    (-maxCheat..maxCheat).sum { |dx|
      (-maxCheat..maxCheat).count { |dy|
        pos2 = pos + Vector[dx, dy]
        next if (dx==0 && dy==0) 
        next if (dx.abs + dy.abs > maxCheat)
        next unless stepCnt.key?(pos2)
        stepCnt[pos2] - (steps + (dx.abs + dy.abs)) >= 100
      }
    }
  }
end

def part_2
  maxCheat = 20
  stepCnt = find_path()
  points = stepCnt.keys.to_set
  stepCnt.to_a.sum { |pos1, step1|
    # part 2 is faster to check each pair of points on the path
    points.delete(pos1).count{ |pos2|
      cheat = (pos2[0] - pos1[0]).abs + (pos2[1] - pos1[1]).abs
      next if cheat > maxCheat
      stepCnt[pos2] - (step1 + cheat) >= 100
    }
  }
end

puts part_1
puts part_2