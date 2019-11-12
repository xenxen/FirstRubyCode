# app/controllers/api/sync_controller.rb
class Api::SyncController < Api::BaseController
    def index
        #o = fakeobj
        o = fakeobj2
        #render json: o
        render json: o
        #render json: { message: 'Hello World!' }, status: :ok
    end

    def fakeobj2
        o = Loja.create(nome: 'loja')
        o.produto = Produto.create(nome: 'Produto')
        return o
    end

    def fakeobj

        o = Order.new
        o.external_id = 9987071
        o.store_id = 282
        o.date_created = '2019-06-24T16:45:32.000-04:00'
        o.date_closed = '2019-06-24T16:45:35.000-04:00'
        o.last_updated = '2019-06-25T13:26:49.000-04:00'
        o.total_amount = 49.9
        o.total_shipping = 5.14
        o.total_amount_with_shipping = 55.04
        o.paid_amount = 55.04
        o.expiration_date = '2019-07-22T16:45:35.000-04:00'
        o.total_shipping = 5.14
        o.status = 'paid'
        
        i = Item.new
        i.external_id = 'IT4801901403'
        i.title = 'Produto de Testes'
        oi = OrderItem.new
        oi.item = Item.create(quantity: 1, unit_price: 49.9, full_unit_price: 49.9)
        oi.quantity = 1
        oi.unit_price = 49.9
        oi.full_unit_price = 49.9

        o.order_items << oi
        
        p = Payment.new
        p.external_id = 12312313
        p.order_id = 9987071
        p.payer_id = 414138
        p.installments = 1
        p.payment_type = 'credit_card'
        p.status = 'paid'
        p.transaction_amount = 49.9
        p.taxes_amount = 0
        p.shipping_cost = 5.14
        p.total_paid_amount = 55.04
        p.installment_amount = 55.04
        p.date_approved = "2019-06-24T16:45:35.000-04:00"
        p.date_created = "2019-06-24T16:45:33.000-04:00"

        o.payments << p
  
        ci = City.new
        ci.name = 'Cidade de Testes'
        
        st = State.new
        st.name = 'São Paulo'
        
        co = Country.new
        co.external_id = 'BR',
        co.name = 'Brasil'
        
        ne = Neighborhood.new
        ne.external_id = nil,
        ne.name = 'Vila de Testes'

        re = ReceiverAddress.new
        re.external_id = 1051695306
        re.address_line = 'Rua Fake de Testes 3454',
        re.street_name = 'Rua Fake de Testes',
        re.street_number = '3454',
        re.comment = 'teste',
        re.zip_code = '85045020',
        re.city = ci
        re.state = st
        re.country = co
        re.neighborhood = ne
        re.latitude = -23.629037,
        re.longitude = -46.712689,
        re.receiver_phone = '41999999999'

        s = Shipping.new
        s.external_id = 43444211797
        s.shipment_type = 'shipping'
        s.date_created = '2019-06-24T16:45:33.000-04:00'
        s.receiver_address = re

        o.shipping = s

        ph = Phone.new
        ph.area_code = 41
        ph.number = '999999999'

        bi = BillingInfo.new
        bi.doc_type = 'CPF'
        bi.doc_number = '09487965477'
        
        bu = Buyer.new
        bu.id = 136226073,
        bu.nickname = 'JOHN DOE'
        bu.email = 'john@doe.com'
        bu.phone = Phone.create(area_code: 41, number: '999999999')
        #@author.books.create(published_at: Time.now)
        first_name = 'John'
        last_name = 'Doe'
        bu.billing_info = bi

        #o.buyer = ph

        ph.buyer = bu

        return ph
    end


  end