require 'sinatra'  
require 'active_support/core_ext'
require 'mongo_mapper'

require_relative 'User'
require_relative 'Subscription'


MongoMapper.connection = Mongo::Connection.new('localhost',27017, :pool_size => 5)
MongoMapper.database = 'fastlege'

#static content
get "/" do
  File.read(File.join('public', 'index.html'))
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
	userdata = JSON.parse(request.body.read)  
	newuser = User.new(userdata) 
  	newuser.save
end

# get all subscriptions for changes with doctor
get '/users/:id/subscriptions' do
	puts("get subscriptions for user with id " + params[:id])
	user = User.find_by_id(params[:id])
	user.subscriptions.to_json
end


# create subscription for changes with doctor
post '/users/:id/subscriptions' do
	puts("creating subscriptions for user with id " + params[:id])
	user = User.find_by_id(params[:id])
	subscriptionData = JSON.parse(request.body.read.to_s)  
	user.subscriptions.build(subscriptionData)
  	user.save
 end

# get doctors in Oslo 
get '/doctors' do
	[{ :id => '1234', :name => 'Dr.Dyrego', :kjonn => 'M', :praksisnavn => 'Dr.Dyrego klinikken', :tilgjengelig => 'J', :adresse => 'Adresse', :poststed => 'Dr.Dyrego', :ledig => 'N'} , 
	 { :id => '12345', :name => 'Dr.Dyrego', :kjonn => 'K', :praksisnavn => 'Dr.Dyrego klinikken', :tilgjengelig => 'J', :adresse => 'Adresse', :poststed => 'Dr.Dyrego', :ledig => 'N'}].to_json
end
