<p align="center">
  <img width="500" height="200" src="https://media-exp1.licdn.com/dms/image/C4D1BAQHZ3m-yGm8cvA/company-background_10000/0?e=2159024400&v=beta&t=4R94SSaU7ug1AXLuYJzmSsqKUUdseWG-BlfpnZiwnKI">
</p>

<p align="center">
  <a href="https://codeclimate.com/github/tylertomlinson/monster_shop_2001/maintainability"><img src="https://api.codeclimate.com/v1/badges/8202f4f70c28f421c71d/maintainability" /></a>
</p>

"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will be able to get "shipped" by an admin. Each user role will have access to some or all CRUD functionality for application models.

## Installation

1. Install 
- Ruby 2.5.3
- Rails 5.1.7

2. Clone the repo
```
git clone git@github.com:tylertomlinson/monster_shop_2001.git
```
3. Open the CLI 
  - Run ```bundle install``` 
  - Run ```rails db:create && db:migrate && db:seed```
  
4. On the CLI open your local host 
  - ```rails s```
  
5. Open browser 
  - navigate to ```http://localhost:3000```


## Contributing
- Fork repo (https://github.com/tylertomlinson/monster_shop_2001)
- Create your feature branch (`git checkout -b feature/fooBar`)
- Commit your changes (`git commit -m 'Add some fooBar'`)
- Push to the branch (`git push origin feature/fooBar`)
- Create a new Pull Request


## Schema

 <p align="center">
 <img src="https://i.imgur.com/OTr7BnY.png">
</p>
 
 
### Default Accounts 

| Roles         | Email         | Password  |
| ------------- |:-------------:| -----:|
| Admin         | admin@example.com | password_admin  |
| Merchant Employee | merchant@example.com     | password_merchant |
| Standard User | user@example.com     | password_regular |



