require 'pry'

lines = open('4.txt') {|f| f.read }
.split("\n")

CHECK = "X"
board = []
@boards = []
drawings = []
lines.each_with_index do |line, i|
  drawings = line.split(",").map(&:to_i) if i == 0
  if i > 0
    lnumber =  (i-1) % 6
    board = [] if lnumber == 0
    board[lnumber-1] =  line.split(" ").map(&:strip).map(&:to_i) if lnumber > 0
    @boards << board if lnumber == 5
  end
end

def board_wins?(board)
  (board.find_all{|line| line.count(CHECK) == line.length}.length > 0) || 
  (board.transpose.find_all{|line| line.count(CHECK) == line.length}.length > 0)
end

def board_win!(d, i, b)
  @boards.delete(b)
  puts "with #{d}, board #{i} wins w/ result #{b.flatten.delete_if{|n| n==CHECK}.inject(0){|sum, n| sum+n}*d}" 
  puts b.map{|l| l.map{|n| n==CHECK ? "\e[31m#{n} \e[0m" : n.to_s.rjust(2," ")}.join(",")}.join("\n")
end

drawings.each do |d|
  @boards = @boards.map{|board| board.map{|line| line.map{|n| n==d ? CHECK : n}}} 
  @boards.each_with_index do |board, i| 
     board_win!(d, i, board) if board_wins?(board)
  end
end