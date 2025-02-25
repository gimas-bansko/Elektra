from contextlib import nullcontext

from django.contrib.auth.views import LoginView
from django.shortcuts import render, redirect, get_object_or_404
from .forms import LoginUserForm
from django.urls import reverse_lazy
from django.contrib.auth import logout
from .models import *
from rest_framework.views import APIView
from rest_framework.response import Response
from .serializers import *
from django.http import JsonResponse

from django.db import transaction
# from django.views.decorators.csrf import csrf_exempt

import requests

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

def user_context(request, title, show_th=False):
    user = request.user
    user_profile = user.userprofile

#    schools = School.objects.all()

    context = {
        'tab_title': title,
        'user_nick': user.username,
        'user_name': user.first_name+' '+user.last_name,
        'user_first_name': user.first_name,
        'user_level': USER_LEVEL[user_profile.access_level-1][1],
        'user_profile': user_profile,
        'show_theme': show_th,
        #        'schools': schools,
#        'specialities': user_profile.school.specialities.all(),
    }
    return context

def dzi_test(request):
    return render(request, 'main/dzi_test.html', user_context(request,'въпроси'))

def dzi_test_online_start(request):
    return render(request, 'main/dzi_test_online_start.html', user_context(request,'въпроси'))

def dzi_test_online(request):
    return render(request, 'main/dzi_test_online.html', user_context(request,'въпроси'))


def dzi_tasks(request):
    return render(request, 'main/dzi_tasks.html', user_context(request,'въпроси', show_th=True))

def dzi_users(request):
    context = user_context(request, 'потребители')
    context['tab_title'] = 'потребители'
    return render(request, 'main/dzi_users.html', context)

def dzi_sys(request):
    context = user_context(request, 'системни')
    context['tab_title'] = 'системни'
    return render(request, 'main/dzi_sys.html', context)

def dzi_settings(request):
    context = user_context(request, 'настройки')
    context['tab_title'] = 'настройки'
    return render(request, 'main/dzi_settings.html', context)

""" 
***************************************
               API
***************************************
"""
class UserDataAPIView(APIView):
    def get(self, request):
        user = request.user
        user_profile = user.userprofile
        context = {
            'user_nick': user.username,
            'user_name': user.first_name + ' ' + user.last_name,
            'user_level_text': USER_LEVEL[user_profile.access_level - 1][1],
            'user_level_num': user_profile.access_level,
            'school':  user_profile.school.id if user_profile.school else 0,
            'theme': user_profile.session_theme,
            'speciality': user_profile.speciality.id if user_profile.speciality else 0,
        }
        return Response(context)

def set_user_theme(request, theme_num):
    user = request.user
    user_profile = user.userprofile
    user_profile.session_theme = theme_num
    user_profile.save()
    return JsonResponse({
        'success': True,
        'message': f'Theme was changed to {theme_num}.'
    })

# ************************************************
#                 ВЪПРОСИ
# ************************************************

# Премахване на въпрос
class TaskDelTaskAPIView(APIView):
    def post(self, request):
        task_id = request.data['id']
        Task.objects.filter(id=task_id).delete()
        return Response(status=201)


# Премахване на опция към въпрос
class TaskDelItemAPIView(APIView):
    def post(self, request):
        for option in request.data['ids']:
            TaskItem.objects.filter(id=option).delete()
        return Response(status=201)


# Създаване на нов въпрос
class TaskNewQuestionBodyAPIView(APIView):
    def post(self, request):
        level = request.data['level']
        item = request.data['item']
        itm = ThemeItem.objects.filter(id=item).get()
        task = Task.objects.create_task(itm)
        task.level = level
        author_id = request.data['author']
        author = School.objects.get(id=author_id)
        task.author = author
        task.save()
        return Response(task.id)


# Въпрос - запазване на тялото на въпроса
class TaskSaveQuestionBodyAPIView(APIView):
    def post(self, request):
        data=request.data
        task = Task.objects.get(id=data['id'])

        # записвам контекста, ако има такъв
        if data['context']:
            context = TaskContext.objects.get(id=data['context']['id'])
            context.text = data['context']['text']
            context.textWrap = data['context']['textWrap']
            context.save()
            task.context=context
        else:
            task.context = None

        task.text = data['text']
        task.type_q = data['type']
        task.level_q = data['level']
        task.group = data['group']
        task.textWrap = data['textWrap']

        task.save()

        return Response(status=201)


# Въпрос - запазване на опциите на въпроса
class TaskSaveQuestionOptionsAPIView(APIView):
    def post(self, request, pk2, pk3):
        if pk2 == 0:  # вмъквам нова опция
            task_id = Task.objects.filter(id=pk3).get()
            option = TaskItem.objects.create_task(task_id)
            option.leading_char = request.data['leading_char']
            option.text = request.data['text']
            option.value = request.data['value']
            option.value_name = request.data['value_name']
            option.checked = request.data['checked']
            option.save()
        else:
            option = TaskSaveTaskOptionsSerializer(data=request.data)
            if option.is_valid():
                option.save()
            else:
                print('error validation: ', option.errors)

        return Response(status=201)


# Въпрос - обновяване на картинка за въпрос
class TaskFileAPIView(APIView):
    def post(self, request):
        data = TaskFileSerializer(data=request.data)
        if data.is_valid():
            data.save(id=request.data['id'])
        return Response(status=201)

class AddToGroup(APIView):
    def post(self, request):
        # Извличам task_id от заявката
        source_id = request.data['source_id']
        target_id = request.data['target_id']

        # Вземам съответните записи от Task
        source = Task.objects.get(id=source_id)
        target = Task.objects.get(id=target_id)

        # Определям № на групата
        if target.group == 0:
            target.group = target.id
            target.save()
            source.group = target.id
        else:
            source.group = target.group
        source.save()

        return Response(target.group)


def clear_group(request, task_id):
    task = Task.objects.get(id=task_id)
    task.group = 0
    task.save()
    return JsonResponse({'status': 'success'}, status=201)

# ***********************************************
def tests_by_theme(request, pk):
    theme = Theme.objects.get(id=pk)
    items = ThemeItem.objects.filter(theme_id=pk).order_by('item')
    themes = Theme.objects.all()
    context = {
        'state': 'collapsed',
        'theme': theme,
        'themes': themes,
        'items': items,
    }
    return render(request, 'diki/test.html', context)


class ThemeItemView(APIView):
    def get(self, request, pk):
        queryset = ThemeItem.objects.filter(theme_id=pk).order_by('item')
        serializer = ThemeItemSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)


class ThemeView(APIView):
    def get(self, request, pk):
        queryset = Theme.objects.filter(num=pk)
        serializer = ThemeSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)


class ThemeNumView(APIView):
    def get(self, request, spec):
        queryset = Theme.objects.filter(specialty=spec).order_by('num')
        serializer = ThemeNumSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)


class TestByUserView(APIView):
    def get(self, request):
        queryset = Test.objects.order_by('user_id')
        serializer = TestSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)


class TestByThemeView(APIView):
    def get(self, request):
        queryset = Test.objects.order_by('theme')
        serializer = TestSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)


"""
       *******************   TEST  ******************
"""


class SaveTestResults(APIView):
    def post(self, request):
        user = self.request.user
        user_id = user.id
        user_name = user.first_name + ' ' + user.last_name
        theme = request.data['theme']
        points = request.data['points']
        time = request.data['time']

        record = Test.objects.create()
        record.user_id = user_id
        record.user_name = user_name
        record.theme = theme
        record.points = points
        record.time = time
        record.save()

        return Response(status=201)


"""
       ******************* КОМЕНТАРИ ******************
"""
class AddRemark(APIView):
    def post(self, request):
        user = self.request.user
        user_id = user.id
        user_name = user.first_name + ' ' + user.last_name
        text = request.data['text']

        task_id = request.data['task_id']
        task = Task.objects.filter(id=task_id).get()

        record = Remark.objects.create()
        record.user_id = user_id
        record.user_name = user_name
        record.text = text
        record.task = task
        record.save()

        return Response(status=201)

class RemarksByTaskView(APIView):
    def get(self, request, task_id):
        queryset = Remark.objects.filter(task=task_id)
        serializer = RemarkSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)

"""
       ******************* КОНТЕКСТ ******************
"""
class NewContextView(APIView):
    def post(self, request):
        task_id = request.data['task_id']
        task = Task.objects.filter(id=task_id)

        context = TaskContext.objects.create()

        author_id = request.data['author']
        author = School.objects.get(id=author_id)
        context.author = author
        context.save()

        task = Task.objects.get(id=task_id)
        task.context = context
        task.save()

        queryset = TaskContext.objects.filter(id=context.id)
        serializer = TaskContextSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)

# Контекст - обновяване на картинка
class ContextFileAPIView(APIView):
    def post(self, request):
        data = ContextFileSerializer(data=request.data)
        if data.is_valid():
            data.save(id=request.data['id'])
        return Response(status=201)

"""
       *******************   LOG  ******************
"""
class SaveLogAction(APIView):
    def post(self, request):
        user = self.request.user
        user_id = user.id
        user_name = user.first_name + ' ' + user.last_name
        action = request.data['action']

        record = Log.objects.create()
        record.user_id = user_id
        record.user_name = user_name
        record.action = action
        record.save()

        return Response(status=201)

"""
       *******************   NEW  ******************
"""

# използва се/не се използва даден въпрос в дадено училище
def school_to_task_action(request, task_id, school_id, action):
    # Взимам задачата по task_id
    task = get_object_or_404(Task, id=task_id)
    # Взимам училището по school_id
    school = get_object_or_404(School, id=school_id)
    if action=='add':
        # Добавям училището към полето school на задачата
        act = 'added to'
        task.school.add(school)
    else:
        # Премахвам училището от полето school на задачата
        act = 'removed from'
        task.school.remove(school)

    # Връщам JSON отговор
    return JsonResponse({
        'success': True,
        'message': f'School with id {school_id} {act} Task with id {task_id}.'
    })

# дублиране на въпрос заедно с опциите
class DuplicateTask(APIView):
    def post(self, request):
        # Извличам task_id от заявката
        task_id = request.data['task_id']
        author_id = request.data['author_id']

        # Вземам оригиналния Task
        original_task = Task.objects.get(id=task_id)

        # Започвам транзакция
        new_id = 0
        school = get_object_or_404(School, id=author_id)
        with transaction.atomic():
            # Създавам копие на Task
            new_task = Task.objects.create(
                item=original_task.item,
                text=original_task.text,
                type=original_task.type,
                level=original_task.level,
                picture=original_task.picture,
                group=original_task.group,
                author=school,
                textWrap=original_task.textWrap,
            )

            # Копирам свързаните TaskItem записи
            task_items = TaskItem.objects.filter(task=original_task)
            for item in task_items:
                TaskItem.objects.create(
                    task=new_task,  # Свързвам с новия Task
                    leading_char=item.leading_char,
                    text=item.text,
                    value=item.value,
                    value_name=item.value_name,
                    checked=item.checked,
                    checked_t=item.checked_t,
                    value_t=item.value_t,
                )

                # Върнете JSON отговор с информация за новата задача
            new_id = new_task.id

        return Response(new_id)
