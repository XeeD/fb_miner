module Facebook
  class PageLikeCheckWorker
    include Sidekiq::Worker

    def perform(page_like_check_id)
      PageLikeCheck.find(page_like_check_id)
    end
  end
end
