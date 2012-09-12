# This migration comes from payu_rails (originally 20120911110744)
class AddPolymorphicRelationToCommission < ActiveRecord::Migration
  def change
    add_column :payu_rails_commissions, :entity_type, :string
    add_column :payu_rails_commissions, :entity_id, :integer
  end
end
