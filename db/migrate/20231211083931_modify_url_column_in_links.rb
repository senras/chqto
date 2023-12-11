class ModifyUrlColumnInLinks < ActiveRecord::Migration[7.1]
  def change
    change_column :links, :url, :string, null: false
  end
end
