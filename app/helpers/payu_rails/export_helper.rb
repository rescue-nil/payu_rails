module PayuRails
  module ExportHelper
    def payu_link(path, *args)
      options = args.extract_options!
      link_to image_tag(asset_path("payu_rails/payu_button.png")), path, options
    end

    def payu_login_link_with_image(callback_before_summary, *args)
      options         = args.extract_options!.symbolize_keys!
      payu_image      = options[:image_path] || asset_path("payu_rails/payu_button.png")

      form_tag PayuRails.user_auth_url, options.merge(:method => :get) do
        output = ""
        output += hidden_field_tag :redirect_uri, callback_before_summary
        output += hidden_field_tag :response_type, :code
        output += hidden_field_tag :client_id, PayuRails.pos_id
        output += image_submit_tag(payu_image)
        output.html_safe
      end
    end

    def payu_login_link(callback_before_summary, *args)
      options         = args.extract_options!.symbolize_keys!

      form_tag PayuRails.user_auth_url, options.merge(:method => :get) do
        output = ""
        output += hidden_field_tag :redirect_uri, callback_before_summary
        output += hidden_field_tag :response_type, :code
        output += hidden_field_tag :client_id, PayuRails.pos_id
        output += submit_tag "Next"
        output.html_safe
      end
    end
  end
end
