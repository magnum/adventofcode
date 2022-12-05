#!/bin/bash

if [ -z "$1" ]
  then
    echo "specify day, eg. 'prepare 1'"
    exit
fi

code_filename="day$1.rb"
template="
require 'pry'                        
                                             
lines = File.open('day$1.txt').read
.split('\n')   
#binding.pry
result1 = nil
result2 = nil
puts \"part1: #{result1}\" if result1   
puts \"part2: #{result2}\" if result2 
"
if [ ! -f $code_filename ]
then
  > "day$1.rb"
else
  echo "file $code_filename already exists, keeping it..."
fi  

#touch "day$1.md"
#https://github.com/GreenLightning/advent-of-code-downloader
aocdl -day $1 -output day$1.txt -force

touch "day$1.txt"
touch "day$1.test.txt"


