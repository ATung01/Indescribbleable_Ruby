class CreateMatches < ActiveRecord::Migration[5.1]
  def change
    create_table :matches do |t|
      t.integer :round
      t.string :winner
      t.string :room_code

      t.timestamps
    end
  end
end
