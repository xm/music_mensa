class User < ActiveRecord::Base
  attr_reader :password

  validates :email, :password_digest, :session_token, presence: true
  validates :email, :session_token, uniqueness: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  after_initialize :set_session_token
  
  has_many(
    :notes,
    class_name: "Note",
    foreign_key: :user_id,
    primary_key: :id,
    dependent: :destroy
  )

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_token
    SecureRandom.urlsafe_base64
  end

  def set_session_token
    self.session_token ||= User.generate_token
  end

  def reset_session_token!
    self.update(session_token: User.generate_token)
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end

  def is_admin?
    self.admin
  end

  def most_recent_notes
    notes.order(:created_at).limit(10)
  end
end
