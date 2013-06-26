module Scheduled
  class PageLikeChecksController < ApplicationController
    def create
      @page_like_check = PageLikeCheck.new(scheduled_page_like_check_params)
      if @page_like_check.save
        PageLikeCheckWorker.perform_async(@page_like_check.id)
        redirect_to :back
      else
        render action: "new"
      end
    end

    def destroy
      PageLikeCheck.
          find(params[:id]).
          destroy

      redirect_to :back, notice: "Scheduled page like check was deleted"
    end


    private

    def scheduled_page_like_check_params
      params.require(:scheduled_page_like_check).permit(:facebook_page_id, :via, :attempts, :wait_between_requests)
    end
  end
end
