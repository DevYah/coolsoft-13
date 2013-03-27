class CommitteeController < ApplicationController
#.reject! iterates on every element in a list and removes every element that accepts the following condition
# the & is used to generate a list having the commen values of the two lists
    def review_ideas 
	@committee=current_user
	@ideas=Idea.find(:all, :conditions =>{:approved => false})
        @ideas.reject! do |i|
            (i.tags & @committee.tags).empty?         
	end
    end
end
