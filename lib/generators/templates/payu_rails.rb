PayuRails.setup do |config|
  # Uncomment following lines and substitute XXXX with your credentials
  # You can find this data at: https://payu.pl/paygw/adm/index.jsp
  # unless Rails.env.production?
  #   config.pos_id                 = "XXXX"
  #   config.client_secret          = "XXXX"
  #   config.client_secret_symetric = "XXXX"
  #   config.pos_auth_key           = "XXXX"
  # else
  #   config.pos_id                 = "YYYY"
  #   config.client_secret          = "YYYY"
  #   config.client_secret_symetric = "YYYY"
  #   config.pos_auth_key           = "YYYY"
  # end
  # config.sandbox_environments     = [:development, :test, :staging]
  # config.notify_url              = ""
  # config.order_cancel_url        = ""
  # config.order_complete_url      = ""
end
