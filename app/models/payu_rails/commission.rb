module PayuRails
  class Commission < ActiveRecord::Base
    attr_accessible :req_id, 
                    :status,
                    :entity_id,
                    :entity_type,
                    :entity

    before_create :setup_req_id

    belongs_to :entity, :polymorphic => true

    state_machine :status, :initial => :initialized do
      event :error! do
        transition any => :error
      end

      event :created! do
        transition any => :created
      end

      event :aborted! do
        transition any => :aborted
      end

      state :created
      state :error
      state :aborted
    end

    private
    def setup_req_id
      self.req_id ||= Utils::Crypth.uniq_token("#{Time.now.to_i}#{Kernel.rand(10000)}#{(0..2000).to_a.sample}") 
      self.session_id ||= self.req_id
    end
  end
end
