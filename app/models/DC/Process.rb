class DC::Process
  
    attr_accessor :externalCode, :storeId, :subTotal, :deliveryFee, :total, :country, :state, :city, :district, :street, :complement, :latitude, :longitude, :dtOrderCreate, :postalCode, :number, :total_shipping, :customer, :items, :payments

    def initialize(externalCode, storeId, subTotal, deliveryFee, total, country, state, city, district, street, complement, latitude, longitude, dtOrderCreate, postalCode, number, total_shipping, customer, items, payments)  
        # Instance variables  
        
        @externalCode = externalCode 
        @storeId = storeId
        @subTotal  = subTotal
        @deliveryFee  = deliveryFee
        @total = total
        @country  = country
        @state = state
        @city = city
        @district = district
        @street = street
        @complement = complement
        @latitude = latitude
        @longitude = longitude
        @dtOrderCreate = dtOrderCreate
        @postalCode = postalCode
        @number = number
        @total_shipping = total_shipping
        @customer = customer
        @items = items
        @payments = payments

      end  

end
  