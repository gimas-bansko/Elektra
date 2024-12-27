from django.urls import path
from . import views
urlpatterns = [
    path('', views.index, name='home'),
    path('signin', views.signin, name='login'),
    path('signup', views.signup, name='register'),
]
