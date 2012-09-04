class CreatePayuRailsCommissions < ActiveRecord::Migration
  def change
    create_table :payu_rails_commissions do |t|
      t.string :req_id
      t.string :status

      t.timestamps
    end
  end
end
