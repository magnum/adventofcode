require 'open-uri'
require 'pry'

def execute(instructions, only_complete=false)
  steps = []
  acc = i = 0
  while steps.length < instructions.count*10
    c,p = instructions[i]
    i+= c == "jmp" ? p.to_i : 1
    acc += (p.to_i) if c == "acc"
    break if steps.index(i) || (i == instructions.length)
    steps << i
  end
  completed = (i == instructions.length)
  puts "acc #{acc}, steps: #{steps.length}, i: #{i}, completed? #{completed}" if !only_complete || (only_complete && completed)
  i
end

#part 1
statements = open('8.txt') {|f| f.read }.split("\n")
.map{|s| s.split(" ")}
execute(statements)

#part 2
statements.each_with_index do |s, i|
  fixes = statements.map{|s| s.clone}
  fixes[i][0] = fixes[i][0] == "jmp" ? "nop" : "jmp" if ["jmp", "nop"].index(fixes[i][0])
  execute(fixes, true)
end





