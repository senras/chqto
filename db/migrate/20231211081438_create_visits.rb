class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.datetime :access_date
      t.string :ip_address
      t.references :link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
