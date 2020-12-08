require 'open-uri'
require 'pry'


def execute(instructions)
  steps = []
  acc = 0
  i = 0
  while steps.length < 2000
    c,p = instructions[i]
    case c
      when "acc"
        acc += (p.to_i)
        i += 1
      when "jmp"
        n = (p.to_i)
        #n += 1 if p.index("+")
        i += n
      else
        i += 1
    end 
    break if steps.index(i)
    break if i == instructions.length
    steps << i
  end
  completed = (i == instructions.length)
  puts "acc #{acc}, steps: #{steps.length}, i: #{i}, completed? #{completed}" if completed
  i
end


# statements = open('8.test.txt') {|f| f.read }.split("\n").map{|s| s.split(" ")}
# execute(statements)
# exit #test


statements = open('8.txt') {|f| f.read }.split("\n").map{|s| s.split(" ")}
statements.each_with_index do |s, i|
  fixes = Marshal.load(Marshal.dump(statements))
  if ["jmp", "nop"].index(fixes[i][0])
    fixes[i][0] = fixes[i][0] == "jmp" ? "nop" : "jmp"
    #puts "line #{i} from #{statements[i]} to #{fixes[i]} "
    execute(fixes)
  end
  execute(fixes)
end





