class CreateScheduledPageLikeChecks < ActiveRecord::Migration
  def change
    create_table :scheduled_page_like_checks do |t|
      t.string :via, null: false
      t.integer :attempts, null: false
      t.integer :remaining_attempts, null: false
      t.integer :wait_between_requests, null: false
      t.belongs_to :facebook_page, null: false

      t.timestamps
    end

    add_index :scheduled_page_like_checks, :facebook_page_id
  end
end
