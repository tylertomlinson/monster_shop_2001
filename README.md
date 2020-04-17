<p align="center">
  <img width="500" height="200" src="https://media-exp1.licdn.com/dms/image/C4D1BAQHZ3m-yGm8cvA/company-background_10000/0?e=2159024400&v=beta&t=4R94SSaU7ug1AXLuYJzmSsqKUUdseWG-BlfpnZiwnKI">
</p>

<p align="center">
  <a href="https://codeclimate.com/github/tylertomlinson/monster_shop_2001/maintainability"><img src="https://api.codeclimate.com/v1/badges/8202f4f70c28f421c71d/maintainability" /></a>
</p>

# Table of Contents
<details>
<summary>Click to expand</summary>
  
- [About](#about)
- [Getting Started](#getting-started)
- [How it works](#how-it-works)
	* [Schema](#schema)
  * [Default Users](#default-users)
  * [Creating Account](#creating-account)
  * [Items](#items)
  * [Checkout](#checkout)
  * [Orders](#orders)
- [Authors](#authors)
- [Contributing](#contributing)
</details>


# About
"Monster Shop" is a fictitious e-commerce platform where users can register to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will be able to get "shipped" by an admin. Each user role will have access to some or all CRUD functionality for application models.

# Getting Started
## Prerequisites
```javascript
brew install ruby -2.5.3
gem install rails -5.1.7
```
## Installing
#### Clone repository:
```javascript
git clone git@github.com:tylertomlinson/monster_shop_2001.git
```
#### Navigate into directory:
```javascript
cd monster_shop_2001
```
#### Install gems:
```javascript
bundle install
```
#### Configure databases:
```javascript
rake db:{create,migrate,seed}
```
#### Fire up local server: (http://localhost:3000)
```javascript
rails s
```
#### Run test suite:
```javascript
rspec
```

# How it works
### Schema
 <p align="center">
 <img src="https://i.imgur.com/OTr7BnY.png">
</p>

---
## Default users
|       Roles       |        Email         |     Password      |
| :---------------: | :------------------: | :---------------: |
|       Admin       |  admin@example.com   |  password_admin   |
| Merchant Employee | merchant@example.com | password_merchant |
|   Standard User   |   user@example.com   | password_regular  |

---
## Creating account
 <p align="center">
 <img src="https://media.giphy.com/media/XdP30SZ43DHTd2nA7K/giphy.gif">
</p>

---
## Merchants
<p align="center">
 <img src="https://imgur.com/nDt3Jzk.png">
</p>

---
## Items
<p align="center">
 <img src="https://i.imgur.com/s17SFKX.png">
</p>

---
## Cart
<p align="center">
 <img src="https://imgur.com/csO2TwW.png">
</p>

---
## Checkout 
<p align="center">
 <img src="https://imgur.com/C1Sxkb8.png">
</p>

---
## Orders 
<p align="center">
 <img src="https://imgur.com/sonvTDW.png">
</p>

# Authors 
<p>
  <a href="https://github.com/tylertomlinson">Tyler Tomlinson</a>
 </p>
 <p>
  <a href="https://github.com/alex-latham">Alex Latham</a>
 </p>
 <p>
  <a href="https://github.com/Mariana-21">Mariana Cid</a>
 </p>
 <p>
  <a href="https://github.com/danielpselph">Daniel Selph</a>
 </p>


 # Contributing
- Fork repo (https://github.com/tylertomlinson/monster_shop_2001)
- Create your feature branch (`git checkout -b feature/fooBar`)
- Commit your changes (`git commit -m 'Add some fooBar'`)
- Push to the branch (`git push origin feature/fooBar`)
- Create a new Pull Request

