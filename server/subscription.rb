# encoding: utf-8

class Subscription
        include MongoMapper::EmbeddedDocument
        key :userid, String
        key :doctorid, String
end