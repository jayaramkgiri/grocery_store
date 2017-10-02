class Product < Model

  COUPON_CONDITIONS = [:discount_for_product]

  attr_accessor :name, :qty, :price, :store, :product_type, :coupon_code

  class << self
    def attributes
      [:name, :qty, :price, :product_type, :coupon_code]
    end

    def discount_for_product(name, store, coupon)
      store.products[name].coupon_code = coupon
    end
  end

  def initialize(details, store)
    @store = store
    details = get_details unless details
    @name = details[:name]
    @qty = details[:qty]
    @price = details[:price]
    @coupon_code = details[:coupon_code]
    @product_type = ProductType.find_or_create({name: details[:product_type]}, store)
  end

  private

    def get_details
      details = {}
      puts "Name:"
      details[:name] = gets.chomp
      puts "Qty:"
      details[:qty] = gets.chomp
      puts "Price:"
      details[:price] = gets.chomp
      puts "Product Type:"
      details[:product_type] = gets.chomp
      details
    end
  alias_method :id, :name
end