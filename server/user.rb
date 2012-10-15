# encoding: utf-8

class User
  include MongoMapper::Document

  key :firstname, String
  key :lastname, String 
  key :email, String 
  key :phonenumber, String 

 # many :subscriptions
end
