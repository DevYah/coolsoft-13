from django.db import models
from django.contrib.auth.models import User
#~ from registration.models import User 

class Contact(models.Model):

	name = models.CharField(max_length=50)
	email = models.CharField(max_length=100)
	number = models.CharField(max_length=10)
	address = models.CharField(max_length=200)
	user = models.ForeignKey(User)
	
	def __unicode__(self):
		return self.name
	
class Field(models.Model):
	
	field_name = models.CharField(max_length=50)
	contact = models.ForeignKey(Contact)
	
	def __unicode__(self):
		return self.field_name
	


