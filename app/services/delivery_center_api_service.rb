# app/services/delivery_center_api_service.rb

# Classe de Serviço para centralizar a chamada da API da DeliveryCenter

class DeliveryCenterApiService
    
    attr_reader :sync

    def initialize(params)
      @sync = params[:sync]
    end

    def sync_to_delivery
        begin
            saida = prepare_to_send(@sync.order)
            url     = "https://delivery-center-recruitment-ap.herokuapp.com"
            request = RestClient.post(url, saida.to_json, headers)
          
            retornoDC = request.body

            return { status: 'SUCCESS', message: 'Syncronization complete', data: retornoDC }

          rescue RestClient::ExceptionWithResponse => e

            return { status: e.response.code, message: e.message, data: e.response.to_json }

          end
    end

    def headers
        {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'X-Sent': Time.now.strftime("%Hh%M - dd/mm/yyyy")
        }
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

end


