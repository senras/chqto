class RenamePasswordToPasswordDigestInLinks < ActiveRecord::Migration[7.1]
  def change
    rename_column :links, :password, :password_digest
  end
end
