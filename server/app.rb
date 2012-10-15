# encoding: utf-8

require 'sinatra'  
require 'active_support/core_ext'
require 'mongo_mapper'

require_relative 'user'
require_relative 'mongo_database'

get "/" do
  File.read(File.join('../public', 'index.html'))
end

# get a known user 
get '/users/:id' do  
	puts("getting user with id " + params[:id])
	user = User.find_by_id(params[:id])
	user.to_json
end  

# get all users
get '/users' do  
 	puts("getting user")	
	users = User.all
	users.to_json
end  

# create a new user 
post '/users' do 
	puts("creating user")

	userdata = JSON.parse(request.body.read.to_s)  
	mongouser = User.new(userdata) 
  	mongouser.save

	puts(userdata)
end

# get all subscriptions for changes with doctor
get '/subscriptions' do
	puts("getting subscriptions")
end

# create subscription for changes with doctor
post '/subscriptions' do
	puts("creating subscriptions")

end
