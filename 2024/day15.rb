
require "pry"  
require 'matrix'               

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


DIR = { 
  "^" => Vector[-1, 0],
  "v" => Vector[1, 0],
  ">" => Vector[0, 1],
  "<" => Vector[0, -1] 
}

def move(grid, pos, dir)
  return false if(grid[pos] == '#')
  return true if(grid[pos] == '.')
  return false unless(move(grid, pos + dir, dir))
  grid[pos + dir], grid[pos] = grid[pos], '.'
  return true 
end

def move_list(grid, list, dir)
  return false if(list.any? { grid[_1] == '#' })
  return true if(list.all? { grid[_1] == '.' })
  posBoxes = list.map { |p|
    if(grid[p] == '[')
      [p, p + DIR['>']]
    elsif(grid[p] == ']')
      [p + DIR['<'], p]
    end
  }.compact.flatten.uniq
  return false unless(move_list(grid, posBoxes.map { |p| p + dir }, dir))
  posBoxes.each { |p| grid[p+dir], grid[p] = grid[p], '.' }
  return true 
end

def part_1
  layout, moves = @data.slice_when { |l| l.empty? }.to_a
  grid = layout.each_with_index.with_object({}) { |(line, y), grid|
    line.chars.each_with_index { |c, x|
      if(c == '@')
        grid['pos'] = Vector[y, x]
        grid[Vector[y, x]] = '.'
      else
        grid[Vector[y, x]] = c
      end
    }
  }
  moves.join.chars.each { |m|
    grid['pos'] += DIR[m] if(move(grid, grid['pos'] + DIR[m], DIR[m]))
  }
  grid.select { |k,v| v == 'O' }.keys.sum { |k| k[0] * 100 + k[1]}
end

def part_2
  layout, moves = @data.slice_when { |l| l.empty? }.to_a
  grid = layout.each_with_index.with_object({}) { |(line, y), grid|
    line.chars.each_with_index { |c, x|
      case(c)
      when '@'
        grid['pos'] = Vector[y, x*2]
        grid[Vector[y, x*2]], grid[Vector[y, x*2+1]] = '.', '.'
      when 'O'
        grid[Vector[y, x*2]], grid[Vector[y, x*2+1]] = '[', ']'
      else
        grid[Vector[y, x*2]], grid[Vector[y, x*2+1]] = c, c
      end
    }
  }
  moves.join.chars.each { |m|
    if([DIR['>'], DIR['<']].include?(DIR[m])) 
      grid['pos'] += DIR[m] if(move(grid, grid['pos'] + DIR[m], DIR[m]))
    else
      grid['pos'] += DIR[m] if(move_list(grid, [grid['pos'] + DIR[m]], DIR[m]))
    end
  }
  grid.select { |k,v| v == '[' }.keys.sum { |k| k[0] * 100 + k[1]}
end


puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"