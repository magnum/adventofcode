require 'httparty'
require 'pry'

#lines = HTTParty.get 'https://adventofcode.com/2022/day/1/input'
lines = File.open("day.txt").read.split("\n\n").map{|l| l.split("\n")}
sums = lines.map{|a| a.inject(0){|sum,b| sum+=b.to_i}}.sort
puts "part1: #{sums.last}"
puts "part2: #{sums.reverse.take(3).inject{|sum,i| sum+=i}}"
