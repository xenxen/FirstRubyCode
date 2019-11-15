class DC::Customer
    attr_accessor :externalCode, :name, :email, :contact

    def initialize(externalCode, name, email, contact)
        # Instance variables  
        
        @externalCode = externalCode
        @name = name
        @email = email
        @contact = contact

      end  

end
  