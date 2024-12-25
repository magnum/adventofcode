
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
  schematics = @data.slice_when { |l| l.empty? }.map { |group| group.reject(&:empty?) }.to_a
  locks = []
  keys = []
  schematics.each { |schematic|
    t = schematic.map(&:chars).transpose.map { |r|
      if(r[0] == '.')
        6 - r.index('#')
      else
        r.index('.') - 1
      end
    }
    locks << t && next if(schematic[0].chars.all? { |c| c == '#' })
    keys << t && next if(schematic[-1].chars.all? { |c| c == '#' })
  }

  locks.sum { |l|
    keys.count { |k|
        l.zip(k).all? { |a, b| a + b <= 5 }
    }
  }
end

puts part_1


