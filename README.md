# PayuRails

This project rocks and uses MIT-LICENSE.

## Instalation
Use generator for install required files:

    rails g payu_rails:install

Fill client shop credentials in file:

    config/initializers/payu_rails.rb

Run migrations:

    rake db:migrate

Add line to one of your main model responsible for payment:

    has_many :commissions,
             :class_name => "PayuRails::Commission",
             :as => :entity

Implement adapters at:

    app/models/payu_rails/adapters/*

Overwrite views at:

    app/views/payu_rails/*

Implement one controller as in example for initialize payu order:

  class Steps::InitializePaysController < ApplicationController
    def new 
      # We are creating new payment/cart object
      # or finding it from db
      @payment = Payment.create

      # We have to have implemented adapters for building valid xml file
      xml_builder = PayuRails::OrderBuilders::CreateRequest.new(@payment)
      xml = xml_builder.build

      # When xml is built we sent it to payu service
      @req = PayuRails::Connection::CreateOrderRequest.new(xml.to_xml)
      @req.execute
      @commission = @payment.commissions.find_by_req_id(xml_builder.commission.req_id)
    end
  end

For more see example at spec/dummy

## Helper methods
    = payu_link url, *args
    = payu_login_link commission, :image => true
