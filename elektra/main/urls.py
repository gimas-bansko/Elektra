from django.urls import path
from . import views
urlpatterns = [
    path('', views.dzi_home, name='home'),
    path('signin', views.LoginUser.as_view(), name='login'),
    path('signup', views.signup, name='register'),
    path('dzi_home', views.dzi_home, name='dzi'),
    path('contact', views.contact, name='contact'),
    path('privacy_policy', views.privacy_policy, name='privacy'),
    path('terms_policy', views.terms_policy, name='terms'),
]
