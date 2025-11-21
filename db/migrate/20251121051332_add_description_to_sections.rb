class AddDescriptionToSections < ActiveRecord::Migration[7.1]
  def change
    add_column :sections, :description, :string
  end
end
