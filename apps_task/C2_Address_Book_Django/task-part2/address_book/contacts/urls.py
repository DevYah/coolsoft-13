from django.conf.urls import patterns, url

from contacts import views

urlpatterns = patterns('',

	url(r'^(?P<user_id>\d+)/$', views.index, name='index'),
	url(r'^(?P<contact_id>\d+)/$', views.detail, name='detail'),
	#~ url(r'^(?P<user_id>\d+)/add/$', views.add, name='add'),
	#~ url(r'^(?P<contact_id>\d+)/edit/$', views.edit, name='edit'),
	#~ url(r'^(?P<contact_id>\d+)/delete/$', views.delete, name='delete'),
	
	)
