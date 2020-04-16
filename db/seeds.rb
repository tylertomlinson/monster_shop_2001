

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

bike_pump = bike_shop.items.create(name: "Tire Pump", description: "A high-performance floor pump that makes no compromise in design, material, or function.", price: 50, image: "https://s7d5.scene7.com/is/image/Specialized/?layer=0&wid=1920&hei=640&fmt=jpg&src=is{Specialized/pdp-product-bg-light?wid=1920&hei=640}&layer=1&src=is{Specialized/472E-9080_PUMP_AIR-TOOL-PRO_POL_HERO?wid=920&hei=600&$hybris-pdp-hero$}", inventory: 10)

horn = bike_shop.items.create(name: "Bike Horn", description: " Enhance safety with this loud and beautiful bicycle bell", price: 100, image: "https://www.meijer.com/content/dam/meijer/product/0003/86/7558/65/0003867558650_0_A1C1_1200.png", inventory: 20)


#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

dog_bone = dog_shop.items.create(name: "Dog Bone", description: "Perfect for dogs that love to stretch and sprawl out in their sleep", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

dog_bed = dog_shop.items.create(name: "Dog Bed", description: "They'll love it!", price: 100, image: "https://assets.petco.com/petco/image/upload/f_auto,q_auto,t_ProductDetail-large/2533855-center-1", active?:false, inventory: 15)

user_1 = User.create!(name: "Regular User", address: "1234 Regular St", city: "Regular City", state: "Regular State", zip: "00000", email: "user123345@example.com", password: "password_regular1", role: 0)

user_2 = User.create!(name: "Regular User", address: "12345 Regular St", city: "Regular City", state: "Regular State", zip: "00000", email: "user2323432324@example.com", password: "password_regular2", role: 0)

order_1 = user_1.orders.create(name: 'Iron Man', address: '10880 Malibu Point', city: 'Malibu', state: 'CA', zip: 90265)

order_1.item_orders.create!(item: tire, price: tire.price, quantity: 5)
order_1.item_orders.create!(item: bike_pump, price: bike_pump.price, quantity: 1)
order_1.item_orders.create!(item: dog_bone, price: pull_toy.price, quantity: 5)

order_2 = user_2.orders.create(name: 'Iron Man', address: '10880 Malibu Point', city: 'Malibu', state: 'CA', zip: 90265)

order_2.item_orders.create!(item: dog_bed, price: dog_bed.price, quantity: 5)
order_2.item_orders.create!(item: bike_pump, price: bike_pump.price, quantity: 1)
order_2.item_orders.create!(item: horn, price: horn.price, quantity: 5)

#users
User.create(name: "Regular User", address: "1234 Regular St", city: "Regular City", state: "Regular State", zip: "00000", email: "user@example.com", password: "password_regular", role: 0)
User.create(name: "Merchant Employee", address: "1234 Merchant St", city: "Merchant City", state: "Merchant State", zip: "00001", email: "merchant@example.com", password: "password_merchant", merchant_id: bike_shop.id, role: 1)
User.create(name: "Admin User", address: "1234 Admin St", city: "Admin City", state: "Admin State", zip: "00002", email: "admin@example.com", password: "password_admin", role: 2)
