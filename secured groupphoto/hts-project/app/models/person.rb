class Person < ActiveRecord::Base
  belongs_to :user

  has_many :groupphotos
  
  has_many :processed_images
  validates_presence_of :first_name, :last_name, :email
end
