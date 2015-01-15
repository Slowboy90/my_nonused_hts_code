class UniqueCodeValidator < ActiveModel::Validator
 	def validate(record)
	  	uniquecodetester = Person.where(:unique_code => record.unique_code)
	  	if uniquecodetester.first == nil
	  		record.errors[:base] << "Deze unieke code is onjuist!"
	  	end
	end
end

class User < ActiveRecord::Base
  belongs_to :person
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_with UniqueCodeValidator
  validates_uniqueness_of :unique_code
  validates_presence_of :unique_code, :message => "U moet uw unieke code nog invullen"
end
