# PayuRails

Implementation PayU API for rails applications. 
For more please visit [payu page](http://www.payu.pl/).

Engine is still under development. Please *don't use it in production!*
This project rocks and uses MIT-LICENSE.

## Instalation
1. Use generator for install required files:

    ```
    rails g payu_rails:install
    ```

2. Fill client shop credentials in file: `config/initializers/payu_rails.rb`

3. Run migrations:

    ```
    rake db:migrate
    ```

4. Add line to one of your main model responsible for payment:

    ```ruby
    has_many :commissions,
             :class_name => "PayuRails::Commission",
             :as => :entity
    ```

5. Implement adapters at: `app/models/payu_rails/adapters/*`

6. Overwrite views at: `app/views/payu_rails/*`

7. Implement one controller as in example for initialize payu order:

    ```ruby
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
    ```

8. Test it in sandbox mode

For more see example at `spec/dummy`

## Helper methods

```ruby
= payu_link url, *args
= payu_login_link commission, :image => true
```

## TODO
- shipping costs feature - material order type
- tests
- refractor connection classes
