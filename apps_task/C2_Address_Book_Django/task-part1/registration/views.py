# Create your views here.

from django.shortcuts import render
from django.http import HttpResponse , HttpResponseRedirect
from django.contrib.auth import authenticate, login ,logout
from django.contrib.auth.models import User
from django.shortcuts import redirect
from django.core.urlresolvers import reverse

def index(request):
    return render(request,'registration/index.html',{})

def sign_up(request):
    return render(request,'registration/sign_up.html',{})

def log_in(request):
    return render(request,'registration/log_in.html',{})

def proceed(request):
    return render(request,'registration/proceed.html',{})

def redirection(request):
    return render(request,'registration/redirection.html',{})


def log_out(request):
    logout(request)
    return HttpResponseRedirect(reverse('registration:index'))

def  home(request):
    if not request.user.is_authenticated():
        return HttpResponseRedirect(reverse('registration:index'))
    return render(request,'registration/home.html',{})


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
        return HttpResponseRedirect(reverse('registration:proceed'))

def enter(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(username=username, password=password)
    if user is not None:
        if user.is_active:
            login(request, user)
            return HttpResponseRedirect(reverse('registration:redirection'))
        else:
            return HttpResponse('error')
    else:
        return HttpResponse('you failed')