require_relative 'model.rb'
class ProductType < Model

  COUPON_CONDITIONS = [:discount_for_product_type]

  attr_accessor :name, :store, :coupon_code

  class << self
    def id
      :name
    end

    def attributes
      [:name, :coupon_code]
    end 

    def discount_for_product_type(name, store, coupon)
      store.product_types[name].coupon_code = coupon
    end   
  end

  def initialize(details, store)
    @store = store
    details = get_details unless details
    @name = details[:name]
    @coupon_code = details[:coupon_code]
  end

  private
    def get_details
      details = {}
      puts "Name:"
      details[:name] = gets.chomp
      details
    end
  alias_method :id, :name
end