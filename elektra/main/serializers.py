from rest_framework import serializers
from .models import ThemeItem, Theme, Task, TaskItem,  Test

""" 
    Сериализатори за въпросите 
"""


# опции/отговори към въпроси
class TaskItemSerializer(serializers.ModelSerializer):
    class Meta:
        model = TaskItem
        fields = "__all__"


# въпроси - списък
class TaskSerializer(serializers.ModelSerializer):
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
        model = Test
        fields = ('user_id', 'user_name', 'theme', 'points', 'time')


# Въпрос запазване на тялото на въпроса без картинката
#
class TaskSaveTaskBodySerializer(serializers.ModelSerializer):
    ids = serializers.IntegerField()

    class Meta:
        model = Task
        fields = ('id', 'ids', 'text', 'type', 'level', 'group', 'textWrap')

    def create(self, validated_data):
        print('create')
        print('validated_data: ', validated_data)
        text = validated_data.get('text')
        type_q = validated_data.get('type')
        level_q = validated_data.get('level')
        group = validated_data.get('group')
        textWrap = validated_data.get('textWrap')
        test = Task.objects.update_or_create(
            id=validated_data.get("ids"),
            defaults={'text': text, 'type': type_q, 'level': level_q, 'group': group, 'textWrap': textWrap})
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
        model = Test
        # fields = ( 'id', 'title', 'creation_date', 'image', 'author', 'image_url')
        fields = "__all__"

        # fields = ('id', 'title', 'creation_date', 'image', 'author')


"""    def get_image_url(self, obj):
        return obj.image.url
"""


class TestSaveSerializer(serializers.ModelSerializer):
    class Meta:
        model = Test
        fields = '__all__'

    def create(self, validated_data):
        i = validated_data.get('id')
        ttl = validated_data.get('title')
        cd = validated_data.get('creation_date')
        ath = validated_data.get('author')
        if i == 1000:
            test = Test.objects.create(title=ttl, author=ath)
        else:
            test = Test.objects.update_or_create(id=validated_data.get("id"), defaults={'title': ttl, 'creation_date': cd, 'author': ath})
        return test


class TestSaveFileSerializer(serializers.ModelSerializer):
    class Meta:
        model = Test
        fields = ('id', 'image')

    def create(self, validated_data):
        i = validated_data.get('id')
        image = validated_data.get('image')
        test = Test.objects.update_or_create(id=validated_data.get("id"), defaults={'image': image})
        return test
