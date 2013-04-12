###Users###
#Normal user
user = User.create(email: "hishamelkbeer@gmail.com", password: 123123123, first_name: "Hisham",
last_name: "ElGezeery", username: "geezo", about_me: "Lorem ipsum dolor sit
amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut 
labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud 
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
user.confirm!
user.save

#Admin User
admin = Admin.create(email: "hishameladmin@gmail.com", password: 123123123, first_name: "Hisham",
last_name: "ElGezeery", username: "geezoo", about_me: "Lorem ipsum dolor sit
amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut 
labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud 
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
admin.confirm!
admin.save

#Committe User
committee = Committee.create(email: "marwaelcommittee@gmail.com", password: 123123123, first_name: "Marwa",
last_name: "Mehanna", username: "marwabentmehanna", about_me: "Lorem ipsum dolor sit
amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut 
labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud 
exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
committee.confirm!

#-----------------------------------------------------------------------------------

### Ideas ###
#Idea by regular user, approved, not archived.
idea = Idea.create(title: 'This is the title of the first idea in the database',
description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat
nulla pariatur. Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum.",
problem_solved: 'here is the problem solved', num_votes: 16, approved: true)
idea.user = user 

#Idea by regular user, not approved, not archived.
idea2 = Idea.create(title: 'This is the title of the second idea in the database',
description: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor
in reprehenderit in voluptate velit esse cillum dolore eu fugiat
nulla pariatur. Excepteur sint occaecat cupidatat non proident,
sunt in culpa qui officia deserunt mollit anim id est laborum.",
problem_solved: 'here is the problem solved',approved: false)
idea2.user = user
#-----------------------------------------------------------------------------------

### Ideas Approved by Committee ###

idea.committee = committee

#-----------------------------------------------------------------------------------

### Tags ###

Tag.create(name: "Science")
Tag.create(name: "Astrology")

#-----------------------------------------------------------------------------------
### Assigning tags to the Committees ###
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
comment = Comment.create(content: "This is the comment")
comment.user = user
comment.idea = idea
comment.save








