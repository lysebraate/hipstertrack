class User 
  attr_accessor :id, :firstname, :lastname, :email, :phonenumber

  def initialize(id, firstname, lastname, email, phonenumber)
    @id = id
    @firstname = firstname
    @lastname = lastname
    @email = email
    @phonenumber = phonenumber
  end

  def to_json(*a)
          {
            'id' => @id,
            'firstname' => @firstname,
            'lastname' => @lastname,
            'email' => @email,
            'phonenumber' => @phonenumber        
            }.to_json(*a) 
      end
end