module PayuRails
  module ExportHelper
    # Return link with image with payu logo
    def payu_link(path, *args)
      options = args.extract_options!
      link_to image_tag(asset_path("payu_rails/payu_button.png")), path, options
    end

    # Form responsible for payu button and client login to system
    def payu_login_link(commission, *args)
      options         = args.extract_options!.symbolize_keys!
      payu_image      = options[:image_path] || asset_path("payu_rails/payu_button.png")

      form_tag Connection::OfficialPaths.user_auth_url, options.merge(:method => :get) do
        output = ""
        output += hidden_field_tag :redirect_uri, payu_rails.new_commission_access_token_url(commission)
        output += hidden_field_tag :response_type, :code
        output += hidden_field_tag :client_id, PayuRails.pos_id
        
        # Depending on value paramter we show an image or link with label value
        if options[:image]
          output += image_submit_tag(payu_image)
        else
          output += submit_tag "Next"
        end

        output.html_safe
      end
    end
  end
end
