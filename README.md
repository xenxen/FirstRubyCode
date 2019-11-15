# README

código: https://github.com/xenxen/FirstRubyCode/edit/master/

Na criação do Projeto, criei uma API para receber o Payload, processar e fazer a chamada da API da Delivery Center

	-> http://localhost:3000/api/sync
		- GET - retorna apenas um JSON com uma mensagem de que a API está no ar
		- POST - Metodo que recebe o Payload indicado, faz o devido processamento e consome a API da Delivery
		
	-> http://localhost:3000/
		- Pagina com a chamada Ajax para a API, para facilitar a visualização e operação.
		
Modelos
    Criação dos modelos para persistencia em banco de todas as possiveis entidades identificadas no Json de origem, sendo:
    
        - Order
        - OrderItem
        - Item
        - Payment
        - City
        - State
        - Country
        - Neighborhood
        - Shipping
        - ReceiverAddress
        - Buyer
        - Phone
        - BillingInfo
        - Sync (este ultimo, um objeto para salvar as informações basicas da requisição, contendo informações como Data da Solicitação, Data da Conclusão, Status, Payload original de entrada, vinculo com o objeto Order criado a partir do Payload com todas as suas dependencias)
	
    Foi criado um pacote DC e criado Objetos simples para facilitar a montagem do objeto que deveria ser enviado para a API da Delivery Center contendo:
    
        - Customer
        - Item
        - Payment
        - Process

Classes de apoio
    - Foi criado um Service (app/services/delivery_center_api_service.rb) para cuidar de todas as operações de iteração com a API da Delivery Center
    
    - Foi criada uma Classe de Apoio ao Controller Sync chamada Process (app/controllers/api/sync_controller/sync_process.rb) responsácel pelas regras de negócio e de conversão, para que o Controller ficasse responsável apenas pelas operações mais basicas.

    

