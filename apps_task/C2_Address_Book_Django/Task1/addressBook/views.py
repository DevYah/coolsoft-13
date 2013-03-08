from django.shortcuts import render
from django.http import HttpResponse , HttpResponseRedirect
from django.contrib.auth import authenticate, login ,logout
from django.contrib.auth.models import User
from django.shortcuts import redirect
from django.core.urlresolvers import reverse
from django.template import Context, loader

from addressBook.models import Contact, Field

def index(request):
    return render(request,'addressBook/index.html',{})

def sign_up(request):
    return render(request,'addressBook/sign_up.html',{})

def log_in(request):
    return render(request,'addressBook/log_in.html',{})

def proceed(request):
    return render(request,'addressBook/proceed.html',{})

def redirection(request):
    return render(request,'addressBook/redirection.html',{})


def log_out(request):
    logout(request)
    return HttpResponseRedirect(reverse('addressBook:index'))

def  home(request):
    if not request.user.is_authenticated():
        return HttpResponseRedirect(reverse('addressBook:index'))
    return render(request,'addressBook/home.html',{})


def register(request):
    try:
        user_name = request.POST['name']
        user_password = request.POST['password']
        user_email = request.POST['email']
    except Exception as e:
        return HttpResponse(e.message + type(e)) 
    else:
        user = User.objects.create_user(user_name, user_email, user_password)
        user.save()
        return HttpResponseRedirect(reverse('addressBook:proceed'))

def enter(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            login(request, user)
            return HttpResponseRedirect(reverse('addressBook:redirection'))
        else:
            return HttpResponse('error')
    else:
        return HttpResponse('you failed')

def contacts(request):
	u = User.objects.get(pk=request.user.id)
	contact_list = u.contact_set.all().order_by("-name")
	template = loader.get_template('addressBook/contacts.html')
	context = Context({
		'contact_list' : contact_list,
		 })		
	return HttpResponse(template.render(context))
	
def detail(request, contact_id):
	contact = Contact.objects.get(pk=contact_id)
	field = None
	if not not contact.field_set.all():
		field = contact.field_set.all()[0]
	return render(request, 'addressBook/detail.html', {'contact' : contact, 'field' : field })
	
def delete(request, contact_id):
	Contact.objects.get(pk=contact_id).delete()
	return render(request, 'addressBook/home.html',{})

def deleteField(request, contact_id):
	Contact.objects.get(pk=contact_id).field_set.all()[0].delete()
	return render(request, 'addressBook/home.html',{})

def add(request):
	return render(request, 'addressBook/add.html',{})
	
def addContact(request):
	try:
		u = User.objects.get(pk=request.user.id)
		c_name= request.POST['name']
		c_email= request.POST['email']
		c_number= request.POST['number']
		c_address= request.POST['address']
		c_field = request.POST['field']
		c_value = request.POST['value']
			
	except Exception as e:
		return HttpResponse(e.message)
	else:
		if not c_field:
			u.contact_set.create(name=c_name, email=c_email, number=c_number, address=c_address)
			u.save()
		else:
			u.contact_set.create(name=c_name,email=c_email,number=c_number,address=c_address)
			u.save()
			Contact.objects.get(name=c_name).field_set.create(field_name=c_field, field_value=c_value)
		return HttpResponseRedirect(reverse('addressBook:contacts'))

def edit(request, contact_id):
	contact = Contact.objects.get(pk=contact_id)
	field = None
	if not not contact.field_set.all():
		field = contact.field_set.all()[0]
	return render(request, 'addressBook/edit.html', {'contact' : contact, 'field' : field})

def editContact(request, contact_id) : 
	try:
		c = Contact.objects.get(pk=contact_id)
		c_name= request.POST['name']
		c_email= request.POST['email']
		c_number= request.POST['number']
		c_address= request.POST['address']
		if not not request.POST['value']:
			c_value = request.POST['value']
			f = c.field_set.all()[0]
		
	except Exception as e:
		return HttpResponse(e.message)
	else:
		if not not c_value:
			f.field_value = c_value
			f.save()
		if not not c_name:
			c.name = c_name
		if not not c_email:
			c.email = c_email
		if not not c_number:
			c.number = c.number
		if not not c_address:
			c.address = c.address
		c.save()
		return HttpResponseRedirect(reverse('addressBook:contacts'))

