class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.belongs_to :match
      t.string :nickname
      t.integer :points, :default => 0
      t.boolean :correctly_guessed?, :default => false
      t.boolean :your_turn?, :default => false
      t.boolean :has_gone?, :default => false

      t.timestamps
    end
  end
end
