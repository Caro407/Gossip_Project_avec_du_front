class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :gossip, index: true
      t.timestamps
    end
    add_reference :gossips, :like, foreign_key: true
    add_reference :users, :like, foreign_key: true
  end
end
