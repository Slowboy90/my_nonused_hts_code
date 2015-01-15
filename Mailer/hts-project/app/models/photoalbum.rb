# class for Photoalbums
class Photoalbum < ActiveRecord::Base
  has_many :photos
  validates_presence_of :name,
                        message: 'U moet de naam van het fotoalbum invullen.'
end
