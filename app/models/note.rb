class Note < ActiveRecord::Base
  validates :user_id, :track_id, :content, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :track,
    class_name: "Track",
    foreign_key: :track_id,
    primary_key: :id
  )

  def authored_date
    self.created_at.strftime("%b. %e, %G at %r").downcase
  end
end
