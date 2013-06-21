class CreateFacebookPages < ActiveRecord::Migration
  def change
    create_table :facebook_pages, force: true do |t|
      t.integer :fb_id
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
