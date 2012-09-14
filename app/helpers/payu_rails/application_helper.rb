module PayuRails
  module ApplicationHelper
    def correct_flash_class_for(key)
      key.to_sym == :notice ? :success : :error
    end
  end
end
