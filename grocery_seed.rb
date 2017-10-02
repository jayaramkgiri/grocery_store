REGISTERS = [ 
  {id: '1'},
  {id: '2'},
  {id: '3'}
]

PRODUCTS = [
  {name: 'Lays',            qty: 10,  price: 50, product_type: "Chips", coupon_code: nil },
  {name: 'Bingo',           qty: 15,  price: 50, product_type: "Chips", coupon_code: nil },
  {name: 'Moong Dal',       qty: 100, price: 50, product_type: "Dal",   coupon_code: nil },
  {name: 'Thoor Dal',       qty: 150, price: 50, product_type: "Dal",   coupon_code: nil },
  {name: 'Tata Salt',       qty: 20,  price: 50, product_type: "Salt",  coupon_code: nil },
  {name: 'Annapoorna Salt', qty: 25,  price: 50, product_type: "Salt",  coupon_code: nil }
]

USERS = [
  { name: 'Bob',   email: 'bob@yopmail.com',   phone: '12345', employee: 'true',  age: 25, coupon_code: nil },
  { name: 'Allen', email: 'allen@yopmail.com', phone: '23456',  employee: 'false', age: 30, coupon_code: nil },
  { name: 'Jill',  email: 'jill@yopmail.com',  phone: '34567',  employee: 'true',  age: 65, coupon_code: nil },
  { name: 'Jack',  email: 'jack@yopmail.com',  phone: '45678',  employee: 'false', age: 70, coupon_code: nil }
]

COUPONS = [
  { name: 'Special',            description: 'Special coupon',   discount_percent: '15', expiry: '' },
  { name: 'Employee',           description: 'Employee coupon',  discount_percent: '10', expiry: '' },
  { name: 'Senior',             description: 'Senior coupon',   discount_percent: '20', expiry: '' },
  { name: 'Chips discount',     description: 'Chips coupon',     discount_percent: '12', expiry: '' },
  { name: 'Tata Salt discount', description: 'Tata salt coupon', discount_percent: '5',  expiry: '' }
]