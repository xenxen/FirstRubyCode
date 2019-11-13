# app/controllers/api/sync_controller.rb
class Api::SyncController < Api::BaseController
    
    
    def index
        # Teste inicial para montagem do objeto e saída da API
        t = testeObject
        render :json => t, :include => [:payments, :buyer, :shipping => { :include => :receiver_address  }, :order_items => { :include => :item}] 



    end

    # POST /api/sync

    def create
 
        #@contact = Contact.new(contact_params.merge(user: current_user))
        
        sync_params
        @sync = Sync.new()
      
        if @sync.save
      
          render json: "Salvou", status: :created
      
        else
      
          render json: @sync.errors, status: :unprocessable_entity
      
        end
      
    end

    def sync_params
 
        params.require(:id)
        #params.require(:contact).permit(:name, :email, :phone, :description)
    
      end

    def testeObject

        par = {
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
            ],
            shipping_attributes: {
                external_id: 43444211797,
                shipment_type: "shipping",
                date_created: "2019-06-24T16:45:33.000-04:00",
                receiver_address_attributes: {
                    external_id: 1051695306,
                    address_line: "Rua Fake de Testes 3454",
                    street_name: "Rua Fake de Testes",
                    street_number: "3454",
                    comment: "teste",
                    zip_code: "85045020",
                    city_attributes: {
                        name: "Cidade de Testes"
                    },
                    state_attributes: {
                        "name": "São Paulo"
                    },
                    country_attributes: {
                        external_id: "BR",
                        name: "Brasil"
                    },
                    neighborhood_attributes: {
                        name: "Vila de Testes"
                    },
                    latitude: -23.629037,
                    longitude: -46.712689,
                    receiver_phone: "41999999999"
                }
            },
            buyer_attributes: {
                external_id: 136226073,
                nickname: "JOHN DOE",
                email: "john@doe.com",
                phone_attributes: {
                   area_code: 41,
                   number: "999999999"
                },
                first_name: "John",
                last_name: "Doe",
                billing_info_attributes: {
                   doc_type: "CPF",
                   doc_number: "09487965477"
                }
             }

        }
        o  = Order.create(par)
                
        o.save
            
        return o 
    end

 
  end