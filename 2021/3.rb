lines = open('3.txt') {|f| f.read }
.split("\n")

class Binary
  def self.to_decimal(binary)
    raise ArgumentError if binary.match?(/[^01]/)

    binary.reverse.chars.map.with_index do |digit, index|
      digit.to_i * 2**index
    end.sum
  end
end


def get_values(lines)
  values = []
  lines.each_with_index do |line, i|
    bits = line.split("")
    bits.each.with_index{|bit, i| values[i] = [] unless values[i]; values[i] << bit}
  end
  values
end

#part1
gamma_string = ""
epsilon_string = ""
get_values(lines).each do |value|
  zeroes = value.count("0")
  ones = value.count("1")
  gamma_string += zeroes > ones ? "0" : "1"
  epsilon_string += zeroes > ones ? "1" : "0"
  #puts "#{value.join(",")}, zeroes: #{zeroes}, ones: #{ones}"
end
gamma = Binary.to_decimal(gamma_string)
epsilon = Binary.to_decimal(epsilon_string)
puts "gamma: #{gamma_string}, decimal: #{gamma}"
puts "epsilon: #{epsilon_string}, decimal: #{epsilon}"
puts "part1 result: #{gamma*epsilon}"

#part2
def filter_lines(lines)
  filtered_lines = lines.clone
  bit_position = 0
  count = 0
  while filtered_lines.length > 1 &&  count < 1000
    values = get_values(filtered_lines)
    value = values[bit_position]
    bit_value = yield(value)
    filtered_lines = filtered_lines.delete_if{|l| l[bit_position] != bit_value}
    #puts "#{value.join ","}, bit_position: #{bit_position}, bit_value: #{bit_value}, filtered_lines: #{filtered_lines.join(", ")}"
    bit_position += 1
    count +=1
  end
  filtered_lines
end

ogr_string = filter_lines(lines){|value| value.count("1") >= value.count("0") ? "1" : "0"}.last
ogr = Binary.to_decimal(ogr_string)

csr_string = filter_lines(lines){|value| value.count("0") <= value.count("1") ? "0" : "1"}.last
csr = Binary.to_decimal(csr_string)
puts "gamma: #{ogr_string}, decimal: #{ogr}"
puts "epsilon: #{csr_string}, decimal: #{csr}"
puts "part2 result: #{ogr*csr}"