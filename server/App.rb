require 'sinatra'  
require 'active_support/core_ext'
require 'mongo_mapper'

require_relative 'User'

MongoMapper.connection = Mongo::Connection.new('localhost',27017, :pool_size => 5)
MongoMapper.database = 'fastlege'


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
get '/subsriptions' do
	puts("getting subscriptions")
end

# create subscription for changes with doctor
post '/subsriptions' do
	puts("creating subscriptions")

end
