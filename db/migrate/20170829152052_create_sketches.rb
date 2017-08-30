class CreateSketches < ActiveRecord::Migration[5.1]
  def change
    create_table :sketches do |t|
      t.belongs_to :users
      t.string :url
      t.string :answer

      t.timestamps
    end
  end
end
