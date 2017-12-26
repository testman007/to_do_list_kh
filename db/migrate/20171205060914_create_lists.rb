class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :event
      t.date :duedate
      t.text :description
      t.boolean :is_done
      t.timestamps
    end
  end
end
