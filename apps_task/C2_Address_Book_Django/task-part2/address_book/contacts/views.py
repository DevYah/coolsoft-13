
from django.http import HttpResponse
from django.template import Context, loader

from contacts.models import User, Contact


def index(request, user_id):
	u = User.objects.get(pk=user_id)
	contact_list = u.contact_set.all().order_by("-name")
	template = loader.get_template('contacts/index.html')
	context = Context({
		'contact_list' : contact_list,
		})		
	return HttpResponse(template.render(context))
	
def detail(request, contact_id):
	return HttpResponse("To be Continued")

def add(request, user_id):
	return HttpResponse("To be Continued")
	#~ return HttpResponseRedirect(reverse(’contacts:index’, args=(u.id,)))
