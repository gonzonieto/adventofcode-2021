instructions = File.readlines('input.txt', chomp: true)

instructions.map!{|x| x.split(' ')}

horizontal = 0
depth = 0
aim = 0

instructions.each do |step|
	num = step[1].to_i

	case step[0]
	when 'forward'
		horizontal += num * aim
		depth += num
	when 'down'
		aim += num
	when 'up'
		aim -= num
	end
end

puts "Final distance: " + horizontal.to_s
puts "Final depth: " + depth.to_s

puts "Multiplied: " + (depth*horizontal).to_s