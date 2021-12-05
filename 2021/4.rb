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

def board_wins?(d,i,b)
  board_win!(d, i, b) if [b, b.transpose].map{|b| b.find_all{|line| line.count(CHECK) == line.length}.length}.index(1)
end

def board_win!(d, i, b)
  @boards.delete(b)
  result = b.flatten.delete_if{|n| n==CHECK}.inject(0){|sum, n| sum+n}*d
  puts "with #{d}, board #{i} wins w/ result #{result}" 
  puts b.map{|l| l.map{|n| n==CHECK ? "\e[31m#{n} \e[0m" : n.to_s.rjust(2," ")}.join(",")}.join("\n")
end

drawings.each do |d|
  @boards = @boards.map{|b| b.map{|line| line.map{|n| n==d ? CHECK : n}}} 
  @boards.each_with_index{|b, i| board_wins?(d, i, b)}
end