def countIncreases (num_arr)
	num_arr.each_cons(2).count {|x| x[1] > x[0]} 
end

def sumThrees (num_arr)
  num_arr.each_cons(3).map(&:sum)
end

measurements = File.readlines('input.txt', chomp: true).map!(&:to_i)

puts "Total number of readings: " + measurements.length.to_s
puts "Number of increases: " + countIncreases(measurements).to_s

sums = sumThrees(measurements)

puts "Total number of summed readings: " + sums.length.to_s
puts "Number of increase in summed measurements: " + countIncreases(sums).to_s