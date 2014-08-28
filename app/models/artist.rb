class Artist < ActiveRecord::Base
  validates :name, presence: true

  has_many(
    :albums,
    class_name: "Album",
    foreign_key: :artist_id,
    primary_key: :id
  )

  has_many(
    :track,
    through: :albums,
    source: :tracks
  )
end
