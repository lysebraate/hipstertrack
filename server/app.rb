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


class App < Sinatra::Base

	#static content
	get "/" do
	  File.read(File.join('public', 'index.html'))
	end

	# get a known user 
	get '/users/:id' do  
		puts("getting user with id " + params[:id])
		'{"email":"tto@knowit.no", "firstname":"tobias", "lastname":"tobias""id":"1", "phonenumber":"98257822"}'
	end  

	# get all users
	get '/users' do  
	 	puts("getting user")	
	end  
  
  # create a new user 
	post '/users' do 
		puts("creating user")
	end

	# get all subscriptions for changes with doctor
	get '/users/:id/subscriptions' do
		puts("get subscriptions for user with id " + params[:id])
	end

	# create subscription for changes with doctor
	post '/users/:id/subscriptions' do
		puts("creating subscriptions for user with id " + params[:id])
	 end

  # create subscription for changes with doctor
  post '/users/:userid/subscriptions/:doctorid' do
  end

  # delete subscription for changes with doctor
  delete '/users/:userid/subscriptions/:doctorid' do
  end

	# get doctors in Oslo. Remote call to fastlegetjeneste by JHG
	get '/doctors' do
		$base_url = "byttfastlege.herokuapp.com"
		Net::HTTP.get($base_url, $kvinnerioslo_url)
	end

end
