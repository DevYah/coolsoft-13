from django.conf.urls import patterns, include, url

from addressBook import views

urlpatterns = patterns('',
    url(r'^$', views.index, name='index'),
    url(r'^sign_up/$', views.sign_up, name='sign_up'),
    url(r'^register/$', views.register, name='register'),
    url(r'^log_in/$', views.log_in, name='log_in'),
    url(r'^enter/$', views.enter, name='enter'),
    url(r'^home/$', views.home, name='home'),
    url(r'^log_out/$', views.log_out, name='log_out'),
    url(r'^proceed/$', views.proceed, name='proceed'),
    url(r'^redirection/$', views.redirection, name='redirection'),
    url(r'^contacts/$', views.contacts, name='contacts'),
	url(r'^(?P<contact_id>\d+)/detail/$', views.detail, name='detail'),
	url(r'^add/$', views.add, name='add'),
	url(r'^addContact/$', views.addContact, name='addContact'),
	url(r'^(?P<contact_id>\d+)/edit/$', views.edit, name='edit'),
	url(r'^(?P<contact_id>\d+)/editContact/$', views.editContact, name='editContact'),
	url(r'^(?P<contact_id>\d+)/delete/$', views.delete, name='delete'),
	url(r'^(?P<contact_id>\d+)/deleteField/$', views.deleteField, name='deleteField'),
)
