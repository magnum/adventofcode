require 'pry'

rules, lists = File.open("day5.txt").read
.split("\n\n")
.map{|part| part.split("\n")}
rules = rules.map{|l| l.split("|")}
lists = lists.map{|l| l.split(",")}

valids = lists.filter do |list|
  is_valid = true
  rules.each do |rule|
    is_valid = false if (list.index(rule[0]) > list.index(rule[1])) rescue true
  end
  is_valid
end

def sumLists(list)
  list.map{|list| list[list.length/2]}.map(&:to_i).sum
end

puts sumLists(valids)

#part 2
invalids = lists - valids

def sorter(list, rules)
  prevs, nexts = {}, {}
  rules.each do |rule|
    n, p = rule
    prevs[n] = Set.new if !prevs[n]
    prevs[n].add(p)
    nexts[p] = Set.new if !nexts[p]
    nexts[p].add(n)
  end
  list.sort do |b, a|
    next 0 if !nexts[a] && !nexts[b]
    (nexts[a]&.include?(b)) || (prevs[b]&.include?(a)) ? -1 : 1
  end
end

puts sumLists(invalids.map{|list| sorter(list, rules)})