class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true, length: {minimum: 3}
  validates :password, presence: true, length: {minimum: 8}, on: :create

  before_save :generate_slug

  def admin?
    self.role == 'admin' if !self.role.blank?
  end

  def to_param
    self.to_slug
  end

  def generate_slug
    the_slug = self.to_slug
    user = User.find_by(slug: the_slug)

    unique_id = 2

    while user && self != user
      the_slug = append_suffix(the_slug, unique_id)
      user = User.find_by(slug: the_slug)
      unique_id += 1
    end

    self.slug = the_slug
  end

  def append_suffix(str, u_id)
    if str.split('-').last.to_i != 0
      return str.split('-').slice(0...-1).join('-') + "-#{u_id}"
    else
      return str + "-#{u_id}"
    end
  end 

  def to_slug
    str = self.username
    str = str.gsub(/\s*[^a-z^A-Z^0-9]\s*/, '-')
    str = str.gsub(/-+/, '-')
    str = str.gsub(/(?<=\A)-/, '')
    str = str.gsub(/(?<=-)\z/, '')
    str.downcase
  end
end