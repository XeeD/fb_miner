class Facebook::Profile < ActiveRecord::Base
  has_many :page_likes
  has_many :pages, through: :page_likes

  def url
    url_name
  end
end
