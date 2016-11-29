# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#

PRODUCTS = [
  ['Smart Hub', 49.99, '/smart_hub.jpg', 'Receive notifications on your phone based on the status of your connected devices - such as whether doors or windows are open 
    or closed or the lights are on or off, also can receive SOS notifications when your family is 
    in emergency'],

  ['Motion Sensor', 24.99, '/motion_sensor.jpg', 'It can use with lamps, incandescent lamps (bulbs), old-fashioned fluorescent lamps, 
    electronic fluorescent ring lamps, spotlights, transformers, small electrical appliances, and other all other appliance.'],

  ['Wireless Camera', 99.99, '/wireless_camera.jpg', '2 WAY AUDIO & SD CARD SLOT: Talk to other side of camera with the
    help of inbuilt microphone & speaker. Record Videos in SD card as it has provision for SD card slot also.
    It supports upto 128 GB capacity Card.'],

  ['Smoke Sensor', 19.99, '/smoke_sensor.jpg', 'NO ELECTRIC POWER SUPPLY REQUIRED, BATTERY OPERATED'],
  ['Water Leak Sensor', 14.99, '/water_leak.jpg', 'Protect your home against costly water damage by detecting water leaks instantly. Comes with English manual']]

PRODUCTS.each do |product|
  Product.find_or_create_by(name: product[0], price: product[1], image_url: product[2], description: product[3])
end

PROMOCODES = [["20%OFF", 'percentage', false, 20], ["5%OFF", 'percentage', true, 5], ['20POUNDSOFF', 'flat', true, 20]]

PROMOCODES.each do |promo|
  promocode = Promocode.find_or_create_by(name: promo[0], promo_type: promo[1], allowed_in_conjunction: promo[2])
  promo[1] == 'flat' ? promocode.flat_discount = promo[3] : promocode.percentage = promo[3]
  promocode.save
end
BUNDLEDISCOUNT = [[3, 'Motion Sensor', 65.00], [2, 'Smoke Sensor', 35.00]]

BUNDLEDISCOUNT.each do |disc|
  targeted_product_id = Product.where(name: disc[1]).first.id
  BundleDiscount.find_or_create_by(quantity_to_be_purchased: disc[0], targeted_product_id: targeted_product_id, price_after_discount: disc[2])
end
