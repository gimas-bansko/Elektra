from rest_framework import serializers
from .models import *

from django.contrib.auth.models import User

""" 
    Сериализатори за въпросите 
"""


# опции/отговори към въпроси
class TaskItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = TaskItem
        fields = "__all__"

# общ контекст за група въпроси
class TaskContextSerializer(serializers.ModelSerializer):
    class Meta:
        model = TaskContext
        fields = '__all__'

# общ контекст - обновяваане на картинка
class ContextFileSerializer(serializers.ModelSerializer):
    class Meta:
        model = TaskContext
        fields = ('id', 'picture')

    def create(self, validated_data):
        image = validated_data.get('picture')
        item = TaskContext.objects.update_or_create(id=validated_data.get("id"), defaults={'picture': image})
        return item

# въпроси - списък
class TaskSerializer(serializers.ModelSerializer):

    context = TaskContextSerializer()
    options = TaskItemSerializer(many=True)

    class Meta:
        model = Task
        fields = '__all__'


# въпроси - обновяваане на картинка
class TaskFileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task
        fields = ('id', 'picture')

    def create(self, validated_data):
        image = validated_data.get('picture')
        item = Task.objects.update_or_create(id=validated_data.get("id"), defaults={'picture': image})
        return item



""" Сериализатор ТЕМА """


class ThemeItemSerializer(serializers.ModelSerializer):
    tasks = TaskSerializer(many=True)

    class Meta:
        model = ThemeItem
        fields = "__all__"


class ThemeSerializer(serializers.ModelSerializer):
    class Meta:
        model = Theme
        fields = "__all__"


class ThemeNumSerializer(serializers.ModelSerializer):
    class Meta:
        model = Theme
        fields = "__all__"


class TestSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestResult
        fields = ('user_id', 'user_name', 'theme', 'points', 'time')


# Въпрос запазване на тялото на въпроса без картинката
#
class TaskSaveTaskBodySerializer(serializers.ModelSerializer):
    ids = serializers.IntegerField()

    class Meta:
        model = Task
        fields = ('id', 'ids', 'text', 'type', 'level', 'group', 'textWrap', 'context')

    def create(self, validated_data):
        print('create')
        print('validated_data: ', validated_data)
        text = validated_data.get('text')
        type_q = validated_data.get('type')
        level_q = validated_data.get('level')
        group = validated_data.get('group')
        textWrap = validated_data.get('textWrap')
        context = validated_data.get('context')
        test = Task.objects.update_or_create(
            id=validated_data.get("ids"),
            defaults={'text': text, 'type': type_q, 'level': level_q, 'group': group, 'textWrap': textWrap, 'context': context})
        print('test=', test)
        return test


# Въпрос запазване на опциите към въпроса
#
class TaskSaveTaskOptionsSerializer(serializers.ModelSerializer):
    ids = serializers.IntegerField()

    class Meta:
        model = TaskItem
        fields = ('id', 'ids', 'task', 'leading_char', 'text', 'value', 'value_name', 'checked')

    def create(self, validated_data):
        task = validated_data.get('task')
        leading_char = validated_data.get('leading_char')
        text = validated_data.get('text')
        value = validated_data.get('value')
        value_name = validated_data.get('value_name')
        checked = validated_data.get('checked')
        option = TaskItem.objects.update_or_create(
            id=validated_data.get("ids"),
            defaults={'task': task, 'leading_char': leading_char, 'text': text, 'value': value,
                      'value_name': value_name, 'checked': checked})
        return option

"""
*****************************   TEST   ***************************** 
"""
class TestReadSerializer(serializers.ModelSerializer):
    # image_url = serializers.SerializerMethodField('get_image_url')
    class Meta:
        model = TestResult
        # fields = ( 'id', 'title', 'creation_date', 'image', 'author', 'image_url')
        fields = "__all__"

        # fields = ('id', 'title', 'creation_date', 'image', 'author')


"""    def get_image_url(self, obj):
        return obj.image.url
"""


class TestSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestResult
        fields = '__all__'

    def create(self, validated_data):
        i = validated_data.get('id')
        ttl = validated_data.get('title')
        cd = validated_data.get('creation_date')
        ath = validated_data.get('author')
        if i == 1000:
            test = TestResult.objects.create(title=ttl, author=ath)
        else:
            test = TestResult.objects.update_or_create(id=validated_data.get("id"), defaults={'title': ttl, 'creation_date': cd, 'author': ath})
        return test


class TestSaveFileSerializer(serializers.ModelSerializer):
    class Meta:
        model = TestResult
        fields = ('id', 'image')

    def create(self, validated_data):
        i = validated_data.get('id')
        image = validated_data.get('image')
        test = TestResult.objects.update_or_create(id=validated_data.get("id"), defaults={'image': image})
        return test


class RemarkSerializer(serializers.ModelSerializer):
    class Meta:
        model = Remark
        fields = "__all__"

"""
        ПОТРЕБИТЕЛИ
"""
class SpecialtySerializer(serializers.ModelSerializer):
    class Meta:
        model = Specialty
        fields = '__all__'  # Включи всички полета на модела Specialty

class UserProfileSpecSerializer(serializers.ModelSerializer):
    speciality = SpecialtySerializer()  # Включваме сериализатора за Specialty

    class Meta:
        model = UserProfile
        fields = ['gender', 'school', 'access_level', 'session_screen', 'session_theme', 'speciality']

class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['gender', 'school', 'access_level', 'session_screen', 'session_theme', 'speciality']

class UserSerializer(serializers.ModelSerializer):
    userprofile = UserProfileSerializer()

    class Meta:
        model = User
        fields = ['id', 'username', 'password', 'email', 'first_name', 'last_name', 'userprofile']
        extra_kwargs = {
            'password': {'write_only': True},  # Паролата не трябва да се връща в отговорите
        }

    def create(self, validated_data):
        # Извличаме данните за профила
        userprofile_data = validated_data.pop('userprofile', None)

        # Създаваме потребителя
        user = User.objects.create_user(**validated_data)

        # Актуализираме автоматично създадения профил, ако има данни за userprofile
        if userprofile_data:
            for attr, value in userprofile_data.items():
                setattr(user.userprofile, attr, value)
            user.userprofile.save()

        return user

    def update(self, instance, validated_data):
        # Извличаме данните за профила
        userprofile_data = validated_data.pop('userprofile', None)

        # Актуализираме основните данни на потребителя
        instance.username = validated_data.get('username', instance.username)
        instance.email = validated_data.get('email', instance.email)
        instance.first_name = validated_data.get('first_name', instance.first_name)
        instance.last_name = validated_data.get('last_name', instance.last_name)

        instance.save()

        # Актуализираме профила на потребителя, ако има данни за него
        if userprofile_data:
            userprofile = instance.userprofile
            userprofile.gender = userprofile_data.get('gender', userprofile.gender)
            userprofile.save()

        return instance

class UserReadSerializer(serializers.ModelSerializer):
    userprofile = UserProfileSpecSerializer()

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name', 'userprofile']