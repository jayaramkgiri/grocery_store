class User < Model

  COUPON_CONDITIONS = [:discount_for_employees, :discount_for_senior_citizens]
  attr_accessor :name, :email, :phone, :employee, :age, :coupon_code, :store

  class << self
    def attributes
      [:name, :email, :phone, :employee, :coupon_code, :age]
    end

    def id
      :phone
    end

    def discount_for_employees(store, coupon)
      store.users.each {|key, user| user.coupon_code = coupon if user.employee}
    end

    def discount_for_senior_citizens(store, coupon)
      store.users.each {|key, user| user.coupon_code = coupon if user.age > 60}
    end
  end 

  def initialize(details, store)
    @store = store
    details = get_details unless details
    @name = details[:name]
    @email = details[:email]
    @phone = details[:phone]
    @employee = details[:employee] == 'true'
    @age = details[:age].to_i
  end

  private
    def get_details
      details = {}
      puts "Name:"
      details[:name] = gets.chomp
      puts "Email:"
      details[:email] = gets.chomp
      puts "Phone:"
      details[:phone] = gets.chomp
      puts "Employee:"
      details[:employee] = gets.chomp
      puts "Age"
      details[:age] = gets.chomp
      details
    end
  alias_method :id, :phone
end