class CreateTrends < ActiveRecord::Migration
  def change
    create_table :trends do |t|
      t.references :idea
      t.integer :trending
      t.integer :rounds
    end
  end
end
