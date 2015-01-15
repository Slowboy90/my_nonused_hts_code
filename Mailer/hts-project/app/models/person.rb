# Class for model of people database
class Person < ActiveRecord::Base
  belongs_to :user

  has_many :groupphotos
  
  has_many :processed_images
  validates_presence_of :first_name,
                        :last_name,
                        :email,
                        :street,
                        :number,
                        :city,
                        :zipcode,
                        :graduation_year,
                        :major,
                        message: 'moet ingevuld zijn'
end
