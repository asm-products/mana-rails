class AddAccountManagerToClient < ActiveRecord::Migration
  def change
    add_reference :clients, :account_manager, index: true
  end
end
