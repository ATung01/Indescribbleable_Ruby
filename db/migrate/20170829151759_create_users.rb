class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.belongs_to :matches
      t.string :nickname
      t.string :guess
      t.integer :points

      t.timestamps
    end
  end
end
