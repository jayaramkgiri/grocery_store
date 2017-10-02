require_relative 'grocery_seed.rb'
require_relative 'model.rb'
require_relative 'register.rb'
require_relative 'product.rb'
require_relative 'product_type.rb'
require_relative 'user.rb'
require_relative 'order.rb'
require_relative 'list_item.rb'
require_relative 'coupon.rb'

require 'date'

class GroceryStore
  COMMANDS = [:add_register, :list_registers, :add_product, :show_inventory, :add_product_type, :list_product_types,
              :add_user, :list_users, :place_order, :list_orders, :add_coupon, :list_coupons, :apply_coupon,
              :total_sales_for_the_day,:help]
  attr_accessor :name, :products, :orders, :coupons, :registers, :product_types, :users, :list_items, :coupons

  def initialize(name)
    @name = name
    @users = {}
    @products = {}
    @product_types = {}
    @orders = {}
    @coupons = {}
    @registers = {}
    @list_items = {}
  end

  def add_register(details=nil)
    Register.create(details,self)
  end

  def list_registers
    puts Register.list(self).join("\n ************************ \n")
  end

  def add_product(details=nil)
    Product.create(details, self)
  end

  def show_inventory
    puts Product.list(self).join("\n ************************ \n")
  end

  def add_product_type(details=nil)
    ProductType.create(details, self)
  end

  def list_product_types
    puts ProductType.list(self).join("\n ************************ \n")
  end

  def add_user(details=nil)
    User.create(details, self)
  end

  def list_users
    puts User.list(self).join("\n ************************ \n")
  end

  def place_order
    Order.create(nil, self)
  end

  def list_orders
    puts Order.list(self).join("\n ************************ \n")
  end

  def total_sales_for_the_day(day = 'today')
    puts Order.sales_for(day, self)
  end


  def add_coupon(details=nil)
    Coupon.create(details, self)
  end

  def list_coupons
    puts Coupon.list(self).join("\n ************************ \n")
  end

  def apply_coupon(coupon_code)
    if coupons[coupon_code]
      coupons[coupon_code].apply_coupon
    else
      puts "Invalid coupon"
    end
  end

  def help
    puts COMMANDS.join("\n")
  end
end


store = GroceryStore.new('Mystore')
PRODUCTS.each { |product| store.add_product(product) }
USERS.each { |user| store.add_user(user) }
REGISTERS.each {|register| store.add_register(register)}
COUPONS.each {|coupon| store.add_coupon(coupon)}


while true do
  begin
    puts 'Enter operation'
    command = gets.chomp
    break if command.eql?('end')
    command = command.split(' ')
    unless GroceryStore::COMMANDS.include?(command[0].to_sym)
      puts "Invalid command"
      next
    end
    store.send(*command)
  rescue => e
    p e
    puts "Invalid command"
  end
end
