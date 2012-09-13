module PayuRails
  class Commission < ActiveRecord::Base
    ORDER_STATUSES = Utils::Mappings::ORDER_STATUSES.values.map{|m| m.gsub("ORDER_STATUS_", "").downcase.to_sym} 
    PAYMENT_STATUSES = Utils::Mappings::PAYMENT_STATUSES.values.map{|m| m.gsub("PAYMENT_STATUS_", "").downcase.to_sym} 

    attr_accessible :req_id, 
                    :order_status,
                    :payment_status,
                    :entity_id,
                    :entity_type,
                    :entity

    before_create :setup_req_id_and_session_id

    belongs_to :entity, :polymorphic => true

    state_machine :order_status, :initial => :order_new do
      ORDER_STATUSES.each do |s|
        st = "order_#{s}".to_sym
        event "#{st}!" do
          transition any => st
        end
        
        state st
      end
    end

    state_machine :payment_status, :initial => :payment_new do
      PAYMENT_STATUSES.each do |s|
        st = "payment_#{s}".to_sym
        event "#{st}!" do
          transition any => st
        end

        state st
      end
    end

    private
    def setup_req_id_and_session_id
      random_string = "#{Time.now.to_i}#{Kernel.rand(10000)}"
      self.req_id     ||= Utils::Crypth.uniq_token("#{random_string}#{(0..2000).to_a.sample}") 
      self.session_id ||= Utils::Crypth.uniq_token("#{random_string}#{(0..2000).to_a.sample}") 
    end
  end
end
