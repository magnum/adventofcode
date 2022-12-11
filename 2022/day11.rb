
require "pry"                        

@monkeys = []
class Monkey 
  attr :items
  attr :operation
  attr :id
  attr :inspected_count
  def initialize(id, items, operation=nil, test=nil)
    @id = id
    @items = items
    @operation = operation
    @test = test
    @inspected_count = 0
  end
  def evaluate(monkeys)
    @inspected_count += @items.length
    @items.length.times do |i|
      item = @items.shift
      value = item
      value = eval(@operation)
      value = (value.to_f / 3).floor
      monkey_to = eval(@test)
      monkeys[monkey_to].items << value
      #puts "monkey #{@id}, evaluate item #{item}, became #{value} and throw at monkey #{monkey_to}"
    end
    #puts "-"*30
  end

end

lines = File.open("day11.txt").read
.split("\n").each_slice(7).with_index do |slice, index|
  @monkeys << Monkey.new(
    index,
    slice[1].split(":").last.split(",").map(&:strip).map(&:to_i),
    "#{slice[2].split(":").last.split("=").last.strip.gsub("old", "value")}",
    "value % #{slice[3].split("divisible by").last.strip.to_i} == 0 ? #{slice[4].scan(/\d/).first.to_i} : #{slice[5].scan(/\d/).first.to_i}"
  )
end

def monkeys_report
  @monkeys.each_with_index do |monkey, index|
    puts "Monkey #{index}, inspected_count: #{monkey.inspected_count}, items, #{monkey.items.join(", ")}"
  end
end

20.times do |round|
  @monkeys.each do |monkey|
    monkey.evaluate(@monkeys)
  end
end
monkeys_report
result1 = @monkeys.map(&:inspected_count).sort.reverse.take(2).inject(:*)
result2 = nil
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

