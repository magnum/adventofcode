
require "pry"                 

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


def part_1
  pattern = /^#{Regexp.union(*@data[0].split(', '))}+$/
  @data[2..].count { |design| design =~ pattern }
end

def count_paths(design, pattern, cache)
  return 1 if design.empty?

  cache[design] ||=
    pattern.select { |p| design.start_with?(p) }
            .sum { |p| count_paths(design[p.length..], pattern, cache) }
end

def part_2
  pattern = @data[0].split(', ')
  cache = {}
  @data[2..].sum { |design| count_paths(design, pattern, cache) }
end

puts part_1
puts part_2
