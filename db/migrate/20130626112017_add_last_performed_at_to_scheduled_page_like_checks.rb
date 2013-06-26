class AddLastPerformedAtToScheduledPageLikeChecks < ActiveRecord::Migration
  def change
    add_column :scheduled_page_like_checks, :last_performed_at, :datetime
  end
end
