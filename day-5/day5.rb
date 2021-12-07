# overriding Hash#to_s 
class Hash
	def to_s
		puts 
		self.each do |k, v|
			print '%5s' % k.to_s
		end
		puts

		self.each do |k, v|
			print '%5s' % v.to_s
		end
	end
end

class OceanFloor
	attr_accessor :grid

	def initialize (x, y)
		
		@grid = Array.new(x+1) { Array.new(y+1, 0) }
	end

	def to_s
		@grid.each do |x|
			x.each do |y|
				print y == 0 ? '.' : y
			end
			puts
		end
	end

	def mapVent (vent)
		# checks for and draws horizontal and vertical lines
		if vent[:x1] == vent[:x2] || vent[:y1] == vent[:y2]

			x1 = vent[:x1] < vent[:x2] ? vent[:x1] : vent[:x2]
			y1 = vent[:y1] < vent[:y2] ? vent[:y1] : vent[:y2]
			x2 = vent[:x1] < vent[:x2] ? vent[:x2] : vent[:x1]
			y2 = vent[:y1] < vent[:y2] ? vent[:y2] : vent[:y1]
		
			for x in x1..x2
				for y in y1..y2
					@grid[y][x] += 1
				end
			end
		# draws diagonal lines
		else
			x1 = vent[:x1]
			y1 = vent[:y1]
			x2 = vent[:x2]
			y2 = vent[:y2]

			xArr = []
			yArr = [] 

			if x1 > x2
				x1.downto(x2) {|x| xArr << x}
			elsif x2 > x1
				for x in x1..x2
					xArr << x
				end
			end

			if y1 > y2
				y1.downto(y2) {|y| yArr << y}
			elsif y2 > y1
				for y in y1..y2
					yArr << y
				end
			end

			xArr.each_index do |i|
				x = xArr[i]
				y = yArr[i]
				@grid[y][x] += 1
			end
		end
	end

	def countOverlap
		count = 0

		@grid.each do |x|
			x.each {|y| count += 1 if y >= 2}
		end
		return count
	end
end

# read lines from file with chomp
# split with " -> " to get each x,y coordinate into its own element in an array
# split again with "," to separate x and y into their own array element

vents = File.readlines('input.txt', chomp: true).map! {|line| line.split(' -> ')}

vents.each do |item|
	item.map! {|x| x.split(',')}.flatten!.map!(&:to_i)
end

# convert into an array of hashes with four keys: x1, x2, x3, x4
vents.map! {|item| Hash[x1: item[0], y1: item[1], x2: item[2], y2: item[3]]}

# delete any coordinate pairs where x1 != x2 && y1 != y2
#vents.delete_if {|item| item[:x1] != item[:x2] && item[:y1] != item[:y2] }

xMax = vents.flat_map {|item| [item[:x1], item[:x2]]}.max
yMax = vents.flat_map {|item| [item[:y1], item[:y2]]}.max

# make an array equal to the largest possible coordinate

oceanFloor = OceanFloor.new(xMax, yMax)

vents.each do |vent|
	oceanFloor.mapVent(vent)
end

puts "Points of overlap: " + oceanFloor.countOverlap.to_s