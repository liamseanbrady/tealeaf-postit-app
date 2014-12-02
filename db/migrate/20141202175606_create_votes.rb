class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.column :vote, :boolean
      t.column :user_id, :integer
      t.column :voteable_type, :string
      t.column :voteable_id, :integer

      t.timestamps
    end
  end
end
