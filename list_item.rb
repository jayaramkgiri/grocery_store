class ListItem < Model
  @@id=1
  attr_accessor :id, :order_id, :product_name, :qty, :subtotal, :discount_percent, :store

  def self.attributes
    [:product_name, :qty, :subtotal, :discount_percent]
  end

  def initialize(details, store)
    @id = @@id
    @@id += 1
    @store = store
    @order_id = details[:order_id]
    @product_name = details[:product_name]
    @qty = details[:qty]
    calculate_subtotal(details[:coupon_code])
  end

  def calculate_subtotal(user_coupon)
    product = store.products[product_name]
    discount = max_discount(user_coupon, product)
    @discount_percent = discount
    purchase = store.products[product_name].price * qty
    @subtotal = purchase - (purchase * (@discount_percent/100))
  end

  def max_discount(user_coupon, product)
    user_discount = user_coupon ? user_coupon.discount_percent.to_f : 0
    product_discount = product.coupon_code ? product.coupon_code.discount_percent.to_f : 0
    product_type_discount = product.product_type.coupon_code ? product.product_type.coupon_code.discount_percent.to_f : 0
    [user_discount, product_discount, product_type_discount].max
  end
end