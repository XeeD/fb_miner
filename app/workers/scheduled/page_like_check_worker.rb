module Scheduled
  class PageLikeCheckWorker
    include Sidekiq::Worker

    def perform(page_like_check_id)
      @page_like_check = PageLikeCheck.find(page_like_check_id)
      fetch_likes
      @page_like_check.update_attributes(
          last_performed_at: Time::now,
          remaining_attempts: @page_like_check.remaining_attempts - 1
      )

      if @page_like_check.remaining_attempts > 0
        self.class.perform_async(page_like_check_id)
      end

    rescue ActiveRecord::RecordNotFound => exception
      logger.warn "Scheduled::PageLikeCheck with ID #{page_like_check_id} not found"
      logger.warn exception
    end


    private

    def fetch_likes
      PageLikeCheckFetcher.new(@page_like_check).create_profiles_and_connections
    end
  end
end
