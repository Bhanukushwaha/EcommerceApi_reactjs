class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :firstname
      t.string :last_name
      t.string :roll_number
      t.string :district
      t.string :branch
      t.boolean :active

      t.timestamps
    end
  end
end
