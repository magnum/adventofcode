lines = open('4.txt') {|f| f.read }.split("\n")

CHECK = "X"
lines.each_with_index do |line, i|
  @drawings = line.split(",").map(&:to_i) if i == 0
  if i > 0
    lnumber =  (i-1) % 6
    @board = [] if lnumber == 0
    @board[lnumber-1] = line.split(" ").map(&:strip).map(&:to_i) if lnumber > 0
    (@boards ||= []) << @board if lnumber == 5
  end
end

def board_wins?(d,i,b)
  if  [b, b.transpose] # consider rows and columns
      .map{|b| b.find_all{|line| line.count(CHECK) == line.length}.length}
      .index(1)
    @boards.delete(b) ; puts "with #{d}, board #{i}, #{(b.flatten-[CHECK]).inject(0){|sum, n| sum+n}*d}" 
  end
end

@drawings.each do |d|
  @boards = @boards.map{|b| b.map{|line| line.map{|n| n==d ? CHECK : n}}} # checking boards
  @boards.each_with_index{|b, i| board_wins?(d, i, b)}
end