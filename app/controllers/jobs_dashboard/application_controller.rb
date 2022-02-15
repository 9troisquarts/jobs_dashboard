require 'kaminari'
module JobsDashboard
  class ApplicationController < ActionController::Base
    before_action :set_locale

    private
      def set_locale
        I18n.locale = :fr
      end
  end
end
