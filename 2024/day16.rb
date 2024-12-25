require "pry"                 
require 'set'
require 'matrix'
require 'time'

S = Time.now

@debug = ARGV.index("--debug") || false
day = __FILE__.split("/").last.split(".").first.gsub("day","").to_i
filename = "day#{day}.txt"
filename = "day#{day}.test.txt" if ARGV.index("--test")
puts "filename: #{filename} debug: #{@debug}" 

def pause
  STDIN.gets.chomp if @debug
end
                    
lines = File.open(filename).read
.split("\n")   
#binding.pry
result1 = nil
result2 = nil
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2

carte = {}
File.open('day16.txt', 'r').each_with_index do |line, y|
  line.chomp.chars.each_with_index do |char, x|
    carte[Vector[x, y]] = char
  end
end

ymax = carte.keys.map { |p| p[1] }.max
xmax = carte.keys.map { |p| p[0] }.max

start = nil
fin = nil

(0..ymax).each do |y|
  (0..xmax).each do |x|
    pos = Vector[x, y]
    if carte[pos] == 'S'
      start = pos
      carte[pos] = '.'
    elsif carte[pos] == 'E'
      fin = pos
      carte[pos] = '.'
    end
  end
end

def isvalid(pos, xmax, ymax, carte)
  pos[0] >= 0 && pos[0] < xmax && pos[1] >= 0 && pos[1] < ymax && carte[pos] == '.'
end

def voisins(state, xmax, ymax, carte)
  pos, dir = state
  vois = []
  [dir, dir * Complex(0, 1), dir * Complex(0, -1)].each do |newdir|
    newpos = pos + newdir
    if isvalid(newpos, xmax, ymax, carte)
      vois << [(newdir == dir ? 1 : 1001), [newpos, newdir]]
    end
  end
  vois
end

debut = [start, Complex(1, 0)]
fin = fin

def dijkstra2(debut, fin, xmax, ymax, carte)
  q = [[0, 0, debut]]
  dists = { debut => 0 }
  predecessors = Hash.new { |h, k| h[k] = Set.new }
  counter = 0

  until q.empty?
    dist, _, state = q.shift
    pos, dir = state

    return [dist, predecessors] if pos == fin

    voisins(state, xmax, ymax, carte).each do |cost, v|
      if dist + cost <= dists.fetch(v, Float::INFINITY)
        counter += 1
        dists[v] = dist + cost
        if v[0] == fin
          predecessors[fin] << state
        else
          predecessors[v] << state
        end
        q << [dist + cost, counter, v]
        q.sort_by!(&:first)
      end
    end
  end
  [Float::INFINITY, predecessors]
end

def getpreds(pos, debut, predecessors)
  return Set.new if pos == debut

  peres = predecessors[pos]
  peres + peres.flat_map { |p| getpreds(p, debut, predecessors) }
end

dist, predecessors = dijkstra2(debut, fin, xmax, ymax, carte)
puts "Part 1: #{dist}"
puts "Part 2: #{1 + getpreds(fin, debut, predecessors).map(&:first).uniq.size}"

