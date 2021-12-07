input = File.readlines('input.txt', chomp: true)

# splitting input into word and number in separate elements
input.map!{|line| line.split(' ')}

# converting each number to an integer and keeping strings intact
# .to_i on a string returns 0 and we know there are no 0 numbers in the input
input.each do |line|
	line.map!{|ele| ele.to_i == 0 ? ele : ele.to_i }
end

# making an array of hashes
steps = []
input.each do |line|
	steps << Hash[command: line[0],
								  value: line[1]]
end

x = 0
y = 0
aim = 0

steps.each do |step|
	num     = step[:value]
	command = step[:command]

	case command
	when 'forward'
		x += num * aim
		y += num
	when 'down'
		aim += num
	when 'up'
		aim -= num
	end
end

puts "Final distance: " + x.to_s
puts "Final depth: " + y.to_s

puts "Multiplied: " + (y*x).to_s