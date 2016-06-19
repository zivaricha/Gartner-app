class AddUrlToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :profile_url, :string
  end
end
