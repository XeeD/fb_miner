class Facebook::Page < ActiveRecord::Base
  has_many :scheduled_page_like_checks,
           class_name: 'Scheduled::PageLikeCheck',
           foreign_key: :facebook_page_id

  has_many :likes,
           class_name: "Facebook::PageLike"

  has_many :fans,
           through: :likes,
           source: :profile,
           class_name: "Facebook::Profile"

  validates_presence_of :url

  before_save :fetch_facebook_data

  private

  def fetch_facebook_data
    fan_page_fetcher = Facebook::FanPageFetcher.new(self)
    self.fb_id ||= fan_page_fetcher.fb_id
    self.name = fan_page_fetcher.name if name.blank?
    fan_page_fetcher.finished
  end
end
