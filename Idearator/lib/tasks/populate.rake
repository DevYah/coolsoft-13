namespace :populate do

	desc "Task description"
	task populate: :environment do
		60.times do |n|
			u = Idea.new
			u.user_id = 1
			u.title = u.description = u.problem_solved = Faker::Name.name
			u.approved = "true"
			u.num_votes = rand(1..500)
			u.save

		end	
		
	end
	
end