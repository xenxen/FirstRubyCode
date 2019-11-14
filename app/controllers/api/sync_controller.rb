# app/controllers/api/sync_controller.rb

require 'rest-client'

class Api::SyncController < Api::BaseController
    

    # GET /api/sync
    def index
        # Teste inicial para montagem do objeto e saída da API
        #t = testeObject
        #render :json => t, :include => [:payments, :buyer, :shipping => { :include => :receiver_address  }, :order_items => { :include => :item}] 

        render json: "ok", status: :ok

    end

    # POST /api/sync
    def create
 
        proc = Process.new

        @sync = proc.integrate(params.to_json, '10.0.0.0')
        @service = nil

        if @sync.save
          #dados persistidos

          saida = proc.prepare_to_send(@sync.order)
        #   saida = '{
        #     "externalCode": 9987071,
        #     "storeId": 282,
        #     "subTotal": 49.9,
        #     "deliveryFee": 5.14,
        #     "total": 55.04,
        #     "country": "BR",
        #     "state": "São Paulo",
        #     "city": "Cidade de Testes",
        #     "district": "Vila de Testes",
        #     "street": "Rua Fake de Testes",
        #     "complement": "teste",
        #     "latitude": "-23.629037",
        #     "longitude": "-46.712689",
        #     "dtOrderCreate": "2019-06-24T20:45:32.000Z",
        #     "postalCode": "85045020",
        #     "number": "3454",
        #     "customer": {
        #        "externalCode": 136226073,
        #        "name": "John Doe",
        #        "email": "john@doe.com",
        #        "contact": "4141"
        #     },
        #     "items": [
        #        {
        #           "externalCode": "IT4801901403",
        #           "name": "Produto de Testes",
        #           "price": 49.9,
        #           "quantity": 1,
        #           "total": 49.9,
        #           "subItems": []
        #        }
        #     ],
        #     "payments": [
        #        {
        #           "type": "credit_card",
        #           "value": 55.04
        #        }
        #     ]
        #  }'

          # enviado dados para a API da Delivery Center

          url     = "https://delivery-center-recruitment-ap.herokuapp.com"
          request = RestClient.post(url, saida.to_json, headers)
          retornoDC = request.body

          # Recupera as entidades
          render :json => retornoDC

        else
      
          render json: @sync.errors, status: :unprocessable_entity
      
        end
      
    end

    def sync_params
 
        params.require(:id)
        #params.require(:contact).permit(:name, :email, :phone, :description)
    
    end

    
    def headers
        {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'X-Sent': Time.now.strftime("%Hh%M - dd/mm/yyyy")
        }
    end


    
  end