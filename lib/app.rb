require 'json'
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
products_hash = JSON.parse(file)

puts " "
puts " "
# Print today's date
today = Time.now
puts today.strftime('%B %d, %Y')

puts "                     _            _       "
puts "                    | |          | |      "
puts " _ __  _ __ ___   __| |_   _  ___| |_ ___ "
puts "| '_ \\| '__/ _ \\ / _` | | | |/ __| __/ __|"
puts "| |_) | | | (_) | (_| | |_| | (__| |_\\__ \\"
puts "| .__/|_|  \\___/ \\__,_|\\__,_|\\___|\\__|___/"
puts "| |                                       "
puts "|_|                                       "

puts " "
# For each product in the data set:
  # Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price

	# big outer loop goes through each item
	products_hash["items"].each do |toy|
		toy_title = toy["title"]
		puts toy_title
		puts "-------------------"
		retail_price = toy["full-price"]
		puts "Retail Price: $#{retail_price}"
		total_purchases = toy["purchases"].length
		puts "Total Purchases: #{total_purchases}"
		sales_total = 0.0
		toy["purchases"].each do |purchases|
			sales_total += purchases["price"]
		end
		puts "Total Sales: $#{sales_total}"
		avg_sale_price = sales_total / total_purchases
		# have to convert retail price to float (string in dataset [why??])
		puts "Average Price: $#{avg_sale_price}"
		avg_discount = retail_price.to_f - avg_sale_price
		# %02.2f formats float to look like USD
		puts "Average Discount: $#{format('%02.2f', avg_discount)}"
		puts " "
	end




	puts " _                         _     "
	puts "| |                       | |    "
	puts "| |__  _ __ __ _ _ __   __| |___ "
	puts "| '_ \\| '__/ _` | '_ \\ / _` / __|"
	puts "| |_) | | | (_| | | | | (_| \\__ \\"
	puts "|_.__/|_|  \\__,_|_| |_|\\__,_|___/"
	puts

# For each brand in the data set:


		unique_brands = products_hash["items"].map { |item| item["brand"]}.uniq

		unique_brands.each do |brand|
			  # Print the name of the brand
			puts "#{brand}"
			puts 	"-------------------"
			# Count and print the number of the brand's toys we stock
			brand_details = products_hash["items"].select {|item| item["brand"] == brand }
			total_stock = 0
			brand_details.each {|toy| total_stock += toy["stock"].to_i}
			puts "Number of #{brand} products in stock: #{total_stock}"
			# Calculate and print the average price of the brand's toys
			total_brand_price = 0.0
			brand_details.each {|toy| total_brand_price += toy["full-price"].to_f}
			average_brand_price = total_brand_price / brand_details.length
			puts "Average price of #{brand} products: $#{format('%02.2f', average_brand_price)}"
			# Calculate and print the total revenue of all the brand's toy sales combined
			purchase_count = 0
			purchase_price = 0
			brand_details.each {|toy| purchase_count = toy["purchases"]}
			purchase_count.each {|brand| purchase_price += brand["price"].to_f}
			puts "Total revenue for #{brand}: $#{format('%02.2f', purchase_price)}"

			puts " "
	end
