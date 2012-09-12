# This migration comes from payu_rails (originally 20120910105017)
class AddSessionIdToCommission < ActiveRecord::Migration
  def change
    add_column :payu_rails_commissions, :session_id, :string
  end
end
