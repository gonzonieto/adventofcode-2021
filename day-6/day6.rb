def cycle_days(fish, days)
	day_count = 0
	fish_array = [0] * 9

	fish.each do |f|
		fish_array[f] += 1
	end

	# Each execution of this loop represents one day
	loop do
		new_fish_array = [0] * 9

		fish_array[7] += fish_array[0]

		new_fish_array = new_fish_array.map.with_index {|x,i| fish_array[(i+1) % 9]}

		fish_array = new_fish_array

		day_count += 1
		days -= 1

		if days == 0
			puts "There are " + fish_array.sum.to_s + " fish after " + day_count.to_s + " days."
			puts "Ah, the beauty of nature!"
			break
		end
	end
end

fish = File.read('input.txt').split(',').map!(&:to_i)

cycle_days(fish, 256)