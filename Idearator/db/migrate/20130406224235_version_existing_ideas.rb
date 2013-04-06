class VersionExistingIdeas < ActiveRecord::Migration
  # This is not strictly a migration, but it is necessary to update ideas that have not been versioned
  # to become versioned. It updates the updated_time attribute in the idea, which then becomes a version
  # in the versions table.
  def up
    say_with_time 'Setting initial version for ideas' do
      Idea.find_each(&:touch)
    end
  end

  def down
  end
end
