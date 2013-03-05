from django.db import models
#~ from registration.models import User 


class User(models.Model):

	user_name = models.CharField(max_length=20)
	
	def add (name, email, number, address):
		self.contact_set.create(name=name, email=email, number=number, address=address)
	
	#~ def edit(name, email, number, address)

class Contact(models.Model):

	name = models.CharField(max_length=50)
	email = models.CharField(max_length=100)
	number = models.CharField(max_length=10)
	address = models.CharField(max_length=200)
	user = models.ForeignKey(User)
	
	def __unicode__(self):
		return self.name
	

