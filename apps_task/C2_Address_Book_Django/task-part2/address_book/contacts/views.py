
from django.http import HttpResponse
from django.template import Context, loader
from django.contrib.auth.models import User

from contacts.models import User, Contact


def index(request):
	u = User.objects.get(pk=request.user.id)
	contact_list = u.contact_set.all().order_by("-name")
	template = loader.get_template('contacts/index.html')
	context = Context({
		'contact_list' : contact_list,
		})		
	return HttpResponse(template.render(context))
	
def detail(request, contact_id):
	return HttpResponse("To be Continued")

def add(request):
	u = User.objects.get(pk=request.user.id)
	c_name = request.POST['contact_name']
	c_email = request.POST['contact_email']
	c_number = request.POST['contact_number']
	c_address = request.POST['contact_address']
	u.contact_set.create(c_name, c_email, c_number, c_address)
	u.save()
	return HttpResponseRedirect('contacts/index')

