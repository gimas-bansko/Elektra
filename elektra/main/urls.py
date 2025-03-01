from django.urls import path, include
from . import views
from . import convert

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

    # ***************** API *********************
    path('api/theme_nums/<int:spec>/', views.ThemeNumView.as_view()),
    path('api/set_user_theme/<int:theme_num>/', views.set_user_theme),
    path('api/theme/<int:pk>/', views.ThemeView.as_view()),
    path('api/remarks/<int:task_id>/', views.RemarksByTaskView.as_view()),
    path('api/theme_items/<int:pk>/', views.ThemeItemView.as_view()),
    path('api/context/', views.UserDataAPIView.as_view()),
    path('api/group/', views.AddToGroup.as_view()),
    path('api/clear_group/<int:task_id>/', views.clear_group),

    path('api/NewContext/', views.NewContextView.as_view()),
    path('api/ContextFile/', views.ContextFileAPIView.as_view()),
    path('api/TaskFile/', views.TaskFileAPIView.as_view()),
    path('api/TaskDelItem/', views.TaskDelItemAPIView.as_view()),
    path('api/TaskDelete/', views.TaskDelTaskAPIView.as_view()),
    path('api/TaskSaveQuestionBody/', views.TaskSaveQuestionBodyAPIView.as_view()),
    path('api/TaskSaveQuestionOption/<int:pk2>/<int:pk3>/', views.TaskSaveQuestionOptionsAPIView.as_view()),
    path('api/TaskNewQuestionBody/', views.TaskNewQuestionBodyAPIView.as_view()),
    path('api/SaveTestResult/', views.SaveTestResults.as_view()),
    path('api/TestStatisticByUser/', views.TestByUserView.as_view()),
    path('api/TestStatisticByTheme/', views.TestByThemeView.as_view()),
    path('api/SaveLogRecord/', views.SaveLogAction.as_view()),
    path('api/AddRemark/', views.AddRemark.as_view()),
    path('api/DuplicateTaskRecord/', views.DuplicateTask.as_view()),
    path('api/school-to-task-action/<int:task_id>/<int:school_id>/<str:action>/', views.school_to_task_action, name='add_school_to_task'),
    # transfer
    path('api/transfer/<int:theme>/', convert.TransferData.as_view()),
    # AI
    path("api/check-answer/", views.CheckAnswer.as_view()),
]
