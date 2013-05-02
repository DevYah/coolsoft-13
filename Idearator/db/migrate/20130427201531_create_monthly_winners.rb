class CreateMonthlyWinners < ActiveRecord::Migration
  def change
    create_table :monthly_winners do |t|
      t.column :idea, :idea
      t.timestamps
    end
  end
end
