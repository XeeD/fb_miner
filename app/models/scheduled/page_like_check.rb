class Scheduled::PageLikeCheck < ActiveRecord::Base
  belongs_to :facebook_page, class_name: 'Facebook::Page'

  before_create :reset_remaining_attempts

  def reset_remaining_attempts
    self.remaining_attempts = self.attempts
  end
end
