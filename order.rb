require_relative 'list_item.rb'
class Order < Model
  @@id = 1
  attr_accessor :id, :list_items, :total, :register, :user, :store, :created_at

  class << self
    def attributes
      [:id, :list_items, :total, :register, :user, :created_at]
    end

    def sales_for(day, store)
      day = (day == 'today') ? Date.today : Date.parse(day)
      sales = 0
      store.orders.each {|key, order| sales += order.total if order.created_at.eql?(day)}
      sales
    end
  end

  def initialize(details, store)
    @id = @@id
    @@id = @@id + 1
    @store = store
    @list_items = []
    get_details
    adjust_inventory_and_set_list_items
    generate_bill
  end

  private

    def get_details
      fetch_checkout_register
      get_user_details
      while true do
        puts "Product name:"
        name = gets.chomp
        next unless check_product(name)
        puts "Qty:"
        qty = gets.chomp
        add_item(name, qty.to_i)
        puts "Type P to place order"
        break if gets.chomp == "P"
      end
    end

    def add_item(name, qty)
      @current_purchases ||= {}
      if @current_purchases[name]
        @current_purchases[name] += qty if check_store(name, @current_purchases[name] + qty)
      else
        @current_purchases[name] = qty if check_store(name, qty)
      end
    end

    def check_product(name)
      unless store.products[name]
        puts("Product not available")
        return false
      end
      return true
    end

    def check_store(name, qty)
      if store.products[name].qty > qty
        return true
      else
        puts "Out of stock"
      end
    end

    def fetch_checkout_register
      while true do
        puts "Register:"
        reg = Register.find(gets.chomp, store)
        if reg
          @register = reg
          break
        else
          puts "Invalid register"
        end
      end
    end

    def get_user_details
      puts "User phone:"
      phone = gets.chomp
      if User.find(phone, store)
        @user = User.find(phone, store)
      else
        @user = User.new(nil, store)
      end
    end

    def adjust_inventory_and_set_list_items
      @current_purchases.each do |name, qty|
        store.products[name].qty -= qty
        user_coupon = @user.coupon_code
        list_items << ListItem.create({order_id: @@id, product_name: name, qty: qty, coupon_code: user_coupon}, store)
      end
    end

    def generate_bill
      sum = 0
      list_items.each {|item| sum += item.subtotal}
      @total = sum
      puts "Bill amount is #{total}"
      @created_at = Date.today
    end
end 