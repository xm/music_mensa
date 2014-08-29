class Artist < ActiveRecord::Base
  validates :name, presence: true

  has_many(
    :albums,
    class_name: "Album",
    foreign_key: :artist_id,
    primary_key: :id,
    dependent: :destroy
  )

  has_many(
    :tracks,
    through: :albums,
    source: :tracks
  )
end
