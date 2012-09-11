class AddSessionIdToCommission < ActiveRecord::Migration
  def change
    add_column :payu_rails_commissions, :session_id, :string
  end
end
