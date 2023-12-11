class ModifyLinksTable < ActiveRecord::Migration[7.1]
  def change
    change_column_default :links, :accessed, from: nil, to: false
    add_index :links, :slug, unique: true
    add_column :links, :link_type, :string
    add_column :links, :url, :string
  end
end
