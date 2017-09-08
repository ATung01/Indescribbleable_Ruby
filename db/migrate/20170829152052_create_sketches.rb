class CreateSketches < ActiveRecord::Migration[5.1]
  def change
    create_table :sketches do |t|
      t.string :data
      t.string :room_code
      t.belongs_to :match

      t.timestamps
    end
  end
end
