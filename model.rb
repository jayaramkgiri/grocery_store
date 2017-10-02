require 'active_support/inflector'
class Model
  class << self 
    def create(details, store)
      new_model = Object.const_get(self.name).new(details, store)
      store.send(association)[new_model.id] = new_model
      new_model
    end

    def find(key, store)
      store.send(association)[key]
    end

    def association
      self.name.underscore.pluralize
    end

    def find_or_create(details, store)
      if self.find(details[send(:id)], store) 
        self.find(details[send(:id)], store) 
      else
        self.create(details, store)      
      end
    end

    def list(store)
      items = []
      store.send(association).each do |key, value|
        items << value.to_s
      end
      items
    end
  end

  def show
    Object.const_get(self.class.name).attributes.collect do |att| 
      value = send(att)
      value = value.kind_of?(Array) ? value.collect { |item| item.to_s}.join(" ") : value.to_s
      att.to_s.split('_').join.capitalize + ': ' + value
    end.join("\n")
  end

  alias_method :to_s, :show
end