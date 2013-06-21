class Scheduled::PageLikeChecksController < ApplicationController
  def create
    @scheduled_page_like_check = Scheduled::PageLikeCheck.new(scheduled_page_like_check_params)
    if @scheduled_page_like_check.save
      redirect_to :back
    else
      render action: "new"
    end
  end


  private

  def scheduled_page_like_check_params
    params.require(:scheduled_page_like_check).permit(:facebook_page_id, :via, :attempts, :wait_between_requests)
  end
end
