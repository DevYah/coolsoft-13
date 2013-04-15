require 'faker'
require 'factory_girl_rails'

FactoryGirl.define do
  factory :idea do |f|
    f.title 'idea1'
    f.description 'description of idea 1'
    f.problem_solved 'problem solved of idea 1'
  end
  
  factory :invalid_idea, parent: :idea do |f|
    f.title nil
  end
<<<<<<< HEAD
end


=======
end
>>>>>>> C3_dayna161193_#83_likeComments
