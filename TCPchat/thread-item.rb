class Item
	class << self; attr_accessor :price end
	@price = 0
end

# => SINGLE THREAD
#(1..10).each { Item.price += 10 }

mutex = Mutex.new

# => MULTI THREAD
threads = (1..10).map do |i|
	Thread.new(i) do |i|
		mutex.synchronize do 		#MUTUAL EXCLUSION
			item_price = Item.price #read value
			sleep(rand(0..2))
			item_price += 10				#update value
			sleep(rand(0..2))
			Item.price = item_price #write value
		end
	end
end

threads.each { |t| t.join }
puts "Item.price = #{Item.price}"