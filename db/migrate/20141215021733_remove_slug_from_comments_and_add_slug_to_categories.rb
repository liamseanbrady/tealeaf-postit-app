class RemoveSlugFromCommentsAndAddSlugToCategories < ActiveRecord::Migration
  def change
    remove_column :comments, :slug
    add_column :categories, :slug, :string
  end
end
