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
    path('dzi_school_selected/<int:sc>/', views.dzi_set_school, name='set_school'),
    path('dzi_speciality_selected/<int:sp>/', views.dzi_set_speciality, name='set_speciality'),

    path('dzi_tests', views.dzi_test, name='dzi_tests'),
    path('dzi_tests_online_start', views.dzi_test_online_start, name='start_test'),
    path('dzi_tests_online', views.dzi_test_online, name='test'),

    path('dzi_tasks', views.dzi_tasks, name='dzi_tasks'),
    path('dzi_users', views.dzi_users, name='dzi_users'),
    path('dzi_sys', views.dzi_sys, name='dzi_sys'),
    path('dzi_settings', views.dzi_settings, name='dzi_settings'),

    path('api-auth/', include('rest_framework.urls')),

    path('api/theme_items/<int:pk>/', views.ThemeItemView.as_view()),
    path('api/TaskKnowledgeFile/', views.TaskFileAPIView.as_view()),
    path('api/TaskDelItem/', views.TaskDelItemAPIView.as_view()),
    path('api/TaskDelete/', views.TaskDelTaskAPIView.as_view()),
    path('api/TaskSaveQuestionBody/<int:pk>/', views.TaskSaveQuestionBodyAPIView.as_view()),
    path('api/TaskSaveQuestionOption/<int:pk1>/<int:pk2>/<int:pk3>/', views.TaskSaveQuestionOptionsAPIView.as_view()),
    path('api/TaskNewQuestionBody/', views.TaskNewQuestionBodyAPIView.as_view()),
    path('api/theme/<int:pk>/', views.ThemeView.as_view()),
    path('api/theme_nums/', views.ThemeNumView.as_view()),
    path('api/SaveTestResult/', views.SaveTestResults.as_view()),
    path('api/TestStatisticByUser/', views.TestByUserView.as_view()),
    path('api/TestStatisticByTheme/', views.TestByThemeView.as_view()),
    path('api/SaveLogRecord/', views.SaveLogAction.as_view()),

]
