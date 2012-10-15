# encoding: utf-8

require 'rubygems'
require 'net/http'
require 'json'

require_relative 'mongo_database'
require_relative 'user'
require_relative 'subscription'

$base_url = "lit-bayou-7664.herokuapp.com"
$kvinnerioslo_url = "/fastleger/kvinnerioslo"

class FastlegeUpdateHelper

	def self.add_test_user
		newuser = User.new
		newuser.firstname = "Test"
		newuser.lastname = "Testesen"
		newuser.email = "test@test.no"

		subscription = Subscription.new
		subscription.doctorid = 6

		newuser.subscriptions << subscription
		newuser.save

		newuser = User.new
		newuser.firstname = "Test2"
		newuser.lastname = "Testesen2"
		newuser.email = "test@test2.no"

		subscription = Subscription.new
		subscription.doctorid = 999999999

		newuser.subscriptions << subscription
		newuser.save
	end

	def self.check_updated
		# Get the list of updated doctor_ids
		doctor_ids = JSON.parse(Net::HTTP.get($base_url, $kvinnerioslo_url)).map do |doctor|
			doctor["id"]
		end

		# Make a list of users that has updated doctors
		userlist = User.all.select do |user|
			user.subscribed_to_ids?(doctor_ids) 
		end
		
		# Simply print them out for now
		puts "Lister ut brukere med oppdaterte fastleger..."
		userlist.each { |user| puts user.describe }
	end

end
