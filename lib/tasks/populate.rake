namespace :db do
	desc "Fill Users and Ideas."
	task :populate => :environment do

		50.times do |n|
			u = User.new
			u.email = Faker::Internet.email
			u.first_name = Faker::Name.name
			u.confirm!
			u.save
		end

		50.times do |n|
			i = Idea.new
			i.user_id = rand(1..40)
			i.title = Faker::Name.name
			i.description = Faker::Lorem.paragraph
			i.problem_solved = Faker::Lorem.paragraph
			i.approved = "true"
			i.num_votes = rand(1..500)
			i.save
		end
	end	
end