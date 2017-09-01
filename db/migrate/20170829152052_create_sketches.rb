class CreateSketches < ActiveRecord::Migration[5.1]
  def change
    create_table :sketches do |t|
      t.string :data
      t.string :answer

      t.timestamps
    end
  end
end
