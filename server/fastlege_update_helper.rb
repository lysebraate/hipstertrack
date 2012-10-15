# encoding: utf-8

require 'rubygems'
require 'net/http'
require 'json'

require_relative 'fastlege'

$base_url = "lit-bayou-7664.herokuapp.com"

class FastlegeUpdateHelper

	def self.check_updated
		response = Net::HTTP.get($base_url,"/fastleger/kvinnerioslo")	
		
		JSON.parse(response).each do |item|
			fastlege = Fastlege::from_json item
			puts fastlege.id
		end

#		fastlege = Fastlege.new
#		fastlege.from_json!(response)
#		puts fastlege
	end


end
