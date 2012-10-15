class Subscription
        include MongoMapper::Document
        key :userid, String
        key :doctorid, String
end