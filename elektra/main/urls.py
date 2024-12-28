from django.urls import path
from . import views
urlpatterns = [
    path('', views.dzi_home, name='home'),
    path('signin', views.signin, name='login'),
    path('signup', views.signup, name='register'),
    path('dzi_home', views.dzi_home, name='dzi'),
]
