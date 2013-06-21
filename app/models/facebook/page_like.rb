class Facebook::PageLike < ActiveRecord::Base
  belongs_to :profile
  belongs_to :page
end
