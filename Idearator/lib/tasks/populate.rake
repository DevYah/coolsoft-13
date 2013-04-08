namespace :db do
	desc "Fill Users and Ideas."
	task :populate => :environment do

		@tags = ["Agriculture", "Software", "Fashion", "Development", "Games" , "BigThings" , "SmallThings" , "CamelCase" , "Food" , "TakeAway"]
		50.times do |n|
			u = User.new
			u.email = Faker::Internet.email
			u.first_name = Faker::Name.name
			u.password = 123123123
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

		10.times do |n|
			t = Tag.new
			t.name = @tags.at(n).to_s
			t.save
		end


		50.times do |n|
			it = IdeasTags.new
			it.idea_id = n+1
			it.tag_id = rand(1..12)
			it.save
			it1 = IdeasTags.new
			it1.idea_id = n+1
			it1.tag_id = rand(1..12)
			it1.save
			it2 = IdeasTags.new
			it2.idea_id = n+1
			it2.tag_id = rand(1..12)
			it2.save
		end



	end	