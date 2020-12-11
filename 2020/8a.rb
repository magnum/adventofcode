require 'open-uri'
require 'pry'

statements = open('8.txt') {|f| f.read }
.split("\n")
.map{|s| s.split(" ")}


def execute(statements)
  steps = []
  acc = 0
  i = 0
  while steps.length < 2000
    c,p = statements[i]
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
    break if i >= statements.length
    steps << i
  end
  puts "acc #{acc}, steps: #{steps.length}"
  i
end


puts execute(statements)



