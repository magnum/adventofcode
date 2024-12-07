
require "pry"     

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

def calculate(lines, operators)
  total = 0
  lines.each do |line|
    wanted, values = line.split(":").map(&:strip)
    wanted = wanted.to_i
    values = values.split(" ").map(&:strip).map(&:to_i)
    valid = false
    operators.split(",").repeated_permutation(values.size-1) do |ops|
      result = ops.each_with_index.inject(values[0]) do |acc, (op, index)| 
        value = values[index+1]
        formula = "#{acc} #{op} #{values[index+1]}"
        (op == "||") ? "#{acc}#{value}".to_i : eval(formula)
      end
      next if result > wanted
      (valid = true ; next)  if result == wanted
    end
    puts "wanted: #{wanted} values: #{values} valid: #{valid}" if @debug
    total += wanted if valid
  end   
  total
end

result1 = calculate(lines, "+,*")
result2 = calculate(lines, "+,*,||")

puts "part1: #{result1}" if result1
puts "part2: #{result2}" if result2 

