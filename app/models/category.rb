class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true

  before_save :generate_slug

  def to_param
    self.to_slug
  end

  def generate_slug
    the_slug = self.to_slug
    category = Cateogry.find_by(slug: the_slug)

    unique_id = 2

    while category && self != cateogry
      the_slug = append_suffix(the_slug, unique_id)
      category = Category.find_by(slug: the_slug)
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
    str = self.name
    str = str.gsub(/\s*[^a-z^A-Z^0-9]\s*/, '-')
    str = str.gsub(/-+/, '-')
    str = str.gsub(/(?<=\A)-/, '')
    str = str.gsub(/(?<=-)\z/, '')
    str.downcase
  end
end