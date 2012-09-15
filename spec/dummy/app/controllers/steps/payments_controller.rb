class Steps::PaymentsController < ApplicationController
  include ::StepsExtension

  def index
    # Only renderer
    set_current!(:first)
  end
end
