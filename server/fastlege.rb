# encoding: utf-8

class Fastlege

	attr_accessor :id

    def self.from_json string
        data = JSON.parse(string)
        self.new data['id']
    end

end
