# encoding: utf-8

require 'sinatra'  
require 'active_support/core_ext'
require 'mongo_mapper'
require 'net/http'
require 'pp'

require_relative 'user'
require_relative 'subscription'
require_relative 'mongo_database'
require_relative 'fastlege_update_helper'


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
post '/users/:userid/subscriptions/:doctorid' do
  content_type :json
  user_id = params[:userid]
  doctor_id = params[:doctorid]
	puts("creating subscriptions for user with id #{user_id} for doctor #{doctor_id}")
	user = User.find_by_id(user_id)
  user.subscribe(doctor_id)
  user.save
end

delete '/users/:userid/subscriptions/:doctorid' do
  content_type :json
  user_id = params[:userid]
  doctor_id = params[:doctorid]
	puts("deleting subscriptions for user with id #{user_id} for doctor #{doctor_id}")
  user = User.find_by_id(user_id)
  user.unsubscribe(doctor_id)
  user.save
end

# get doctors in Oslo. Remote call to fastlegetjeneste by JHG
get '/doctors' do
  content_type :json
  f = File.open("doctors.json")
  f.gets
	#$base_url = "lit-bayou-7664.herokuapp.com"
	#Net::HTTP.get($base_url, $kvinnerioslo_url)
end
