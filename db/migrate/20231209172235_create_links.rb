class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.string :name
      t.string :slug
      t.date :expiration_date
      t.string :password
      t.boolean :accessed

      t.timestamps
    end
  end
end
