class CreateFacebookProfiles < ActiveRecord::Migration
  def change
    create_table :facebook_profiles do |t|
      t.string :name
      t.integer :fb_id
      t.string :url_name

      t.timestamps
    end

    add_index :facebook_profiles, :fb_id, unique: true
    add_index :facebook_profiles, :name
  end
end
