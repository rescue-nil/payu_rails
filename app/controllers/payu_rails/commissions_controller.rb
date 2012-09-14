require_dependency "payu_rails/application_controller"

module PayuRails
  class CommissionsController < ApplicationController
    def index
      @commissions = Commission.all
    end
  
    def update
      @commission = Commission.find(params[:id])

      # Building xml for receive informations about order
      xml_builder = OrderBuilders::RetrieveRequest.new(@commission)
      xml = xml_builder.build

      # Sending and parsine result
      Connection::RetrieveOrderRequest.new(xml.to_xml).execute

      redirect_to commissions_path, :notice => "Request for updated was sent."
    end
  end
end
