# encoding: utf-8

require 'rubygems'
require 'net/http'
require 'json'

require_relative 'mongo_database'
require_relative 'user'
require_relative 'subscription'

$base_url = "lit-bayou-7664.herokuapp.com"

class FastlegeUpdateHelper

	def self.add_test_user
		newuser = User.new
		newuser.firstname = "Test"
		newuser.lastname = "Testesen"
		newuser.email = "jhg@knowit.no"

		subscription = Subscription.new
		subscription.doctorid = 6

		newuser.subscriptions << subscription
		newuser.save
	end

	def self.check_updated
		response = Net::HTTP.get($base_url,"/fastleger/kvinnerioslo")
		subscriptions = JSON.parse(Subscription.all)

		JSON.parse(response).reduce([]) do |total, item|
#			subscriptions.include?(item.id) : total << item ? total
		end
		puts total
	end
end
