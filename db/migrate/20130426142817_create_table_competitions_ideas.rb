class CreateTableCompetitionsIdeas < ActiveRecord::Migration
  def change
    create_table :competitions_ideas, :id => false do |t|
      t.references :competition
      t.references :idea
    end
  end
end