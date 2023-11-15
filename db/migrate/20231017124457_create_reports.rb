class CreateReports < ActiveRecord::Migration[7.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.text :contents

      t.references :user
      t.timestamps
    end
  end
end
