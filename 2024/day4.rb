DIRECTIONS = [
  [0, 1],   # Right
  [0, -1],  # Left
  [1, 0],   # Down
  [-1, 0],  # Up
  [1, 1],   # Down-Right
  [1, -1],  # Down-Left
  [-1, 1],  # Up-Right
  [-1, -1]  # Up-Left
]

def find_word(grid, row, col, direction)
  word = "XMAS"
  word.length.times do |i|
    r = row + direction[0] * i
    c = col + direction[1] * i
    return false if r < 0 || c < 0 || r >= grid.size || c >= grid[0].size
    return false if grid[r][c] != word[i]
  end
  true
end


def count_xmas_occurrences(grid)
  count = 0
  grid.each_with_index do |row, r|
    row.each_with_index do |_, c|
      DIRECTIONS.each do |direction|
        count += 1 if find_word(grid, r, c, direction)
      end
    end
  end
  count
end

grid = File.open("day4.txt").read.split("\n")

# Convert grid to array of character arrays
grid = grid.map(&:chars)

# Count and print the number of occurrences of "XMAS"
puts count_xmas_occurrences(grid)


