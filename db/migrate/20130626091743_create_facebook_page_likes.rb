class CreateFacebookPageLikes < ActiveRecord::Migration
  def change
    create_table :facebook_page_likes do |t|
      t.belongs_to :page
      t.belongs_to :profile

      t.timestamps
    end

    add_index :facebook_page_likes, :page_id
    add_index :facebook_page_likes, :profile_id
    add_index :facebook_page_likes, [:profile_id, :page_id], unique: true, name: "page_and_profile_unique"
  end
end
