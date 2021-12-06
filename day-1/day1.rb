def countIncreases (numArr)
	count = 0
	for i in 1..numArr.length-1
		if numArr[i] > numArr[i-1]
			count += 1
		end
	end
	count
end

def sumThrees (numArr)
	sums = []

	for i in 0..numArr.length-3
		sums << numArr[i] + numArr[i+1] + numArr[i+2]
	end

	sums 
end

measurements = File.readlines('input.txt', chomp: true).map!(&:to_i)

puts "Total number of readings: " + measurements.length.to_s
puts "Number of increases: " + countIncreases(measurements).to_s

summedMeasurements = sumThrees(measurements)

puts "Total number of summed readings: " + summedMeasurements.length.to_s
puts "Number of increaes in summed measurements: " + countIncreases(summedMeasurements).to_s