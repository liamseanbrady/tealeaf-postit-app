class AddSlugsToModels < ActiveRecord::Migration
  def change
    add_column :posts, :slug, :string
    add_column :comments, :slug, :string
    add_column :users, :slug, :string    
  end
end
