class Payment < ActiveRecord::Base
  # Needed by PayuRails engine
  has_many :commissions,
           :class_name => "PayuRails::Commission",
           :as => :entity
end
