require 'pry'

lines = open('4.txt') {|f| f.read }
.split("\n")

class BoardLine
  attr_accessor :index
  attr_accessor :numbers
  attr_accessor :numbers_marked
  def initialize(index, numbers)
    @index = index
    @numbers = numbers
    @numbers_marked = []
  end
  def mark(number)
    @numbers_marked << number if @numbers.index(number)
  end
  def numbers_unmarked
    @numbers - @numbers_marked
  end
  def marked?
    @numbers.length == @numbers_marked.length 
  end
end

class Board
  attr_accessor :lines
  def initialize()
    @lines = []
  end
  def set_line(i, numbers)
    @lines[i] = BoardLine.new(i, numbers)
  end
  def numbers
    lines.map(&:numbers).flatten
  end
  def numbers_marked
    lines.map(&:numbers_marked).flatten
  end
  def numbers_unmarked
    lines.map(&:numbers_unmarked).flatten
  end
  def marked_lines
    @lines.find_all(&:marked?)
  end
  def mark(number)
    @lines.each{|l| l.mark number}
  end
  def marked_lines?
    marked_lines.length > 0
  end
  def marked?
    @lines.length == marked_lines.length
  end
end

boards = []
drawings = []
board = nil
lines.each_with_index do |line, i|
  if i == 0
    drawings = line.split(",").map(&:to_i)
  else 
    lnumber =  (i-1) % 6
    #puts "#{i} #{lnumber}"
    board = Board.new if lnumber == 0
    board.set_line (lnumber-1), line.split(" ").map(&:strip).map(&:to_i) if lnumber > 0
    boards << board if lnumber == 5
  end
end

drawings.each do |d|
  boards.each_with_index do |board, boards_index|
    if board.mark(d) && board.marked_lines.length > 0
      puts "with number #{d}, board #{boards_index} has #{board.marked_lines.length} marked line(s), result: #{board.numbers_unmarked.inject(0){|sum, n| sum+n}*d}"
      return 
    end
  end
end