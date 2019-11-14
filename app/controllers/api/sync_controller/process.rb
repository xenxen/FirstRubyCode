# app/controllers/api/sync_controller/sync_process.rb

class Api::SyncController
    class Process

        attr_reader :payload, :sender_ip, :parsed_json
        
        def initialize
          
        end
        
        def integrate(payload, sender_ip)
            @payload = payload
            @sender_ip = sender_ip
            @parsed_json = parse_imput @payload

            sync = Sync.new()
            sync.date_created = Time.now.utc
            sync.date_processed = nil
            sync.sender_ip = @sender_ip
            sync.payload = @payload
            sync.status = 'Processing'
            sync.storeId = @parsed_json['store_id']
            sync.externalCode = @parsed_json['id']
            
            sync.order = create_order(@parsed_json)

            return sync
        end    

        def parse_imput(payload = nil)
            
            unless payload.nil? 
                @payload = payload
            end
            
            #parsed = JSON.parse(payload)
            parsed = JSON.parse(@payload, object_class: OpenStruct)

            return parsed
        end    

        def prepare_to_send(order)

            obj_customer = DC::Customer.new( 
                order.buyer.external_id, 
                "#{order.buyer.first_name} #{order.buyer.last_name}",
                order.buyer.email, 
                "#{order.buyer.phone.area_code}#{order.buyer.phone.number}", 
            )

            obj_items = []
            order.order_items.each do |oi|
                obj_items.push(DC::Item.new(oi.item.external_id, 
                    oi.item.title, 
                    oi.unit_price, 
                    oi.quantity, 
                    oi.full_unit_price, 
                    nil))
                
            end

            obj_payments = []
            order.payments.each do |pay|
                obj_payments.push(DC::Payment.new(pay.payment_type, 
                    pay.total_paid_amount, 
                    ))
                
            end

            obj_to_send = DC::Process.new(
                order.external_id, 
                order.store_id, 
                order.total_amount, 
                order.total_shipping, 
                order.total_amount_with_shipping, 
                order.shipping.receiver_address.country.external_id, 
                order.shipping.receiver_address.state.name,
                order.shipping.receiver_address.city.name,
                order.shipping.receiver_address.neighborhood.name,
                order.shipping.receiver_address.street_name,
                order.shipping.receiver_address.comment,
                order.shipping.receiver_address.latitude,
                order.shipping.receiver_address.longitude,
                order.date_created,
                order.shipping.receiver_address.zip_code,
                order.shipping.receiver_address.street_number,
                order.total_shipping,
                obj_customer,
                obj_items,
                obj_payments
            )

            return obj_to_send

        end

        def create_order(json)

            object = @parsed_json
            order = Order.new()
            
            # injetando as propriedades da Order
            order.external_id = object.id
            order.store_id = object.store_id
            order.date_created = object.date_created
            order.date_closed = object.date_closed
            order.last_updated = object.last_updated
            order.total_amount = object.total_amount
            order.total_shipping = object.total_shipping
            order.total_amount_with_shipping = object.total_amount_with_shipping
            order.paid_amount = object.paid_amount
            order.expiration_date = object.expiration_date
            order.total_shipping = object.total_shipping
            order.status = object.status

            # injetando as propriedades do Buyer
            order.buyer = Buyer.new()
            order.buyer.external_id = object.buyer.id
            order.buyer.nickname = object.buyer.nickname
            order.buyer.email = object.buyer.email
            order.buyer.first_name = object.buyer.first_name
            order.buyer.last_name =  object.buyer.last_name
            
            # injetando as propriedades do Phone
            order.buyer.phone = Phone.new()
            order.buyer.phone.area_code = object.buyer.phone.area_code
            order.buyer.phone.number = object.buyer.phone.area_code

            # injetando as propriedades do BillingInfo
            order.buyer.billing_info = BillingInfo.new()
            order.buyer.billing_info.doc_type = object.buyer.billing_info.doc_type
            order.buyer.billing_info.doc_number = object.buyer.billing_info.doc_number

            # injetando as propriedades do BillingInfo
            order.shipping = Shipping.new()
            order.shipping.external_id =  object.shipping.id
            order.shipping.shipment_type = object.shipping.shipment_type
            order.shipping.date_created = object.shipping.date_created

            # injetando as propriedades do ReceiverAddress
            order.shipping.receiver_address = ReceiverAddress.new()
            order.shipping.receiver_address.external_id = object.shipping.receiver_address.id
            order.shipping.receiver_address.address_line = object.shipping.receiver_address.address_line
            order.shipping.receiver_address.street_name = object.shipping.receiver_address.street_name
            order.shipping.receiver_address.street_number = object.shipping.receiver_address.street_number
            order.shipping.receiver_address.comment = object.shipping.receiver_address.comment
            order.shipping.receiver_address.zip_code = object.shipping.receiver_address.zip_code
            order.shipping.receiver_address.latitude = object.shipping.receiver_address.latitude
            order.shipping.receiver_address.longitude = object.shipping.receiver_address.longitude
            order.shipping.receiver_address.receiver_phone = object.shipping.receiver_address.receiver_phone

            # injetando as propriedades do City
			order.shipping.receiver_address.city = City.new()
            order.shipping.receiver_address.city.name = object.shipping.receiver_address.city.name
            
            # injetando as propriedades do State
			order.shipping.receiver_address.state = State.new()
            order.shipping.receiver_address.state.name = object.shipping.receiver_address.state.name

            # injetando as propriedades do Country
            order.shipping.receiver_address.country = Country.new()
            order.shipping.receiver_address.country.external_id = object.shipping.receiver_address.country.id
            order.shipping.receiver_address.country.name = object.shipping.receiver_address.country.name

            # injetando as propriedades do Neighborhood
            order.shipping.receiver_address.neighborhood = Neighborhood.new()
            order.shipping.receiver_address.neighborhood.name = object.shipping.receiver_address.neighborhood.name
            
            # injetando as propriedades da lista de Items
            #order.order_items.build()
            object.order_items.respond_to?("each")
            object.order_items.each do |oi|
                
                o = OrderItem.new()
                o.quantity = oi.quantity
                o.unit_price = oi.unit_price
                o.full_unit_price = oi.full_unit_price
                
                o.item = Item.new()
                o.item.external_id = oi.item.id
                o.item.title = oi.item.title

                order.order_items.push(o)
            end
            
            # injetando as propriedades da lista de Payments

            #order.payments.build()
            object.payments.respond_to?("each")
            object.payments.each do |pay|
                p = Payment.new()
                p.external_id = pay.id
                p.order_id = pay.order_id
                p.payer_id = pay.payer_id
                p.installments = pay.installments
                p.payment_type = pay.payment_type
                p.status = pay.status
                p.transaction_amount = pay.transaction_amount
                p.taxes_amount = pay.taxes_amount
                p.shipping_cost = pay.shipping_cost
                p.total_paid_amount = pay.total_paid_amount
                p.installment_amount = pay.installment_amount
                p.date_approved = pay.date_approved
                p.date_created = pay.date_created
                order.payments.push(p)
            end

            return order
        end    

    end
  end