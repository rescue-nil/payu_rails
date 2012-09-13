PayuRails.setup do |config|
  # # Uncomment following lines and substitute XXXX with your credentials
  # # You can find this data at: https://payu.pl/paygw/adm/index.jsp
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
  #
  # # Set sandbox environments.
  # config.sandbox_environments     = [:development, :test, :staging]
  #
  # # Choose between pl or en
  # config.payu_country             = :pl
  #
  # # Your app domain or static outside ip
  # config.app_domain               = "http://localhost:3000"
end
