class EditIdeaApprovedColumn < ActiveRecord::Migration
  def change
    change_column :committees, :approved, :integer, :default => 0
  end
end
