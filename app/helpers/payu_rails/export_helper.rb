module PayuRails
  module ExportHelper
    def payu_link(path, *args)
      options = args.extract_options!
      link_to image_tag(asset_path("payu_rails/payu_button.png")), path, options
    end
  end
end
