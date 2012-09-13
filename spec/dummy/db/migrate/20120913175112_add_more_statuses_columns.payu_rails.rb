# This migration comes from payu_rails (originally 20120913144238)
class AddMoreStatusesColumns < ActiveRecord::Migration
  def up
    rename_column :payu_rails_commissions, :status, :order_status
    add_column :payu_rails_commissions, :payment_status, :string
  end

  def down
    rename_column :payu_rails_commissions, :order_status, :status
    remove_column :payu_rails_commissions, :payment_status
  end
end
