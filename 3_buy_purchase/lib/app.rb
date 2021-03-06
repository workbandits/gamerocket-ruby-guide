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
  result = GameRocket::Action.run("hello-world", {
      :player => "use_player_id",
      :name => params[:name]
    })
    
  if result.success?
    message = "<h1>Success! Result: #{result.data["hello"]}</h1>"
  else
    message = "<h1>Error: #{result.error_description}</h1>"
  end
    
  erb :response, :locals => {
    :message => message
  }
end

get "/unlock_content" do
  result = GameRocket::Purchase.buy("unlock-content", {
      :player => "use_player_id"
    })
    
  if result.success?
    message = "<h1>Success! Purchase result: #{result.data["message"]}</h1>"
  else
    message = "<h1>Error: #{result.error_description}</h1>"
  end
    
  erb :response, :locals => {
    :message => message
  }
end