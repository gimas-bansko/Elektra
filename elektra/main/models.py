from django.contrib.auth.models import User  
from django.db import models  
from django.db.models.signals import post_save
from django.dispatch import receiver
from .utils import *

""" 
***************************************
               Училища
***************************************
"""
class School(models.Model):
    short_name = models.CharField('Абревиатура', max_length=20, default='', blank=True,
                                  help_text='Съкратено име на училището')
    full_name = models.TextField('Име', default='', blank=True, help_text='Пълно име на училището')
    city = models.CharField('Населено място', max_length=50, default='', blank=True,
                            help_text='Населено място, където се намира училището')
    address = models.CharField('Адрес', max_length=50, default='', blank=True,
                            help_text='Адрес в населеното място (ул. ... №...)')
    phone_number = models.CharField('Телефон', max_length=15, default='', blank=True)
    email = models.CharField('e-mail', max_length=35, default='', blank=True)
    boss = models.CharField('Директор', max_length=50, default='', blank=True,
                            help_text='Име на директора на училището')

    def __str__(self):
        return f'{self.short_name} {self.city}'

    class Meta:
        verbose_name = 'Училище/организация'
        verbose_name_plural = 'Училища/организации'

"""
***************************************
            Потребители
***************************************
"""
class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)  
    phone_number = models.CharField(max_length=15, blank=True)  
    birth_date = models.DateField(null=True, blank=True)  

    def __str__(self):
        return f'Потребител #{self.user.id}: {self.user.first_name} {self.user.last_name}'

    class Meta:
        verbose_name = 'Пофил на потребител'
        verbose_name_plural = 'Пофили на потребител'


@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    print('===>>> create user')
    if created:
        UserProfile.objects.create(user=instance)

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    print('===>>> save user')
    instance.userprofile.save()

# ****************************************
#             Изпитни теми
# ****************************************

class Theme(models.Model):
    num = models.PositiveSmallIntegerField('Тема №', default=1, help_text='№ на тема: 1, 2, ... 18')
    title = models.TextField('Заглавие', help_text='Заглавие на темата')
    remark = models.TextField('Коментар/забележка', blank=True,
                              help_text='Допълнително указание или коментар към темата')
    tasks_total = models.PositiveSmallIntegerField('Общ брой задачи', default=24, help_text='Максимален брой задачи')
    tasks_knowledge = models.PositiveSmallIntegerField('Знание', default=0, help_text='Знание - брой задачи ')
    tasks_comprehension = models.PositiveSmallIntegerField('Разбиране', default=0, help_text='Разбиране - брой задачи ')
    tasks_application = models.PositiveSmallIntegerField('Приложение', default=0, help_text='Приложение - брой задачи ')
    tasks_analysis = models.PositiveSmallIntegerField('Анализ', default=0, help_text='Анализ - брой задачи ')

    def __str__(self):
        return f'Тема {self.num}. {self.title}'

    class Meta:
        verbose_name = 'Тема'
        verbose_name_plural = 'Теми'


# Точки (подтеми) на изпитните теми
class ThemeItem(models.Model):
    theme_id = models.ForeignKey(Theme, on_delete=models.CASCADE, related_name='items')
    item = models.PositiveSmallIntegerField('Точка №', default=1,
                                            help_text='№ на точка в темата: 1, 2, ... ')
    title = models.TextField('Заглавие', help_text='Заглавие на точката')
    criterion = models.TextField('Заглавие', help_text='Критерий за оценяване. За темата - забележка')
    total_points = models.PositiveSmallIntegerField('Точки max', default=20, help_text='Максимален брой точки')
    knowledge = models.PositiveSmallIntegerField('Знание', default=0, help_text='Знание - брой задачи ')
    comprehension = models.PositiveSmallIntegerField('Разбиране', default=0, help_text='Разбиране - брой задачи ')
    application = models.PositiveSmallIntegerField('Приложение', default=0, help_text='Приложение - брой задачи ')
    analysis = models.PositiveSmallIntegerField('Анализ', default=0, help_text='Анализ - брой задачи ')

    def __str__(self):
        return f'{self.item}. {self.title}'

    class Meta:
        verbose_name = 'Тема - точка'
        verbose_name_plural = 'Теми - точки'

""" 
***************************************
        Въпроси и отговори към тях
***************************************

"""
class ImageField(models.ImageField):
    def value_to_string(self, obj):
        return obj.pic.url

# Въпроси - формулировка
class TaskManager(models.Manager):
    def create_task(self, itm):
        item = self.create(item=itm)
        return item


class Task(models.Model):
    item = models.ForeignKey(ThemeItem, on_delete=models.CASCADE, null=True, related_name='tasks_knowledge')
    num = models.PositiveSmallIntegerField(default=0, help_text='генерира се автоматично')
    text = models.TextField('Въпрос', default='', blank=True, help_text='Формулировка (текст) на въпроса')
    type = models.PositiveSmallIntegerField(choices=TASK_TYPE, default=TYPE1, help_text='тип на въпроса')
    picture = models.ImageField('Картинка', upload_to='task_pics', blank=True)
    group = models.PositiveSmallIntegerField(default=0, help_text='0 - ако не е групирано')
    mark_red = models.BooleanField('Червен маркер', null=True, default=False)
    mark_green = models.BooleanField('Зелен маркер', null=True, default=False)
    mark_yellow = models.BooleanField('Жълт маркер', null=True, default=False)
    themes = models.ManyToManyField(Theme, blank=True)

    objects = TaskManager()

    def __str__(self):
        return self.text

    class Meta:
        verbose_name = 'Въпрос'
        verbose_name_plural = 'Въпроси'


# Въпроси - опции
class TaskItemManager(models.Manager):
    def create_task(self, task_id):
        item = self.create(task=task_id)
        return item


class TaskItem(models.Model):
    task = models.ForeignKey(Task, on_delete=models.CASCADE, null=True, related_name='options')
    leading_char = models.CharField('Водещ символ', max_length=4, default='', blank=True, help_text='№ или буква')
    text = models.CharField('Текст', max_length=200, default='', blank=True, help_text='Формулировка (текст) на опцията(отговора)')
    value = models.CharField('Стойност', max_length=20, default='', blank=True, help_text='Отговор - стойност')
    value_name = models.CharField("Стойност - име", max_length=200, default='', blank=True, help_text='Отговор - име')
    checked = models.BooleanField('Отговор - маркирано', null=True, help_text='Отговор за опции с маркиране')
    checked_t = models.BooleanField('Отговор - маркирано', null=True, help_text='генерира се автоматично')
    value_t = models.CharField('Стойност', max_length=20, default='', blank=True, help_text='генерира се автоматично')

    objects = TaskItemManager()

    def __str__(self):
        return f'{self.leading_char} {self.text}'

    class Meta:
        verbose_name = 'Въпрос - опция'
        verbose_name_plural = 'Въпроси - опции'


""" 
***************************************
        Въпроси и отговори към тях
***************************************

"""
