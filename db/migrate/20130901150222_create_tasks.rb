class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :user, index: true, null: false
      t.string :description, null: false, default: ''
      t.boolean :archived, null: false, default: false
      t.boolean :completed, null: false, default: false
      t.date :due_date
      t.integer :priority, null: false, default: 0

      t.timestamps
    end
  end
end
