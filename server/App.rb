require 'sinatra'  
require 'active_support/core_ext'

require_relative 'user'

get '/' do  
	 'Hello, World!'  
end  


# get a known user 
get '/users/:id' do  
	 puts("getting user")

	 User.new("123", "Tobias", "Torrissen", "tobiast@gmail.com", "98257822").to_json
end  


# get all users
get '/users' do  
	 puts("getting users")
	 User.new("123", "Tobias", "Torrissen", "tobiast@gmail.com", "98257822").to_json
end  


# update a known user
put '/users/:id' do 
	 puts("Updating user")

end

# create a new user 
post '/users' do 
	puts("creating user")
	
	data = JSON.parse(request.body.read.to_s)  
	

	puts(data)
end


# get subscription for changes with doctor
get '/subsriptions' do


end


# get all subscriptions for changes with doctor
get '/subsriptions' do


end


# create subscription for changes with doctor
post '/subsriptions' do


end



