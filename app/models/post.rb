class Post < ActiveRecord::Base
  include VoteableLsb

  belongs_to :creator, foreign_key: "user_id", class_name: "User"  
  has_many :comments
  has_many :post_categories
  has_many :categories, through: :post_categories

  validates :title, presence: true, length: {minimum: 5}
  validates :description, presence: true
  validates :url, presence: true, uniqueness: true

  before_save :generate_slug

  def to_param
    self.to_slug
  end

  def generate_slug
    the_slug = self.to_slug
    post = Post.find_by(slug: the_slug)

    unique_id = 2

    while post && self != post
      the_slug = append_suffix(the_slug, unique_id)
      post = Post.find_by(slug: the_slug)
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
    str = self.title
    str = str.gsub(/\s*[^a-z^A-Z^0-9]\s*/, '-')
    str = str.gsub(/-+/, '-')
    str = str.gsub(/(?<=\A)-/, '')
    str = str.gsub(/(?<=-)\z/, '')
    str.downcase
  end
end