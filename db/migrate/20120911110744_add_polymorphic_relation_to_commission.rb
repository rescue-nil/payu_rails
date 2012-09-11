class AddPolymorphicRelationToCommission < ActiveRecord::Migration
  def change
    add_column :payu_rails_commissions, :entity_type, :string
    add_column :payu_rails_commissions, :entity_id, :integer
  end
end
