require 'sinatra'  
require 'json'

require_relative 'user'

get '/' do  
	 'Hello, World!'  
end  


# get a known user 
get '/user/:id' do  
	 puts("getting user")

	 User.new("123", "Tobias", "Torrissen", "tobiast@gmail.com", "98257822").to_json
end  


# get all users
get '/user/all' do  
	 puts("getting users")
	 User.new("123", "Tobias", "Torrissen", "tobiast@gmail.com", "98257822").to_json
end  


# update a known user
put '/user/:id' do 
	 puts("Updating user")

end

# create a new user 
post '/user' do 
	puts("creating user")
	data = JSON.parse(params) 
end

