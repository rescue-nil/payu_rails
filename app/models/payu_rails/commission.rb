module PayuRails
  class Commission < ActiveRecord::Base
    ####################
    # Constants with statuses
    ####################
    ORDER_STATUSES    = Utils::Mappings::ORDER_STATUSES.values.map{|m| m.gsub("STATUS_", "").downcase.to_sym} 
    PAYMENT_STATUSES  = Utils::Mappings::PAYMENT_STATUSES.values.map{|m| m.gsub("STATUS_", "").downcase.to_sym} 
    INVALID_STATES    = [:cancel, :reject, :init, :sent, :noauth, :reject_done, :error]

    ####################
    #### Attributes ####
    ####################
    attr_accessible :req_id, 
                    :order_status,
                    :payment_status,
                    :entity_id,
                    :entity_type,
                    :entity

    ####################
    #### Callbacks ####
    ####################
    before_create :setup_req_id_and_session_id

    ####################
    ### Associations ###
    ####################
    belongs_to :entity, :polymorphic => true

    ####################
    ### State machine ##
    ####################
    state_machine :order_status, :initial => :order_new do
      ORDER_STATUSES.each do |s|
        event "#{s}!" do
          transition any => s
        end
        
        state s
      end
    end

    state_machine :payment_status, :initial => :payment_new do
      PAYMENT_STATUSES.each do |s|
        event "#{s}!" do
          transition any => s
        end

        state s
      end
    end

    ####################
    # Instance Methods #
    ####################
    # True if current statuses are not critical
    def correct_statuses?
      [:order_status, :payment_status].each do |s|
        return false if Commission::INVALID_STATES.include?(self.send(s).gsub(/(.*\_)/, "").to_sym)
      end
      true
    end

    private
    # Setup with some random values res_id and session_id
    def setup_req_id_and_session_id
      random_string = "#{Time.now.to_i}#{Kernel.rand(10000)}"
      self.req_id     ||= Utils::Crypth.uniq_token("#{random_string}#{(0..2000).to_a.sample}") 
      self.session_id ||= Utils::Crypth.uniq_token("#{random_string}#{(0..2000).to_a.sample}") 
    end
  end
end
