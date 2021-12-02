lines = open('1.txt') {|f| f.read }
.split("\n")
.map(&:to_i)

#part 1
prev = nil
count = 0
lines.each_with_index do |n, i|
  count +=1 if prev && n > prev
  #puts "#{n} > #{prev} ? #{n > prev rescue false}, count: #{count}"
  prev = n
end
puts "increases: #{count}"

#part 2
increases = 0
lines.each_with_index do |n, i|
  window_prev = lines[(i-3)..(i-1)]
  windows_current = lines[(i-2)..i]
  increases +=1 if window_prev.length == 3 && windows_current.inject(0){|sum,i| sum+=i} > window_prev.inject(0){|sum,i| sum+=i}
end
puts "grouped increases: #{increases}"