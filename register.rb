class Register < Model
  attr_accessor :id, :orders, :store

  def self.attributes
    [:id]
  end

  def initialize(details, store)
    @id = details[:id]
    @store = store
    @orders = []
  end
end