# encoding: utf-8

require 'sinatra'  
require 'active_support/core_ext'
require 'mongo_mapper'
require 'net/http'

require_relative 'user'
require_relative 'subscription'
require_relative 'mongo_database'
require_relative 'fastlege_update_helper'

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

# get doctors in Oslo. Remote call to fastlegetjeneste by JHG
get '/doctors' do
	$base_url = "lit-bayou-7664.herokuapp.com"
	Net::HTTP.get($base_url, $kvinnerioslo_url)
end
