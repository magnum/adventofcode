adapters = open('10.txt') {|f| f.read }.split("\n").map(&:to_i).sort

def calculate(index, chain, dp)
  return dp[index] if dp.key(index)
  result = 0
  index == chain.length - 1 ? result = 1 : ([1, 2, 3].each{|p| result += calculate(chain.index(chain[index] + p), chain, dp) if chain.index(chain[index] + p)})
  dp[index] = result
  return result
end


adapters += [0, adapters.max+3]
adapters.sort!
puts calculate(0, adapters, {})