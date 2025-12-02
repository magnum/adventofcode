#!/bin/bash

if [ -z "$1" ]
  then
    echo "specify day, eg. 'prepare 1'"
    exit
fi

code_filename="day$1.rb"


if [ ! -f $code_filename ]
then
  echo "
require \"pry\"                 

@debug = ARGV.index(\"--debug\") || false
day = __FILE__.split(\"/\").last.split(\".\").first.gsub(\"day\",\"\").to_i
filename = \"day#{day}.txt\"
filename = \"day#{day}.test.txt\" if ARGV.index(\"--test\")
puts \"filename: #{filename} debug: #{@debug}\" 

def pause
  STDIN.gets.chomp if @debug
end
                    
lines = File.open(filename).read
.split(\"\n\")   
#binding.pry
result1 = nil
result2 = nil
puts \"part1: #{result1}\" if result1   
puts \"part2: #{result2}\" if result2 
" > "day$1.rb"

else
  echo "file $code_filename already exists, keeping it..."
fi  

#https://github.com/scarvalhojr/aoc-cli
aoc download -d $1 -i "day$1.txt" -p "day$1.md" 

touch "day$1.txt"
touch "day$1.test.txt"


