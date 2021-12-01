numbers = open('1.txt') {|f| f.read }
.split("\n")
.map(&:to_i)

#part 1
prev = nil
increases = 0
numbers.each_with_index do |n, i|
  increases +=1 if prev && n > prev
  prev = n
end
puts "count increases : #{increases}"

#part 2
windows_increases = 0
numbers.each_with_index do |n, i|
  window_prev = numbers[(i-3)..(i-1)]
  windows_current = numbers[(i-2)..i]
  puts "#{(i-2)} - #{i}"
  puts windows_current
  puts "---"
  windows_increases +=1 if window_prev.length == 3 && windows_current.inject(0){|sum,i| sum+=i} > window_prev.inject(0){|sum,i| sum+=i}
end
puts "count window_increases : #{windows_increases}"