require 'pry'

lines = open('6.txt') {|f| f.read }.split("\n")

[80, 256].each do |days|
    ages = Array.new(9,0)
    lines[0].split(",").map(&:to_i).each {|i| ages[i] += 1 }
    days.times do
        ages[7] += ages[0]
        ages = ages.rotate(1)
        #puts ages.join(",")
    end
    puts ages.sum
end

