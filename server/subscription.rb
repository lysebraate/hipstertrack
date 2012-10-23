# encoding: utf-8
require 'mongo_mapper'

class Subscription
        include MongoMapper::EmbeddedDocument
        key :userid, String
        key :doctorid, String
end
