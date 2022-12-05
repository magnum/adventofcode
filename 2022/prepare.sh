#!/bin/bash

if [ -z "$1" ]
  then
    echo "specify day, eg. 'prepare 1'"
    exit
fi

echo "
require 'pry'                        
                                             
lines = File.open('day$1.txt').read
.split('\n')   
#binding.pry
result1 = nil
result2 = nil
puts \"part1: #{result1}\" if result1   
puts \"part2: #{result2}\" if result2 
" > "day$1.rb"

touch "day$1.md"
touch "day$1.txt"
touch "day$1.test.txt"
