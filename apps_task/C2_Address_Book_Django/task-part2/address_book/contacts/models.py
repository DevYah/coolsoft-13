from django.db import models
#~ from registration.models import User 


class User(models.Model):

	user_name = models.CharField(max_length=20)
	
	def __unicode__(self):
		return self.user_name
	
	#~ def edit(name, email, number, address)

class Contact(models.Model):

	name = models.CharField(max_length=50)
	email = models.CharField(max_length=100)
	number = models.CharField(max_length=10)
	address = models.CharField(max_length=200)
	user = models.ForeignKey(User)
	
	def __unicode__(self):
		return self.name
	

