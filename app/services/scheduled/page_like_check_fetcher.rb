module Scheduled
  class PageLikeCheckFetcher
    def initialize(page_like_check)
      @page_like_check = page_like_check
    end

    def people_who_like
      @scrapper ||= Facebook::SimpleScrapper.new
      page = @scrapper.fetch_page(like_box_url)
      Rails.logger.debug("Fetching #{like_box_url}")

      page.parser.css("li._43q7").map do |profile_element|
        name = profile_element.at_css("a, span")["title"]
        profile_id = profile_id_from_img_url(profile_element.at_css("img")["src"])
        url_name = profile_element.at_css("a, span")["href"]
        {name: name, fb_id: profile_id, url_name: url_name}
      end
    end

    def create_profiles_and_connections
      people_who_like.each do |profile|
        profile = Facebook::Profile.where(fb_id: profile[:fb_id]).first_or_create(profile)
        profile.page_likes.first_or_create(page_id: @page_like_check.facebook_page_id)
      end
    end


    private

    def profile_id_from_img_url(image_url)
      # https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/371452_1451746189_1082105343_q.jpg
      match = image_url.match(/_(\d+)_\w\.jpg$/)
      if match
        match[1].to_i
      end
    end

    def like_box_url
      "https://www.facebook.com/plugins/fan.php?connections=100&id=#{@page_like_check.facebook_page.fb_id}"
    end
  end
end
