def binaryToInt (binArray)
	length = binArray.length-1
	num = 0	

	for i in 0..length
		num += binArray[i]*(2**(length-i))
	end
	num
end

def getPowerConsumption (inputH, inputV)
	gammaBinary = []

	# for each element in the array, add the most frequent bit into gammaBinary
	inputV.each do |x|
		x.count(0) > x.count(1) ? gammaBinary << 0 : gammaBinary << 1
	end

	# epsilon is the binary mirror image of gamma
	# so we can generate it that way instead of computing it
	epsilonBinary = gammaBinary.map{|x| x == 0 ? 1 : 0}

	puts "Gamma Binary:"
	p gammaBinary
	p gammaBinary.class

	gamma   = binaryToInt(gammaBinary)
	epsilon = binaryToInt(epsilonBinary)

	puts "Gamma:"
	p gamma
	p gamma.class

	powerConsumption = gamma*epsilon
end

def getO2GeneratorRating (inputH, inputV)
	# making deep copy of inputH because it will be modified
	inputH2 = Marshal.load(Marshal.dump(inputH))
	inputV2 = Marshal.load(Marshal.dump(inputV))

	for i in 0..inputV.count-1
		inputV2 = inputH2.transpose

		# determine the most common value in the current bit position
		inputV2[i].count(0) > inputV2[i].count(1) ? target = 0 : target = 1

		# delete every element of inputH that does not have target in this position
		inputH2.delete_if {|x| x[i] != target}

		# exit the loop when only one element remains
		break if inputH2.count == 1
	end
	binaryToInt(inputH2[0])
end

def getCO2ScrubberRating (inputH, inputV)
	# making deep copy of inputH because it will be modified
	inputH2 = Marshal.load(Marshal.dump(inputH))
	inputV2 = Marshal.load(Marshal.dump(inputV))

	for i in 0..inputV.count-1
		inputV2 = inputH2.transpose

		# determine the most common value in the current bit position
		inputV2[i].count(1) < inputV2[i].count(0) ? target = 1 : target = 0

		# delete every element of inputH that does not have target in this position
		inputH2.delete_if {|x| x[i] != target}

		# exit the loop when only one element remains
		break if inputH2.count == 1
	end
	binaryToInt(inputH2[0])
end

def getLifeSupportRating (h, v)
	getO2GeneratorRating(h, v)*getCO2ScrubberRating(h, v)
end

# input is read as an array of strings
# each string contains a binary number
# we want to end up with a 2D array of integers
inputH = File.readlines('input.txt', chomp: true)

# converting each string to an array of integers
inputH = inputH.map{ |line| line.chars.map(&:to_i) }

# creating a rotated version of the input
# to group the same-position bits of each array 
# eg. bit 0 of each line is now in array element 0 etc.
inputV = inputH.transpose

o2Rating =  getO2GeneratorRating(inputH, inputV)
co2ScrubberRating = getCO2ScrubberRating(inputH, inputV)

puts "Life Support Rating: " + getLifeSupportRating(inputH, inputV).to_s