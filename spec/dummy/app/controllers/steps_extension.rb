# Module needed for setting up current sub menu in views
module StepsExtension
  def self.included(base)
    base.class_eval do
      @@steps = {:first => false, :second => false, :third => false}

      before_filter :deactivate_all!

      protected
      def deactivate_all!
        @@steps.each_key do |k|
          @@steps[k] = false
        end
      end

      def set_current!(key)
        @@steps[key] = true
      end

      def current_step?(key)
        !!(@@steps[key] == true)
      end

      def all_steps
        @@steps
      end

      helper_method :all_steps, :current_step?
    end
  end
end
