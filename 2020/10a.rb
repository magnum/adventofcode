adapters = open('10.txt') {|f| f.read }.split("\n").map(&:to_i)

#part 1
chain = [0]
v = 0
while adapters.length > 0 do 
  compatibles = adapters.select{|a| a >= v+1 && a <= v+3}
  choosen = compatibles.min
  chain << adapters.delete(compatibles.min)
  v = choosen
  puts "for #{v}v, compatible(s) #{compatibles.join(", ")}"
end
chain << chain.last+3 #device adapter
pp chain

diffs = (1..3).map{|i| [i, []]}.to_h
(0..chain.length-2).each do |i|
  a1 = chain[i]
  a2 = chain[i+1]
  diff = (a2-a1).abs
  diffs[diff] << [a1, a2]
end
diffs.keys.each{|k| puts "#{diffs[k].length} with diff of #{k}"}
puts "number of 1-jolt differences multiplied by the number of 3-jolt differences: #{diffs[1].length * diffs[3].length}"