class Album < ActiveRecord::Base
  validates :artist_id, :name, :kind, presence: true
  validates :kind, inclusion: AlbumsHelper.all_kinds

  belongs_to(
    :artist,
    class_name: "Artist",
    foreign_key: :artist_id,
    primary_key: :id
  )

  has_many(
    :tracks,
    class_name: "Track",
    foreign_key: :album_id,
    primary_key: :id,
    dependent: :destroy
  )
end
