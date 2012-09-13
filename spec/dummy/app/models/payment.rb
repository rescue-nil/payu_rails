class Payment < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :commissions,
           :class_name => "PayuRails::Commission",
           :as => :entity
end
