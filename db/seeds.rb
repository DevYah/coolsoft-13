###Users###
#Normal user
User.create(email: "hishamelkbeer@gmail.com", password: 123123123, first_name: "Hisham",
last_name: "ElGezeery", username: "geezo", about_me: "Lorem ipsum dolor sit
amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut 
labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud 
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
User.find(1).confirm!

#Admin User
Admin.create(email: "hishameladmin@gmail.com", password: 123123123, first_name: "Hisham",
last_name: "ElGezeery", username: "geezo", about_me: "Lorem ipsum dolor sit
amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut 
labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud 
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
Admin.find(:first).confirm!

#Committe User
Committee.create(email: "marwaelcommittee@gmail.com", password: 123123123, first_name: "Marwa",
last_name: "Mehanna", username: "marwabentmehanna", about_me: "Lorem ipsum dolor sit
amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut 
labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud 
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
Committee.find(:first).confirm!
#-----------------------------------------------------------------------------------

### Ideas ###
#Idea by regular user, approved, not archived.
Idea.create(title: 'This is the title of the first idea in the database',
description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat
nulla pariatur. Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum.",
problem_solved: 'here is the problem solved', num_votes: 16, approved: true)
idea = Idea.find(1)
user = User.find(1)
idea.user = user 
user.save
idea.save

#Idea by regular user, not approved, not archived.
Idea.create(title: 'This is the title of the second idea in the database',
description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat
nulla pariatur. Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum.",
problem_solved: 'here is the problem solved',approved: false)
idea2 = Idea.find(2)
idea2.user = user
idea2.save
#-----------------------------------------------------------------------------------

### Ideas Approved by Committee ###

idea.committee = Committee.find(:first)
idea.save 

#-----------------------------------------------------------------------------------

### Tags ###

Tag.create(name: "Science")
Tag.create(name: "Astrology")

#-----------------------------------------------------------------------------------
### Assigning tags to the Committees ###
committee = Committee.find(:first)
committee.tags << [Tag.find(1)]
committee.save

#-----------------------------------------------------------------------------------

### Assigning tags to the ideas ###

idea.tags << [Tag.find(1)]
idea2.tags << [Tag.find(2)]
idea.save
idea2.save

#-----------------------------------------------------------------------------------

### Creating Comments ### 
Comment.create(content: "This is the comment")
comment = Comment.find(1)
comment.user = user
comment.idea = idea
comment.save








