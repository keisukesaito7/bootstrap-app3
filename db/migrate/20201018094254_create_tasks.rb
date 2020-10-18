class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.text :content, null: false
      t.timestamps
    end
  end
end
