class Steps::PaymentsController < ApplicationController
  include ::StepsExtension
  def index
    # Only renderer
    # View should containg list of payments for your user
    set_current!(:first)
  end
end
