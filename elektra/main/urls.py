from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.dzi_home, name='home'),
    path('signin', views.LoginUser.as_view(), name='login'),
    path('signup', views.signup, name='register'),
    path('logout', views.logout_user, name='logout'),
    path('dzi', views.dzi_home, name='dzi'),
    path('contact', views.contact, name='contact'),
    path('privacy_policy', views.privacy_policy, name='privacy'),
    path('terms_policy', views.terms_policy, name='terms'),

    path('dzi_dashboard', views.dzi_dashboard, name='dzi_home'),
    path('dzi_tests', views.dzi_test, name='dzi_tests'),
    path('dzi_tests_online_start', views.dzi_test_online_start, name='start_test'),
    path('dzi_tests_online', views.dzi_test_online, name='test'),
    path('dzi_tasks', views.dzi_tasks, name='dzi_tasks'),
    path('dzi_users', views.dzi_users, name='dzi_users'),
    path('dzi_sys', views.dzi_sys, name='dzi_sys'),
    path('dzi_settings', views.dzi_settings, name='dzi_settings'),

    path('api-auth/', include('rest_framework.urls'))
]
