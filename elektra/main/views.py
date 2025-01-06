from django.contrib.auth.views import LoginView
from django.shortcuts import render, redirect
from .forms import LoginUserForm
from django.urls import reverse_lazy
from django.contrib.auth import logout
from .models import *


def index(request):
    return render(request, 'main/index.html')

def signin(request):
    context = {
        'tab_title': 'вход',
    }
    return render(request, 'main/signin.html', context)

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

            return reverse_lazy('dzi_home')
        else:
            return reverse_lazy('login')


def logout_user(request):
    logout(request)
    return redirect('dzi')

def signup(request):
    return render(request, 'main/signup.html')

def dzi_home(request):
    context = {
        'tab_title': 'начало',
    }
    return render(request, 'main/home_dzi.html', context)

def privacy_policy(request):
    return render(request, 'main/privacy-policy.html')

def terms_policy(request):
    return render(request, 'main/terms-policy.html')

def contact(request):
    return render(request, 'main/contact.html')

def dzi_dashboard(request):
    user = request.user
    user_profile = user.userprofile
    schools = School.objects.all()

    context = {
        'tab_title': 'начало',
        'user_nick': user.username,
        'user_name': user.first_name+' '+user.last_name,
        'user_first_name': user.first_name,
        'user_level': USER_LEVEL[user_profile.access_level-1][1],
        'user_profile': user_profile,
        'schools': schools,
        'specialities': user_profile.school.specialities.all(),
    }
    # return render(request, 'main/dashboard_dzi.html', context)
    return render(request, 'main/dzi_welcome.html', context)

def dzi_set_school(request, sc):
    user = request.user
    user_profile = user.userprofile
    if sc>0:
        new_school = School.objects.get(id=sc)
        user_profile.school = new_school
        user_profile.save()

    return dzi_dashboard(request)

def dzi_set_speciality(request, sp):
    user = request.user
    user_profile = user.userprofile
    if sp>0:
        new_spec = Specialty.objects.get(id=sp)
        user_profile.speciality = new_spec
        user_profile.save()

    return dzi_dashboard(request)

def dzi_test(request):
    context = {
        'tab_title': 'тест',
        'show_theme': True,
    }
    return render(request, 'main/dzi_test.html', context)

def dzi_test_online_start(request):
    context = {
        'tab_title': 'тест',
        'show_theme': True,
    }
    return render(request, 'main/dzi_test_online_start.html', context)

def dzi_test_online(request):
    context = {
        'tab_title': 'тест',
        'show_theme': True,
    }
    return render(request, 'main/dzi_test_online.html', context)

def dzi_tasks(request):
    user = request.user
    user_profile = user.userprofile
    schools = School.objects.all()

    context = {
        'tab_title': 'въпроси',
        'user_nick': user.username,
        'user_name': user.first_name+' '+user.last_name,
        'user_level': USER_LEVEL[user_profile.access_level-1][1],
        'user_profile': user_profile,
        'show_theme': True,
    }
    return render(request, 'main/dzi_tasks.html', context)

def dzi_users(request):
    context = {
        'tab_title': 'потребители',
    }
    return render(request, 'main/dzi_users.html', context)

def dzi_sys(request):
    context = {
        'tab_title': 'системни',
    }
    return render(request, 'main/dzi_sys.html', context)

def dzi_settings(request):
    context = {
        'tab_title': 'настройки',
    }
    return render(request, 'main/dzi_settings.html', context)

""" 
***************************************
            API
***************************************
"""
