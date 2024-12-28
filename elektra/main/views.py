from django.shortcuts import render
from django.http import HttpResponse


def index(request):
    return render(request, 'main/index.html')

def signin(request):
    return render(request, 'main/signin.html')

def signup(request):
    return render(request, 'main/signup.html')

def dzi_home(request):
    return render(request, 'main/dzi_splash.html')

def terms_and_conditions(request):
    return render(request, 'main/dzi_splash.html')

def dzi_home(request):
    return render(request, 'main/dzi_splash.html')

def dzi_home(request):
    return render(request, 'main/dzi_splash.html')

