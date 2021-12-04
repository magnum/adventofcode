require 'pry'

lines = open('4.test.txt') {|f| f.read }
.split("\n")

board = []
boards = []
drawings = []
lines.each_with_index do |line, i|
  if i == 0
    drawings = line.split(",").map(&:to_i)
  else 
    lnumber =  (i-1) % 6
    #puts "#{i} #{lnumber}"
    board = [] if lnumber == 0
    board[lnumber-1] =  line.split(" ").map(&:strip).map(&:to_i) if lnumber > 0
    boards << board if lnumber == 5
  end
end

def board_wins?(board)
  (board.find_all{|line| line.count("x") == line.length}.length > 0) #|| 
  (board.transpose.find_all{|line| line.count("x") == line.length}.length > 0)
end

def boards_print(b)
  b.map{|l| l.map{|n| n=="x" ? "\e[31m#{n}\e[0m" : n}.join(",")}.join("\n")
end

drawings.each do |d|
  puts "\nEXTRACTING #{d}"
  boards = boards.map{|board| board.map{|line| line.map{|n| n==d ? "x" : n}}} #.delete_if{|board| board.find_all{|line| line.length == 0}.length > 0}
  boards.each_with_index do |board, i|
    if board_wins?(board)
      puts "with #{d}, board #{i}, wins w/result #{board.flatten.delete_if{|n| n=="x"}.inject(0){|sum, n| sum+n}*d}" 
      break
    end
  end
  break if boards.length == 0
  puts boards.map.with_index{|b,i| "board #{i}\n#{boards_print(b)}\ntransposed\n#{boards_print(b.transpose)}\n"}.join("\n")
  #binding.pry
end


