require "rubygems"
require "sinatra"
require "gamerocket"

GameRocket::Configuration.environment= :production
GameRocket::Configuration.apiKey= "<use_your_apikey>"
GameRocket::Configuration.secretKey= "<use_your_secretkey>"

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
  result_action = GameRocket::Action.run("hello-world", {
      :player => "use_player_id",
      :name => params[:name]
    })
    
  if result_action.success?
    message = "<h1>Success! Result: #{result_action.data["hello"]}</h1>"
  else
    message = "<h1>Error: #{result_action.error_description}</h1>"
  end
    
  erb :response, :locals => {
    :message => message
  }
end