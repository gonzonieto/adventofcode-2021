crabs = File.read('input.txt').split(',').map(&:to_i)

# Make a new array that covers the range of the crabs' positions
dist_ary = Array.new(crabs.max+1)

# For each distance, calculate the total fuel required to move all crabs there
dist_ary.each_with_index do |x, i|

	# Each distance is the difference between the crab's starting position
	# and the current position being evaluated
 	dist_ary[i] = crabs.map{|e| (e-i).abs}.sum
end

puts dist_ary.min