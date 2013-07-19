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
    p result
    message = "<h1>Error: #{result.error_description}</h1>"
  end
  
  erb :response, :locals => {:message => message}
end