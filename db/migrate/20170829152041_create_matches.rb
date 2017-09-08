class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :round
      t.string :winner
      t.string :room_code
      t.string :answer
      t.string :started, :default => false
      t.string :ended, :default => false

      t.timestamps
    end
  end
end
