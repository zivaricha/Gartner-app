class AddFieldsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :summery, :text
    add_column :profiles, :skills, :string
    add_column :profiles, :experience, :string
    add_column :profiles, :education, :string
  end
end
