class AddDueDateToTask < ActiveRecord::Migration
  def change
    create_table :tasks do |table|
      table.string :title
      table.text :description
      table.timestamp :due_date
    end
  end
end
