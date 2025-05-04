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

from openai import OpenAI
from .keys import *

from rest_framework.permissions import IsAuthenticated
from .utils import update_test_statistics  # Функцията, която добавихме за обновяване на статистиките

from rest_framework import status
from rest_framework import generics
from rest_framework.decorators import api_view


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

def user_context(request, title, show_th=False, show_sp=False):
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
        'show_spec': show_sp,
        #        'schools': schools,
#        'specialities': user_profile.school.specialities.all(),
    }
    return context

def dzi_test(request):
    return render(request, 'main/dzi_test.html', user_context(request,'въпроси', show_th=True, show_sp=True))

def dzi_test_online_start(request):
    return render(request, 'main/dzi_test_online_start.html', user_context(request,'въпроси', show_th=True, show_sp=True))

def dzi_test_online(request):
    return render(request, 'main/dzi_test_online.html', user_context(request,'тест', show_th=True, show_sp=True))


def dzi_tasks(request):
    return render(request, 'main/dzi_tasks.html', user_context(request,'въпроси', show_th=True, show_sp=True))

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
    context['specialities'] = Specialty.objects.all()

    return render(request, 'main/dzi_settings.html', context)


def dzi_add_speciality(request, sp):
    specialty = get_object_or_404(Specialty, id=sp)
    user = request.user
    user_profile = user.userprofile
    school = get_object_or_404(School, id=user_profile.school.id)

    # Проверяваме дали специалността вече не е добавена към училището
    if specialty not in school.specialities.all():
        # Добавяме специалността към училището
        school.specialities.add(specialty)

        # Записване на промените
        school.save()
    return dzi_settings(request)


def dzi_edit_speciality(request, sp):
    context = user_context(request, 'настройки')
    context['specialty'] = get_object_or_404(Specialty, id=sp)
    context['speciality_id'] = sp
    return render(request, 'main/dzi_edit_speciality.html', context)


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
            print(f'data={data}')
            ctx_id = data['context']['id']
            context = TaskContext.objects.get(id=ctx_id)
            context.text = data['context']['text']
            context.textWrap = data['context']['textWrap']
            context.save()
            task.context=context
        else:
            task.context = None

        task.text = data['text']
        task.type = data['type']
        task.level = data['level']
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
        queryset = TestResult.objects.order_by('user_id')
        serializer = TestSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)
# ToDo: да се актуализира TestSerializer

class TestByThemeView(APIView):
    def get(self, request):
        queryset = TestResult.objects.order_by('theme')
        serializer = TestSerializer(queryset, many=True, context={"request": request})
        return Response(serializer.data)
# ToDo: да се актуализира TestSerializer


"""
       *******************   TEST  ******************
"""

# запазване на резултат от тест на на ниво потребител

class SaveTestResults(APIView):
    permission_classes = [IsAuthenticated]  # Уверете се, че само автентицирани потребители могат да записват резултати

    def post(self, request):
        # Запис на резултата на ниво потребител (тест)
        user = request.user
        theme_id = request.data.get('theme')
        points = request.data.get('points')
        time = request.data.get('time')
        spec_id = request.data.get('spec')
        test_questions = request.data.get('test')  # Списък с въпросите и техните резултати

        # Създаване на нов запис за резултата от теста
        try:
            theme = Theme.objects.get(id=theme_id)
            spec = Specialty.objects.get(id=spec_id)
        except (Theme.DoesNotExist, Specialty.DoesNotExist):
            return Response({"error": "Invalid theme or specialty ID"}, status=400)

        # Създаване на нов TestResult запис
        test_result = TestResult.objects.create(
            user=user,
            theme=theme,
            spec=spec,
            points=points,
            time=time
        )

        # Списък за съхраняване на отговорите
        answers = []

        # Запис на резултатите на ниво въпроси
        for test_question in test_questions:
            try:
                question = Task.objects.get(id=test_question['id'])
            except Task.DoesNotExist:
                return Response({"error": f"Task with ID {test_question['id']} does not exist"}, status=400)

            # Актуализиране на статистиките на въпроса
            question.stat_attempts += 1
            question.stat_points += test_question.get('stat_points', 0)
            question.save()

            # Добавяне на отговор в списъка
            is_correct = test_question.get('is_correct', False)
            points = test_question.get('stat_points', 0)
            answer = Answer(
                user=user,
                task=question,
                test_result=test_result,
                is_correct=is_correct,
                points=points
            )
            answers.append(answer)

        # Масово записване на отговорите
        Answer.objects.bulk_create(answers)

        # Актуализиране на статистиките за теста
        update_test_statistics(test_result, answers)

        return Response({"message": "Test results saved successfully"}, status=201)

class SaveTestResults_old(APIView):
    def post(self, request):
        # запис на резултата на ниво потребител
        user = self.request.user
        user_id = user.id

        theme = request.data['theme']
        points = request.data['points']
        time = request.data['time']
        spec = request.data['spec']

        record = TestResult.objects.create()
        record.user = user
        record.theme = Theme.objects.filter(id=theme).get()
        record.spec = Specialty.objects.filter(id=spec).get()
        record.points = points
        record.time = time
        record.save()

        # запис на реезултата на ниво въпроси
        test = request.data['test']
        for test_question in test:
            print(f'test question:{test_question}')

            local_question = Task.objects.filter(id=test_question['id']).get()
            local_question.stat_attempts = local_question.stat_attempts + 1
            local_question.stat_points = local_question.stat_points + test_question['stat_points']
            local_question.save()

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
        print(f'NewContextView: {serializer.data}')
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


"""
    Проверка на въпрос с отворен отговор с понощта на OpenAI
"""
# Задайте вашия OpenAI API ключ
client = OpenAI(
  api_key = MY_API_KEY
)

class CheckAnswer(APIView):
    def post(self, request):
        try:
            # Парсиране на входните данни от фронтенда
            question = request.data["question"]
            example_answer = request.data["example_answer"]
            student_answer = request.data["student_answer"]
            print(question, example_answer, student_answer)
            # Проверка дали всички необходими данни са налични
            if not question or not example_answer or not student_answer:
                return Response({"error": "Missing required fields"}, status=400)

            # Формулиране на prompt за OpenAI
            prompt = f"""  
Ти си учител, който проверява отговор на ученик  на зададен въпрос.   
Въпросът е: "{question}"  
Възможни верни отговори са (разделени с ";"): "{example_answer}"  
Отговора на ученика е: "{student_answer}"  

Верен ли е отговорът на ученика? Отговори с "Да" или "Не".  
"""

            # Изпращане на заявка към OpenAI API
            response = client.chat.completions.create(
                model="gpt-4",  # Можете да използвате и "gpt-3.5-turbo"
                messages=[
                    {'role': 'system', 'content': 'You are a helpful assistant.'},
                    {'role': 'user', 'content': prompt},
                ],
                max_tokens=100,
                temperature=0.2,  # По-ниска стойност за по-конкретни отговори
            )

            # Извличане на отговора от OpenAI
            ai_response = response.choices[0].message.content.strip()

            # Връщане на резултата към фронтенда
            return Response({'result': ai_response}, status=200)

        except Exception as e:
            return Response({'error': str(e)}, status=500)

"""
        ПОТРЕБИТЕЛИ
"""

class CreateOrUpdateUserView(APIView):
    def post(self, request, *args, **kwargs):
        user_id = request.data.get('id', 0)  # Вземаме ID от заявката, по подразбиране е 0

        if user_id == 0:  # Ако ID е 0, създаваме нов потребител
            serializer = UserSerializer(data=request.data)
            if serializer.is_valid():
                user = serializer.save()
                return Response({'message': 'Потребителят е създаден успешно!', 'user_id': user.id}, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        else:  # Ако ID не е 0, модифицираме съществуващ потребител
            try:
                user = User.objects.get(id=user_id)  # Намираме потребителя по ID
            except User.DoesNotExist:
                return Response({'error': 'Потребителят не съществува.'}, status=status.HTTP_404_NOT_FOUND)

            serializer = UserSerializer(user, data=request.data, partial=True)  # partial=True позволява частично обновяване
            if serializer.is_valid():
                user = serializer.save()
                return Response({'message': 'Потребителят е модифициран успешно!', 'user_id': user.id}, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class UserListView(APIView):
    def get(self, request, sc, lvl):
        print(f'UserListView/{sc}/{lvl}/')
        # Извличане на параметрите за филтриране от заявката
        school_id = sc
        level = lvl

        # Филтриране на потребителите
        users = User.objects.filter(
            userprofile__school=school_id,
            userprofile__access_level__gt=level,
        )

        # Сериализиране на резултатите
        serializer = UserReadSerializer(users, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class SchoolSpecialtiesView(APIView):
    def get(self, request, school_id, *args, **kwargs):
        try:
            # Намираме училището по зададеното ID
            school = School.objects.get(id=school_id)
        except School.DoesNotExist:
            return Response({'error': 'Училището не съществува.'}, status=status.HTTP_404_NOT_FOUND)

        # Вземаме всички специалности, свързани с училището
        specialties = school.specialities.all()

        # Сериализираме специалностите
        serializer = SpecialtySerializer(specialties, many=True)

        return Response(serializer.data, status=status.HTTP_200_OK)


from django.contrib.auth.models import User
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status

class ChangePasswordView(APIView):
    def post(self, request, *args, **kwargs):
        # Извличаме входните данни
        user_id = request.data.get('id')
        new_password = request.data.get('new_password')
        print(f'password changing for user id={user_id}, new_password={new_password}')

        # Проверка дали са подадени всички необходими данни
        if not user_id or not new_password:
            return Response(
                {"error": "Идентификаторът на потребителя и новата парола са задължителни."},
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            # Намираме потребителя по ID
            user = User.objects.get(id=user_id)
        except User.DoesNotExist:
            return Response(
                {"error": "Потребителят с дадения ID не съществува."},
                status=status.HTTP_404_NOT_FOUND
            )

        # Сменяме паролата
        print(f'Сменям парола с {new_password}')
        user.set_password(new_password)
        user.save()

        # Проверяваме дали паролата е правилно зададена
        if user.check_password(new_password):
            print('Паролата беше успешно сменена и проверена.')
            return Response(
                {"message": "Паролата беше успешно сменена и проверена."},
                status=status.HTTP_200_OK
            )
        else:
            print('Паролата не беше правилно зададена.')
            return Response(
                {"error": "Паролата не беше правилно зададена."},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )

class DeleteUserView(APIView):
    def get(self, request, user_id, *args, **kwargs):
        try:
            # Намираме потребителя по ID
            user = User.objects.get(id=user_id)
        except User.DoesNotExist:
            return Response(
                {"error": "Потребителят с дадения ID не съществува."},
                status=status.HTTP_404_NOT_FOUND
            )

        # Изтриваме потребителя
        user.delete()
        return Response(
            {"message": "Потребителят беше успешно изтрит."},
            status=status.HTTP_200_OK
        )

# данни за определено по id училище
class SchoolDetailAPIView(generics.RetrieveAPIView):
    queryset = School.objects.all()
    serializer_class = SchoolSerializer


# Данни за училище - обновяване на логото
class SchoolLogoAPIView(APIView):
    def post(self, request):
        data = SchoolLogoSerializer(data=request.data)
        if data.is_valid():
            data.save(id=request.data['id'])
        return Response(status=201)

# Запазване на данни за училище
class SchoolUpdateAPIView(generics.UpdateAPIView):
    queryset = School.objects.all()
    serializer_class = SchoolSerializer2


# премахване на специалност от дадено училище
def dzi_remove_speciality(request, sp):
    try:
        # Взимаме обектите от базата данни
        specialty = get_object_or_404(Specialty, id=sp)
        user = request.user
        user_profile = user.userprofile
        school = get_object_or_404(School, id=user_profile.school.id)

        # Проверяваме дали специалността съществува в списъка
        if specialty in school.specialities.all():
            # Премахваме специалността от училището
            school.specialities.remove(specialty)

            # Записване на промените
            school.save()

            return JsonResponse({
                'success': True,
                'message': f'Специалност "{specialty.specialty_name}" беше премахната от училище "{school.short_name} {school.city}".',
                'school_id': school.id,
                'specialty_id': specialty.id
            })
        else:
            # Специалността не е в списъка
            return JsonResponse({
                'success': False,
                'message': f'Специалност "{specialty.specialty_name}" не е добавена към училище "{school.short_name} {school.city}".',
                'school_id': school.id,
                'specialty_id': specialty.id
            })

    except Exception as e:
        # Обработка на грешки
        return JsonResponse({
            'success': False,
            'message': f'Възникна грешка при премахване на специалност: {str(e)}',
            'error': str(e)
        }, status=500)


# Данни за специалност
class SpecialtyDetailAPIView(generics.RetrieveAPIView):
    queryset = Specialty.objects.all()
    serializer_class = SpecialtySerializer


# API за качване на NIP файл
@api_view(['POST'])
def specialty_upload_nip(request, specialty_id):
    specialty = get_object_or_404(Specialty, id=specialty_id)

    if 'nip' not in request.FILES:
        return Response({'error': 'Няма файл в заявката'}, status=status.HTTP_400_BAD_REQUEST)

    # Изтриваме стария файл, ако има такъв
    if specialty.nip:
        specialty.nip.delete(save=False)

    specialty.nip = request.FILES['nip']
    specialty.save()

    # Връщаме URL на файла
    return Response({
        'nip': request.build_absolute_uri(specialty.nip.url)
    })


"""
    Изглед за зареждане и актуализиране на специалност.
    GET - връща детайли за специалността
    PUT - актуализира данните за специалността
"""


@api_view(['GET', 'PUT'])
def specialty_detail(request, specialty_id):
    specialty = get_object_or_404(Specialty, id=specialty_id)

    if request.method == 'GET':
        serializer = SpecialtySerializer(specialty, context={'request': request})
        return Response(serializer.data)

    elif request.method == 'PUT':
        try:
            data = request.data
            print("Получени данни от PUT заявка:", data)

            # Директно актуализиране на модела
            specialty.professional_field_num = data.get('professional_field_num', specialty.professional_field_num)
            specialty.professional_field_name = data.get('professional_field_name', specialty.professional_field_name)
            specialty.profession_num = data.get('profession_num', specialty.profession_num)
            specialty.profession_name = data.get('profession_name', specialty.profession_name)
            specialty.specialty_num = data.get('specialty_num', specialty.specialty_num)
            specialty.specialty_name = data.get('specialty_name', specialty.specialty_name)

            specialty.save()

            # Връщане на актуализираните данни
            result = {
                'id': specialty.id,
                'professional_field_num': specialty.professional_field_num,
                'professional_field_name': specialty.professional_field_name,
                'profession_num': specialty.profession_num,
                'profession_name': specialty.profession_name,
                'specialty_num': specialty.specialty_num,
                'specialty_name': specialty.specialty_name
            }

            # Добавяне на nip, ако съществува
            if specialty.nip:
                result['nip'] = request.build_absolute_uri(specialty.nip.url)
            else:
                result['nip'] = ""

            return Response(result)

        except Exception as e:
            print(f"Грешка при актуализиране на специалност: {str(e)}")
            import traceback
            traceback.print_exc()
            return Response({'error': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@api_view(['GET'])
def specialty_themes_view(request, specialty_id):
    """
    Изглед, който връща теми и техните подточки за зададена специалност.
    Извлича само необходимите полета.
    """
    try:
        # Проверяваме дали специалността съществува
        specialty = get_object_or_404(Specialty, id=specialty_id)

        # Намираме всички теми за тази специалност, подредени по 'num'
        themes = Theme.objects.filter(specialty=specialty).order_by('num')

        # Подготвяме резултата
        result = []

        # За всяка тема извличаме само нужните полета и нейните подточки
        for theme in themes:
            theme_data = {
                'id': theme.id,
                'num': theme.num,
                'title': theme.title,
                'tasks_knowledge': theme.tasks_knowledge,
                'tasks_comprehension': theme.tasks_comprehension,
                'tasks_application': theme.tasks_application,
                'tasks_analysis': theme.tasks_analysis,
                'items': []
            }

            # Намираме всички подточки за тази тема, подредени по 'item'
            theme_items = ThemeItem.objects.filter(theme_id=theme).order_by('item')

            # За всяка подточка извличаме само нужните полета
            for item in theme_items:
                item_data = {
                    'id': item.id,
                    'item': item.item,
                    'title': item.title,
                    'total_points': item.total_points,
                    'knowledge': item.knowledge,
                    'comprehension': item.comprehension,
                    'application': item.application,
                    'analysis': item.analysis
                }
                theme_data['items'].append(item_data)

            result.append(theme_data)

        return Response(result)

    except Exception as e:
        print(f"Грешка при извличане на теми за специалност: {str(e)}")
        import traceback
        traceback.print_exc()
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['POST'])
def create_theme_view(request, specialty_id):
    """
    Изглед за създаване на нова тема за дадена специалност.
    """
    try:
        # Проверяваме дали специалността съществува
        specialty = get_object_or_404(Specialty, id=specialty_id)

        # Извличаме данните от заявката
        data = request.data

        # Определяме номера на новата тема
        num = data.get('num')
        if not num:
            # Ако не е предоставен номер, намираме максималния номер и увеличаваме с 1
            max_num = Theme.objects.filter(specialty=specialty).aggregate(models.Max('num'))['num__max'] or 0
            num = max_num + 1

        # Създаваме новата тема
        theme = Theme.objects.create(
            specialty=specialty,
            num=num,
            title=data.get('title', ''),
            tasks_knowledge=data.get('tasks_knowledge', 0),
            tasks_comprehension=data.get('tasks_comprehension', 0),
            tasks_application=data.get('tasks_application', 0),
            tasks_analysis=data.get('tasks_analysis', 0),
            tasks_total=data.get('tasks_total', 24)
        )

        # Връщаме данните за новата тема
        result = {
            'id': theme.id,
            'num': theme.num,
            'title': theme.title,
            'tasks_knowledge': theme.tasks_knowledge,
            'tasks_comprehension': theme.tasks_comprehension,
            'tasks_application': theme.tasks_application,
            'tasks_analysis': theme.tasks_analysis,
            'items': []
        }

        return Response(result, status=status.HTTP_201_CREATED)

    except Exception as e:
        print(f"Грешка при създаване на тема: {str(e)}")
        import traceback
        traceback.print_exc()
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['PUT'])
def update_theme_view(request, theme_id):
    """
    Изглед за обновяване на съществуваща тема.
    """
    try:
        # Проверяваме дали темата съществува
        theme = get_object_or_404(Theme, id=theme_id)

        # Извличаме данните от заявката
        data = request.data

        # Обновяваме темата
        theme.num = data.get('num', theme.num)
        theme.title = data.get('title', theme.title)
        theme.tasks_knowledge = data.get('tasks_knowledge', theme.tasks_knowledge)
        theme.tasks_comprehension = data.get('tasks_comprehension', theme.tasks_comprehension)
        theme.tasks_application = data.get('tasks_application', theme.tasks_application)
        theme.tasks_analysis = data.get('tasks_analysis', theme.tasks_analysis)

        # Запазваме обновената тема
        theme.save()

        # Намираме всички подточки за тази тема, подредени по 'item'
        theme_items = ThemeItem.objects.filter(theme_id=theme).order_by('item')

        # Връщаме обновените данни за темата
        result = {
            'id': theme.id,
            'num': theme.num,
            'title': theme.title,
            'tasks_knowledge': theme.tasks_knowledge,
            'tasks_comprehension': theme.tasks_comprehension,
            'tasks_application': theme.tasks_application,
            'tasks_analysis': theme.tasks_analysis,
            'items': []
        }

        # Добавяме подточките към резултата
        for item in theme_items:
            item_data = {
                'id': item.id,
                'item': item.item,
                'title': item.title,
                'total_points': item.total_points,
                'knowledge': item.knowledge,
                'comprehension': item.comprehension,
                'application': item.application,
                'analysis': item.analysis
            }
            result['items'].append(item_data)

        return Response(result)

    except Exception as e:
        print(f"Грешка при обновяване на тема: {str(e)}")
        import traceback
        traceback.print_exc()
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['POST'])
def create_theme_item_view(request, theme_id):
    """
    Изглед за създаване на нова подточка към тема.
    """
    try:
        # Проверяваме дали темата съществува
        theme = get_object_or_404(Theme, id=theme_id)

        # Извличаме данните от заявката
        data = request.data

        # Определяме номера на новата подточка
        item_num = data.get('item')
        if not item_num:
            # Ако не е предоставен номер, намираме максималния номер и увеличаваме с 1
            max_item = ThemeItem.objects.filter(theme_id=theme).aggregate(models.Max('item'))['item__max'] or 0
            item_num = max_item + 1

        # Създаваме новата подточка
        theme_item = ThemeItem.objects.create(
            theme_id=theme,
            item=item_num,
            title=data.get('title', ''),
            criterion=data.get('criterion', ''),
            total_points=data.get('total_points', 20),
            knowledge=data.get('knowledge', 0),
            comprehension=data.get('comprehension', 0),
            application=data.get('application', 0),
            analysis=data.get('analysis', 0)
        )

        # Връщаме данните за новата подточка
        result = {
            'id': theme_item.id,
            'item': theme_item.item,
            'title': theme_item.title,
            'total_points': theme_item.total_points,
            'knowledge': theme_item.knowledge,
            'comprehension': theme_item.comprehension,
            'application': theme_item.application,
            'analysis': theme_item.analysis
        }

        return Response(result, status=status.HTTP_201_CREATED)

    except Exception as e:
        print(f"Грешка при създаване на подточка: {str(e)}")
        import traceback
        traceback.print_exc()
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['PUT'])
def update_theme_item_view(request, item_id):
    """
    Изглед за обновяване на съществуваща подточка.
    """
    try:
        # Проверяваме дали подточката съществува
        theme_item = get_object_or_404(ThemeItem, id=item_id)

        # Извличаме данните от заявката
        data = request.data

        # Обновяваме подточката
        theme_item.item = data.get('item', theme_item.item)
        theme_item.title = data.get('title', theme_item.title)
        theme_item.total_points = data.get('total_points', theme_item.total_points)
        theme_item.knowledge = data.get('knowledge', theme_item.knowledge)
        theme_item.comprehension = data.get('comprehension', theme_item.comprehension)
        theme_item.application = data.get('application', theme_item.application)
        theme_item.analysis = data.get('analysis', theme_item.analysis)

        # Не обновяваме полето criterion, тъй като не е в списъка с изискваните полета

        # Запазваме обновената подточка
        theme_item.save()

        # Връщаме обновените данни за подточката
        result = {
            'id': theme_item.id,
            'item': theme_item.item,
            'title': theme_item.title,
            'total_points': theme_item.total_points,
            'knowledge': theme_item.knowledge,
            'comprehension': theme_item.comprehension,
            'application': theme_item.application,
            'analysis': theme_item.analysis
        }

        return Response(result)

    except Exception as e:
        print(f"Грешка при обновяване на подточка: {str(e)}")
        import traceback
        traceback.print_exc()
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


# views.py

@api_view(['DELETE'])
def delete_theme_item_view(request, item_id):
    """
    Изглед за изтриване на подточка.
    """
    try:
        theme_item = get_object_or_404(ThemeItem, id=item_id)

        # Запазваме ID на темата, за да можем да я върнем в отговора
        theme_id = theme_item.theme_id.id if theme_item.theme_id else None

        # Изтриваме подточката (и всички свързани задачи поради CASCADE)
        theme_item.delete()

        return Response({
            'success': True,
            'message': 'Подточката беше успешно изтрита.',
            'theme_id': theme_id
        }, status=status.HTTP_200_OK)

    except Exception as e:
        print(f"Грешка при изтриване на подточка: {str(e)}")
        import traceback
        traceback.print_exc()
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['GET'])
def theme_item_tasks_count(request, item_id):
    """
    Връща броя на задачите, свързани с дадена подточка.
    """
    try:
        theme_item = get_object_or_404(ThemeItem, id=item_id)
        tasks_count = Task.objects.filter(item=theme_item).count()
        print(f'item_id={item_id} -> {tasks_count} намерени')
        return Response({'count': tasks_count})

    except Exception as e:
        print(f"Грешка при проверка на задачи за подточка: {str(e)}")
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )


@api_view(['PATCH'])
def change_task_theme_item(request, task_id):
    """
    Променя подточката (ThemeItem) на задача (Task).
    """
    try:
        # Намираме задачата
        task = get_object_or_404(Task, id=task_id)

        # Извличаме ID на новата подточка от данните
        theme_item_id = request.data.get('theme_item_id')
        if not theme_item_id:
            return Response(
                {'error': 'Липсва ID на подточка.'},
                status=status.HTTP_400_BAD_REQUEST
            )

        # Проверяваме дали подточката съществува
        theme_item = get_object_or_404(ThemeItem, id=theme_item_id)

        # Променяме връзката
        task.item = theme_item
        task.save()

        # Връщаме успешен отговор с допълнителна информация
        return Response({
            'success': True,
            'message': 'Връзката беше променена успешно.',
            'task_id': task.id,
            'theme_item_id': theme_item.id,
            'theme_item_title': f"{theme_item.item}. {theme_item.title}"
        }, status=status.HTTP_200_OK)

    except Exception as e:
        import traceback
        traceback.print_exc()
        return Response(
            {'error': str(e)},
            status=status.HTTP_500_INTERNAL_SERVER_ERROR
        )