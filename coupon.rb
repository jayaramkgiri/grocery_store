class Coupon < Model
  attr_accessor :name, :description, :discount_percent, :expiry, :store

  COUPON_MODELS = ['users', 'product', 'product_type']

  def self.id
    :name
  end

  def self.attributes
    [:name, :description, :discount_percent, :expiry]
  end

  def initialize(details, store)
    @store = store
    details = get_details unless details
    @name = details[:name]
    @description = details[:description]
    @discount_percent = details[:discount_percent]
    @expiry = details[:expiry]
  end

  def apply_coupon
    model_name = get_model
    model = Object.const_get(model_name.split('_').map(&:capitalize).join.singularize)
    condition = get_conditions(model, model_name)
    model.send(*condition, store, self)
  end

  private
    def get_details
      details = {}
      puts "Name:"
      details[:name] = gets.chomp
      puts "Description:"
      details[:description] = gets.chomp
      puts "Discount Percent:"
      details[:discount_percent] = gets.chomp
      puts "Expiry:"
      details[:expiry] = gets.chomp
      details
    end

    def get_model
      while true do
        puts "Model"
        model = gets.chomp
        break if COUPON_MODELS.include?(model)
        puts "Coupon can't be applied"
      end
      model
    end

    def get_conditions(model, model_name)
      puts "Apply coupon for"
      puts model.const_get('COUPON_CONDITIONS').join(' ')
      condition = gets.chomp
      if ['product', 'product_type'].include?(model_name)
        puts "Name"
        name = gets.chomp
        return [condition, name]
      end
      [condition]
    end
  alias_method :id, :name    
end