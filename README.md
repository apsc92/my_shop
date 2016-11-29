# MyShop

<a href="https://codeclimate.com/github/apsc92/my_shop"><img src="https://codeclimate.com/github/apsc92/my_shop/badges/gpa.svg" /></a>
<a href="https://codeclimate.com/github/apsc92/my_shop/coverage"><img src="https://codeclimate.com/github/apsc92/my_shop/badges/coverage.svg" /></a>

The [MyShop app](https://github.com/apsc92/my_shop) is a sample e-commerce consisting a basic flow from selecting a item till checkout.

## Stack:

* Rails 5.0
* Ruby 2.3.0
* PostgreSQL

## Preview:
  https://myshopdemo.herokuapp.com/

## Getting Started
* `RAILS_ENV=development bundle install`
* `RAILS_ENV=development rake db:migrate`
* `RAILS_ENV=development rake db:seed`

* Ensure to set a env variable `ENV['USERKEY']` as this is used for encrypting sensitive data before saving to database.


## Assumptions:
* All products are enough in stock(always available)
* No initial login is required(ask customer email while proceeding for checkout)
* Saving credit card details(after encrypting) as payment gateway is not available
* Delivery address is same as billing address

## Approach:
### Designing Schema
* Product(Items available for sale)
* Customer
* Order
* OrderItem
* CreditCard
* Address
* BundleDiscount
* Promocode

### Appying BundleDiscount(discount when item is purchased in bundle)

* While calculating cost of OrderItem, BundleDiscount is considered.
For e.g. Item1 has cost of 2 pound per piece and we can offer him 5 items for 8 pound and if user purchased 6 item then calculation goes like this.

* First of all I calculate bundles possible i.e `quantity(6) / quantity_to_be purchased(5) = 1`
Then I find remaining items `quantity(6) % quantity_to_be purchased(5) = 1`
Total cost = `bundles(1) * 8 + 1 * price_of_item(2) = 10 pound`


### Applying Promocode(discount on whole order based on code applied)

* Check if promocode is valid.
* Then ensure that promocode can be applied in conjunction with other applied promocodes(if any).If promocode type is `flat` then make sure that after appying this code total cost should be greater then zero.

* If all these conditions are true then apply code based on its type i.e `flat` or `percentage`

