class DC::Item
    attr_accessor :externalCode, :name, :price, :quantity, :total, :subItems

    def initialize(externalCode, name, price, quantity, total, subItems)
        # Instance variables  
        
        @externalCode = externalCode
        @name = name
        @price = price
        @quantity = quantity
        @total = total
        @subItems = []

      end  

end
  