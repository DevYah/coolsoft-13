class CreateInvitedPeople < ActiveRecord::Migration
  def change
    create_table :invited_people do |t|
      t.string :email
      t.boolean :admin
      t.boolean :committee

      t.timestamps
    end
  end
end
