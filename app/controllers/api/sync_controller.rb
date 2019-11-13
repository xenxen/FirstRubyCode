# app/controllers/api/sync_controller.rb
class Api::SyncController < Api::BaseController
    def index
        #o = fakeobj
        o = fakeobj2
        #render json: o
        #render :json => o, :include => :posts 

        render :json => o, :include => [:payments, :order_items => { :include => :item}] 


    end

    def fakeobj2

        params = {
            external_id: 9987071,
            store_id: 282,
            date_created: "2019-06-24T16:45:32.000-04:00",
            date_closed: "2019-06-24T16:45:35.000-04:00",
            last_updated: "2019-06-25T13:26:49.000-04:00",
            total_amount: 49.9,
            total_shipping: 5.14,
            total_amount_with_shipping: 55.04,
            paid_amount: 55.04,
            expiration_date: "2019-07-22T16:45:35.000-04:00",
            total_shipping: 5.14,    
            status: "paid", 
            order_items_attributes: [
                {
                    item_attributes: {
                        external_id: "IT4801901403",
                        title: "Produto de Testes"
                    },
                    quantity: 1,
                    unit_price: 49.9,
                    full_unit_price: 49.9
                }
            ],
            payments_attributes: [
                {
                    external_id: 12312313,
                    order_id: 9987071,
                    payer_id: 414138,
                    installments: 1,
                    payment_type: "credit_card",
                    status: "paid",
                    transaction_amount: 49.9,
                    taxes_amount: 0,
                    shipping_cost: 5.14,
                    total_paid_amount: 55.04,
                    installment_amount: 55.04,
                    date_approved: "2019-06-24T16:45:35.000-04:00",
                    date_created: "2019-06-24T16:45:33.000-04:00"
                }
            ]
          }

        o  = Order.create(params)
                

            
        
        return o 
    end

 
  end