# app/controllers/api/sync_controller.rb

require 'rest-client'

class Api::SyncController < Api::BaseController
    
    # GET /api/sync
    def index
        # Teste inicial 
        render json: "API Running | Use the POST method to Syncronize data", status: :ok
    end

    # POST /api/sync
    def create

        #Criação e preparação dos objetos para persistencia na base
        proc = Process.new
        #@sync = 
        proc.create_sync(params.to_json, '10.0.0.0')

        #persistindo dados
        if proc.sync.save

          # enviado dados para a API da Delivery Center
          
          sync_result = DeliveryCenterApiService.new({
            sync: proc.sync
          }).sync_to_delivery
          
          #Atualiza o Status do objeto Sync sinalizando o resultado e a dataHora da conclusão
          if sync_result[:status] == 'SUCCESS'
            proc.complete_sync('SUCCESS')
            proc.sync.save
          else
            proc.complete_sync('ERROR')
            proc.sync.save
          end  

          render json: sync_result

        else

          render json: { status: :unprocessable_entity, message: 'Failed to persist data', data: proc.sync.errors }
     
        end
      
    end

    def sync_params
 
        params.require(:teste)
        #params.require(:contact).permit(:name, :email, :phone, :description)
    
    end

    
  
  end