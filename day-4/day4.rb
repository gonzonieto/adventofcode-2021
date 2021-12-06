class Board
	attr_accessor :nums, :won

	def initialize (nums)
		@won = false
		@nums = Array.new(5) { Array.new(5)}
		nums.each_index {|i| @nums[i] = nums[i].map {|num| Hash[num: num, marked: false]}}
	end

	def markNum (draw)
		@nums.each do |line|
			line.each {|num| num[:marked] = true if num[:num] == draw }
		end
	end

	def win?
		win = false

		if @won
			return false
		end

		@nums.each do |line|
			win = true if line.all? {|num| num[:marked]}
		end

		@nums.transpose.each do |line|
			win = true if line.all? {|num| num[:marked]}
		end

		diag1 = []
		diag2 = []
		for i in 0..4
			diag1 << @nums[i][i]
			diag2 << @nums[i][4-i]
		end

		if diag1.all? {|num| num[:marked]} || diag2.all? {|num| num[:marked]}
			win = true
		end

		if win
			@won = true
		end

		win
	end

	def sumUnmarked
		sum = 0
		@nums.each do |line|
			line.each do |num|
				if num[:marked] == false
					sum += num[:num]
				end
			end
		end

		return sum
	end
end

def drawNum (boardArr, draw)
	boardArr.each do |board|
		board.markNum(draw)
	end
end

# read input file, delete newline characters, and 
# delete the empty lines that separate each bingo board
# this gives an array of strings, each with 5 ints separated by spaces
# five elements of this array == one bingo board
input = File.readlines('boards.txt', chomp: true).delete_if {|x| x == ""}

# separate the numbers and convert each from string to int
input.map! {|line| line.split(" ").map!(&:to_i)}

# read file containing sequence of draws
# separate the draws and convert all to int
draws = File.read('numbers.txt').split(',').map!(&:to_i)

# boards will be stored in an array of input.count/5 elements
boardArray = Array.new(input.count/5)

# build boardArray by sending 5 lines of input at a time
(0...input.count).step(5) do |n|
	boardArray[n/5] = Board.new(input[n..n+4])
end

winner = 0
finalDraw = 0

draws.each do |draw|
	drawNum(boardArray, draw)

	boardArray.each do |board|
		if board.win?
			winner = board
			finalDraw = draw
		end
	end

	break if boardArray.all? {|board| board.won == true}
end

puts "Final board to win is board no. " + boardArray.index(winner).to_s
puts "Sum of unmarked number: " + winner.sumUnmarked.to_s
puts "Final draw: " + finalDraw.to_s
puts
puts "Final answer: " + (winner.sumUnmarked*finalDraw).to_s

