class Steps::InitializePaysController < ApplicationController
  include ::StepsExtension
  def new 
    # We are creating new payment/cart object
    # or finding it from db
    @payment = Payment.create

    # We have to have implemented adapters for building valid xml file
    xml_builder = PayuRails::OrderBuilders::CreateRequest.new(@payment)
    @xml = xml_builder.build

    # When xml is built we sent it to payu service
    @req = PayuRails::Connection::CreateOrderRequest.new(@xml.to_xml)
    @req.execute
    @commission = @payment.commissions.find_by_req_id(xml_builder.commission.req_id)

    set_current!(:second)
  end
end
