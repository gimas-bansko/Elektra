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
from django.core.files.base import ContentFile

from django.db import transaction
# from django.views.decorators.csrf import csrf_exempt

import requests
class Transfer:
    def __init__(self, theme):
        self.theme_num = theme
        self.theme_id = 0
        self.list_of_themes = []
        self.spec = 0
        self.school = 0
        self.groups = {}

    # от старото API по номер на тема получавам id на темата в БД
    def get_theme_id(self):
        try:
            response = requests.get(f'https://pgeebansko.org/diki/api/theme/{self.theme_num}/')
            response.raise_for_status()  # Проверка за грешки
            self.theme_id = response.json()[0]['id']

            return True
        except requests.exceptions.RequestException as e:
            return False

    # от старото API по id на темата в БД тегля всички въпроси за нея
    def get_theme_items(self):
        try:
            response = requests.get(f'https://pgeebansko.org/diki/api/theme_items/{self.theme_id}/')
            response.raise_for_status()  # Проверка за грешки
            self.list_of_themes = response.json()
            return True
        except requests.exceptions.RequestException as e:
            return False

    # задавам параметрите, касаещи текущия потребителновата
    def set_user_params(self,request):
        user = request.user
        user_profile = user.userprofile
        print(user_profile)
        self.spec = user_profile.speciality
        self.school = user_profile.school

    # задавам параметрите, касаещи текущaта точка от темата
    def set_item_params(self, num):
        theme = Theme.objects.get(num=self.theme_num, specialty=self.spec)
        self.new_theme_item = ThemeItem.objects.get(theme_id=theme.id, item=num)
        print(self.new_theme_item)

    # определям № на група в новата система според номера на група в старата
    def make_group_number(self, self_id, old_group):
        if old_group == 0:
            return 0
        else:
            if old_group in self.groups:
                return self.groups[old_group]
            else:
                self.groups[old_group] = self_id
                return self_id


    # по данните за въпрос от старата БД създавам и записвам нов въпрос в новата БД
    def save_question(self, question, level):
        task = Task.objects.create_task(self.new_theme_item)
        task.text = question['text']
        task.type = question['type']
        task.level = level
        task.school = self.school
        task.author = self.school
        task.group = self.make_group_number(task.id, question['group'])
        # ако има картинка
        if question['picture']:
            # Изтегляне на изображението
            image_url = question['picture']
            response = requests.get(image_url, stream=True)
            if response.status_code == 200:
                # Получаване на името на файла от URL
                filename = image_url.split("/")[-1]
                # Създаване на ContentFile от съдържанието на изображението
                image_file = ContentFile(response.content, name=filename)
                task.picture.save(filename, image_file)  # Записване на изображението в ImageField
                print(f'Изображението {image_file} е успешно записано!')
            else:
                print(f'Неуспешно изтегляне на изображението {image_url}')
        task.save()
        # и сега опциите:
        for old_option in question['options']:
            option = TaskItem.objects.create_task(task.id)
            option.leading_char = old_option['leading_char']
            option.text = old_option['text']
            option.value = old_option['value']
            option.value_name = old_option['value_name']
            option.checked = old_option['checked']
            option.save()
        print(f'създаден е въпрос #{task.id}')
"""
    Прехвърляне на данните от старата програма в новата
"""
class TransferData(APIView):
    def get(self, request, theme):
        OldDB = Transfer(theme)
        if OldDB.get_theme_id():
            if OldDB.get_theme_items():
                OldDB.set_user_params(request)
                for old_item in OldDB.list_of_themes:
                    OldDB.set_item_params(old_item['item'])
                    for q in old_item['tasks_knowledge']:
                        OldDB.save_question(q,1)
                    for q in old_item['tasks_comprehension']:
                        OldDB.save_question(q,2)
                    for q in old_item['tasks_application']:
                        OldDB.save_question(q,3)
                    for q in old_item['tasks_application']:
                        OldDB.save_question(q,4)
                return Response(OldDB.list_of_themes)
            else:
                return Response({'error': 'Грешка: не са намерени въпроси. '}, status=500)
        else:
            return Response({'error': 'Грешка: theme_id не е намерен. '}, status=500)