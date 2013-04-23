namespace :db do

  desc "Fill Users and Ideas."
  task :populate => :environment do

    @tags = ["Agriculture", "Software", "Fashion", "Development", "Games" , "BigThings" , "SmallThings" , "CamelCase" , "Food" , "TakeAway"]

		40.times do |n|
			u = User.new
			u.email = Faker::Internet.email
			u.username = Faker::Name.name
			u.password = 123123123
			u.confirm!
			u.save
		end

		10.times do |n|
			c = Committee.new
			c.email = Faker::Internet.email
			c.username = Faker::Name.name
			c.password = 123123123
			c.confirm!
			c.save
		end

		50.times do |n|
			i = Idea.new
			i.user_id = rand(1..50)
			i.title = Faker::Name.name
			i.description = Faker::Lorem.paragraph
			i.problem_solved = Faker::Lorem.paragraph
			i.approved = "true"
			i.committee = Committee.find(rand(41..50))
			i.num_votes = rand(1..500)
			i.save
			v = VoteCount.new
			v.idea = i
			v.prev_day_votes = rand (0..40)
			v.save
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

		t = Threshold.new
		t.threshold = 40
		t.save

	end

end
