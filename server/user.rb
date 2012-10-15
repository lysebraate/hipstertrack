# encoding: utf-8
require 'mongo_mapper'

class User
  include MongoMapper::Document

  key :firstname, String
  key :lastname, String 
  key :email, String 
  key :phonenumber, String 
  
  many :subscriptions

  def subscribed_to_ids? doctor_ids
	doctor_ids.each do |doctorid| 
		return true if subscribed_to_id? (doctorid)
	end
	false 	
  end

  def subscribed_to_id? doctor_id
  	!subscriptions.select{|s| s.doctorid == doctor_id.to_s}.first.nil?
  end

  def describe
  	puts "#{firstname} #{lastname} <#{email}> #{phonenumber}"
  end
end
