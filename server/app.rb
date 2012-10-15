require 'sinatra'  
require 'active_support/core_ext'
require 'mongo_mapper'

require_relative 'User'
require_relative 'Subscription'


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
	newuser = User.new(userdata) 
  	newuser.save

	puts(userdata)
end

# get all subscriptions for changes with doctor
get '/users/:id/subscriptions' do
	puts("get subscriptions for user with id " + params[:id])

	[{ :doctorid => '1234', :userid => '1234' },{ :doctorid => '12345', :userid => '12345' }].to_json
end

# create subscription for changes with doctor
post '/users/:id/subscriptions' do
	puts("creating subscriptions for user with id " + params[:id])
	subscriptionData = JSON.parse(request.body.read.to_s)  
	puts(subscriptionData)
	newsubscription = Subscription.new(subscriptionData)
    newsubscription.userid = params[:id]
  	newsubscription.save
 end

# get doctors in Oslo 
get '/doctors' do
	[{ :doctorid => '1234', :name => 'Dr.Dyrego' },{ :doctorid => '12345', :name => 'Dr.Shivago' },{ :doctorid => '12345', :name => 'Dr.No' }].to_json
end