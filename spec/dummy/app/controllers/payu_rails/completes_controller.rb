module PayuRails
  class CompletesController < OrdersController
    layout 'application'
    include ::StepsExtension

    before_filter :set_page, :only => :new

    private
    def set_page
      set_current!(:third)
    end
  end
end
