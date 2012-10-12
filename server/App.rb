require 'sinatra'  
require 'json'

require_relative 'user'

get '/' do  
	 'Hello, World!'  
end  

get '/user/:id' do  
	 User.new("123", "Tobias", "Torrissen", "tobiast@gmail.com", "98257822").to_json
end  

