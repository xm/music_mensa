class Track < ActiveRecord::Base
  validates :album_id, :name, :number, presence: true
  validates :album_id, uniqueness: { 
    scope: :number,
    message: "can only exist once"
  }

  belongs_to(
    :artist,
    through: :album,
    source: :artist
  )
  
  belongs_to(
    :album,
    class_name: "Album",
    foreign_key: :album_id,
    primary_key: :id
  )
end
