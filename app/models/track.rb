class Track < ActiveRecord::Base
  validates :album_id, :name, :number, presence: true
  validates :album_id, uniqueness: { 
    scope: :number,
    message: "track numbers can only exist once"
  }

  has_one(
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

  def display_name
    "#{ self.name }#{ " (Bonus Track)" if bonus }"
  end
end
