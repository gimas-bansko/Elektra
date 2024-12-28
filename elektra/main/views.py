from django.contrib.auth.views import LoginView
from django.shortcuts import render, redirect
from .forms import LoginUserForm
from django.urls import reverse_lazy
from django.contrib.auth import logout
from .models import *


def index(request):
    return render(request, 'main/index.html')

def signin(request):
    return render(request, 'main/signin.html')

class LoginUser(DataMixin, LoginView):
    form_class = LoginUserForm
    template_name = 'main/signin.html'

    def get_context_data(self, *, object_list=None, **kwargs):
        context = super().get_context_data(**kwargs)
        c_def = self.get_user_context(title="ВХОД")
        return dict(list(context.items())+list(c_def.items()))

    def get_success_url(self):
        user = self.request.user
        if user.is_active:
            user = self.request.user
            record = Log.objects.create()
            record.user_id = user.id
            record.user_name = user.first_name + ' ' + user.last_name
            record.action = 'ВЛИЗАНЕ В ПЛАТФОРМАТА'
            record.save()

            return reverse_lazy('dzi')
        else:
            reverse_lazy_addr = 'register'
            return reverse_lazy('login')


def logout_user(request):
    logout(request)
    return redirect('dzi')


def signup(request):
    return render(request, 'main/signup.html')

def dzi_home(request):
    return render(request, 'main/dzi_splash.html')

def privacy_policy(request):
    return render(request, 'main/privacy-policy.html')

def terms_policy(request):
    return render(request, 'main/terms-policy.html')

def contact(request):
    return render(request, 'main/contact.html')

