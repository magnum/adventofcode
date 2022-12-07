
require "pry"        

class Efile
  attr :edir
  attr :name
  attr :size
  def initialize(edir, name, size)
    @edir = edir
    @name = name
    @size = size
  end
end

class Edir
  attr :parent
  attr :children
  attr :name
  attr :efiles
  def initialize(name, parent=nil)
    @name = name
    @efiles = []
    @children = []
    @parent = parent
    @parent.addChildren(self) if parent
  end
  def addEfile(efile)
    @efiles << efile
  end
  def addChildren(edir)
    @children << edir
  end
  def size
    edirs_size = @children.inject(0){|sum, edir| sum+=edir.size}
    efiles_size = @efiles.inject(0){|sum, efile| sum+=efile.size}
    edirs_size+efiles_size
  end
end

edirs = []

current_edir = nil
#paths = ["day7"]                                        
lines = File.open("day7.txt").read
.split("\n")
.each_with_index do |line, line_index|
  params = line.split(" ")
  if line.chars[0] == "$"
    prompt, command, param1 = line.split(" ")
    case command
      when "ls"
      when "cd"
        if param1 == ".."
          current_edir = current_edir.parent
        else 
          current_edir = (current_edir&.children.find{|d| d.name == param1} rescue nil)
          unless current_edir
            edir = Edir.new(param1, current_edir)
            current_edir = edir
            edirs << edir
          end
          #puts "changing dir to #{current_edir.name}"
        end
    end
  elsif line.index("dir")
    edir = Edir.new(line.split(" ")[1], current_edir)
    edirs << edir
    #puts "dir #{current_edir&.name} adding subdir #{edir.name}"
  else
    efile_size, efile_name = line.split(" ")
    efile = Efile.new(current_edir,efile_name, efile_size.to_i)
    current_edir.addEfile(efile)
    #puts "dir #{current_edir.name} adding file #{efile_name} size #{efile_size}"
  end
end

# du = `du -k day7`
# du.split("\n").each do |u|
#   size, path = u.split(" ").map(&:strip)
#   puts size
# end

result1 = edirs.find_all{|edir| edir.size <= 100000}.inject(0){|sum, edir| sum+=edir.size}
space_available = 70000000 - edirs.sort_by(&:size).last.size
space_needed = 30000000 - space_available
edir_to_delete = edirs.find_all{|edir| edir.size >= space_needed}.sort_by(&:size).first
result2 = edir_to_delete.size
binding.pry
puts "part1: #{result1}" if result1   
puts "part2: #{result2}" if result2 

