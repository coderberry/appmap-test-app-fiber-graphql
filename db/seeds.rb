# cards_file = "db/oracle-cards-20231213100137.json"
# if File.exist?(cards_file)
#   data = JSON.parse(File.read(cards_file))
#   puts "Removing old cards..."
#   Card.destroy_all
#   sets_to_save = [
#     "zen",
#     "lrw",
#     "shm",
#     "m10",
#   ]
#   puts "Creating new cards..."
#   data.each do |card_json|
#     if sets_to_save.include?(card_json["set"])
#       puts "Creating #{card_json["name"].inspect}"
#       Card.create!(
#         name: card_json["name"],
#         set: card_json["set"],
#         cmc: card_json["cmc"],
#         mana_cost: card_json["mana_cost"],
#       )
#     end
#   end
# end

puts "Creating new cards..."
1000.times do |i|
  puts "Creating Card #{i+1}"
  Card.create!(
    name: "name-#{i+1}",
    set: "set-#{i+1}",
    cmc: rand(0.0..10.0),
    mana_cost: "mana-#{i+1}"
  )
end
puts "DONE!"