class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.belongs_to :match
      t.string :nickname
      t.string :guess
      t.integer :points
      t.boolean :your_turn?
      t.boolean :has_gone?

      t.timestamps
    end
  end
end
