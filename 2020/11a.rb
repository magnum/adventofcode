seats = open('11.txt') {|f| f.read }
.split("\n")
.map{|row| row.strip().split("")}

def step(seats)
  seats_next = seats
  seats.flatten.each_with_index do |seat, index|
    y = (index / seats.length).floor
    x = index - seats.length * y
    
    ys = [y-1, y+1].map{|i| i.clamp(0,seats[0].length-1)}
    xs = [x-1, x+1].map{|i| i.clamp(0,seats.length-1)}
    around_indexes = (ys[0]..ys[1])
    .inject([]){|list, y| list += (xs[0]..xs[1]).to_a.map{|x| y*seats[0].length+x } }
    .flatten.delete_if{|i| i==index}
    around_seats = seats.flatten.values_at(*around_indexes)
    if seat == "L" && around_seats.select{|s| s=="#"}.count == 0
      seats_next[y][x] = "#" 
    elsif seat == "#" && around_seats.select{|s| s=="#"}.count >= 4
      seats_next[y][x] = "L" 
    end
  end
  seats_next
end


1000.times.each do |i|
  previous_state = seats.flatten.join("")
  seats = step(seats)
  # puts "step #{i}"
  # pp seats
  current_state = seats.flatten.join("")
  seats_occupied_count = seats.flatten.count{|s| s=="#"}
  break if previous_state == current_state
  puts "after #{i+1} step(s), there are #{seats_occupied_count} seat(s) occupied"
end

