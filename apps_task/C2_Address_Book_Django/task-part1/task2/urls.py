from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
	url(r'^', include('registration.urls', namespace ="registration")),
    #url(r'^contacts/$', include('contacts.urls', namespace ="contacts")),
    # Examples:
    # url(r'^$', 'task2.views.home', name='home'),
    # url(r'^task2/', include('task2.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    # url(r'^admin/', include(admin.site.urls)),
)
