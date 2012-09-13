module PayuRails
  class Commission < ActiveRecord::Base
    attr_accessible :req_id, 
                    :status,
                    :entity_id,
                    :entity_type,
                    :entity

    before_create :setup_req_id_and_session_id

    belongs_to :entity, :polymorphic => true

    state_machine :order_status, :initial => :new do
      state :pending
      state :cancel
      state :rejecte
      state :complete
      state :sent
    end

    state_machine :payment_status, :initial => :new do
      event
      state :cancel
      state :rejecte
      state :init
      state :sent
      state :noauth
      state :reject_done
      state :end
      state :error
    end

    private
    def setup_req_id_and_session_id
      random_string = "#{Time.now.to_i}#{Kernel.rand(10000)}"
      self.req_id     ||= Utils::Crypth.uniq_token("#{random_string}#{(0..2000).to_a.sample}") 
      self.session_id ||= Utils::Crypth.uniq_token("#{random_string}#{(0..2000).to_a.sample}") 
    end
  end
end
