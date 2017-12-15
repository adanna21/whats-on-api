class CreateShows < ActiveRecord::Migration[5.1]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :trakt_id
      t.string :tvdb_id
      t.string :image_url
      t.belongs_to :user

      t.timestamps
    end
  end
end
