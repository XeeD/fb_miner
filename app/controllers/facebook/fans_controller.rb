module Facebook
  class FansController < ApplicationController
    def index
      @fans = facebook_page.fans
    end


    private

    def facebook_page
      @facebook_page ||= Page.find(params[:page_id])
    end

    helper_method :facebook_page
  end
end
