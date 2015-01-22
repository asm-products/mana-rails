class UpdateShortCodeInClients < ActiveRecord::Migration
  def change
    remove_index :clients, :short_code
    add_index :clients, :short_code
  end
end
