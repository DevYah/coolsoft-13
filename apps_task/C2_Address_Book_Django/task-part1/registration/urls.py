from django.conf.urls import patterns, url

from registration import views

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
)