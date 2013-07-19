require "sinatra"
require "shotgun"
require "gamerocket"

GameRocket::Configuration.environment= :development
GameRocket::Configuration.apiKey= "7b53224077114512ba6684d8b9078df9" #"your_api_key"
GameRocket::Configuration.secretKey= "4fb6dc47402e4d2dba3d064c5f17b303" #"your_secret_key"


get "/" do  
  erb :form
end

post "/create_player" do
  result = GameRocket::Player.create(
    :name => params[:name], 
    :locale => params[:locale]
  )
  
  if result.success?
    message = "<h1>Success! Player ID: #{result.player.id}</h1>"
  else
    message = "<h1>Error: #{result.error_description}</h1>"
  end
  
  erb :response, :locals => {
    :message => message,
  }
end

get "/run_action" do
  result_action = GameRocket::Action.run("test", {
      :player => "7b53224077114512ba6684d8b9078df9_51decdf0e4b05dc822d901d5"#use player ID
    })
    
  if result_action.success?
    message = "<h1>Success! Action status: #{result_action.status} for player #{result_action.data["player"]["name"]}</h1>"
  else
    message = "<h1>Error: #{result_action.error_description}</h1>"
  end
    
  erb :response, :locals => {
    :message => message
  }
end

get "/unlock_content" do
  result_purchase = GameRocket::Purchase.buy("unlock-content", {
      :player => "7b53224077114512ba6684d8b9078df9_51decdf0e4b05dc822d901d5"
    })
    
  if result_purchase.success?
    message = "<h1>Success! Purchase result: #{result_purchase.data["message"]}</h1>"
  else
    message = "<h1>Error: #{result_purchase.error_description}</h1>"
  end
    
  erb :response, :locals => {
    :message => message
  }
end