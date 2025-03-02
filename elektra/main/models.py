from django.contrib.auth.models import User
from django.core.validators import MinValueValidator, MaxValueValidator
from django.db import models  
from django.db.models.signals import post_save
from django.dispatch import receiver
from .utils import *
from datetime import datetime
from django.utils import timezone

""" 
***************************************
               Специалности
***************************************
"""
class Specialty(models.Model):

    professional_field_num = models.CharField('Професионално направление - номер', max_length=3, default='', blank=True)
    professional_field_name = models.CharField('Професионално направление - име', max_length=100, default='', blank=True)
    profession_num = models.CharField('Професия - номер', max_length=6, default='', blank=True)
    profession_name = models.CharField('Професия - име', max_length=100, default='', blank=True)
    specialty_num = models.CharField('Специалност - номер', max_length=8, default='', blank=True)
    specialty_name = models.CharField('Специалност - име', max_length=100, default='', blank=True)
    nip = models.FileField('НИП', upload_to='docs/')

    def __str__(self):
        return f'{self.specialty_num}: {self.specialty_name}'

    class Meta:
        verbose_name = 'Специалност'
        verbose_name_plural = 'Специалности'

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
    logo = models.ImageField('Лого', upload_to='sys_pics', blank=True)
    address = models.CharField('Адрес', max_length=50, default='', blank=True,
                            help_text='Адрес в населеното място (ул. ... №...)')
    phone_number = models.CharField('Телефон', max_length=15, default='', blank=True)
    email = models.CharField('e-mail', max_length=35, default='', blank=True)
    boss = models.CharField('Директор', max_length=50, default='', blank=True,
                            help_text='Име на директора на училището')
    specialities = models.ManyToManyField(Specialty, verbose_name='Специалности', blank=True)

    def __str__(self):
        return f'{self.short_name} {self.city}'

    class Meta:
        verbose_name = 'Училище/организация'
        verbose_name_plural = 'Училища/организации'

""" 
***************************************
            Документи
***************************************
"""
class Documents(models.Model):
    title = models.CharField('Име', max_length=200)
    attachment = models.FileField('Файл', upload_to='docs/')

    def __str__(self):
        return self.title

    class Meta:
        verbose_name = 'Документ'
        verbose_name_plural = 'Документи'

"""
***************************************
            Потребители
***************************************
"""
class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    gender = models.BooleanField('Пол', default=True, choices=[(True, 'мъж'), (False, 'жена'), ] )
    school = models.ForeignKey(School, on_delete=models.CASCADE, related_name='user_school', verbose_name='училище',
                               null=True, blank=True)
    access_level = models.PositiveSmallIntegerField('Роля', choices=USER_LEVEL, default=STUDENT,
                                                    help_text='роля (ниво на достъп)')
    session_screen = models.PositiveSmallIntegerField('Интерфейс', choices=THEME_TYPE, default=DARK,
                                                      help_text='цветова схема на интерфейса')
    session_theme = models.PositiveSmallIntegerField('Тема', default=1,
                                                     validators=[ MinValueValidator(1), MaxValueValidator(18) ],
                                                     help_text='номер на тема от НИП по подразбиране')
    speciality = models.ForeignKey(Specialty, verbose_name='Специалност', on_delete=models.CASCADE, related_name='user_speciality',
                                   help_text='специалност по подразбиране', null=True, blank=True)

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
    specialty = models.ForeignKey(Specialty,  on_delete=models.CASCADE, related_name='items')
    num = models.PositiveSmallIntegerField('Тема №', default=1, help_text='№ на тема: 1, 2, ... 18')
    title = models.TextField('Заглавие', help_text='Заглавие на темата')
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

class TaskContext(models.Model):
    text = models.TextField('Контекст', default='', blank=True, help_text='Общ текстов контекст за въпросите')
    picture = models.ImageField('Картинка', upload_to='context_pics', blank=True,
                                null=True, help_text='Обща картинка за въпросите')
    author = models.ForeignKey(School, on_delete=models.CASCADE, default=1)
    textWrap = models.CharField('Разположение на текста', max_length=1, default='s', blank=True,
                                help_text='Разположение на текста спрямо картинката (e,w,n,s)')
    def __str__(self):
        return f"Контекст {self.id}: {self.text[:50]}..."  # Показва първите 50 символа от текста

    class Meta:
        verbose_name = 'Контекст'
        verbose_name_plural = 'Контексти'


# Въпроси - формулировка
class TaskManager(models.Manager):
    def create_task(self, itm):
        item = self.create(item=itm)
        return item


class Task(models.Model):
    item = models.ForeignKey(ThemeItem, on_delete=models.CASCADE, null=True, related_name='tasks')
    text = models.TextField('Въпрос', default='', blank=True, help_text='Формулировка (текст) на въпроса')
    type = models.PositiveSmallIntegerField(choices=TASK_TYPE, default=TYPE1, help_text='тип на въпроса')
    level = models.PositiveSmallIntegerField(choices=LEVEL_TYPE, default=LEVEL1, help_text='ниво на въпроса по Блум')
    school = models.ManyToManyField(School, verbose_name='id на училище в което се ползва', blank=True)
    picture = models.ImageField('Картинка', upload_to='task_pics', blank=True)
    group = models.PositiveSmallIntegerField(default=0, help_text='0 - ако не е групирано')
    author = models.ForeignKey(School, on_delete=models.CASCADE, related_name='author_id', default=1)
    textWrap = models.CharField('Разположение на текста', max_length=1, default='s', blank=True,
                                help_text='Разположение на текста спрямо картинката (e,w,n,s)')
    context = models.ForeignKey(TaskContext, on_delete=models.SET_NULL, null=True, blank=True, related_name='tasks',
                                help_text='Контекст за въпроса')
    # данни за статистика по въпроси
    stat_attempts = models.IntegerField('Брой опити', default=0, help_text='колко пъти е изтеглен въпроса')
    stat_points = models.FloatField('Получени точки', default=0, help_text='колко точки общо е получено от отговори')

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


# Коментари към въпросите
class Remark(models.Model):
    user_id = models.IntegerField('id на потребител', default=0)
    user_name = models.CharField('име на потребител', max_length=50, default='', null=True)
    date = models.DateTimeField('дата и час', default=timezone.now, null=True)
    text = models.TextField('Коментар', default='', blank=True)
    task = models.ForeignKey(Task, on_delete=models.CASCADE, null=True, related_name='remarks')

    def __str__(self):
        return '('+str(self.date)+') '+self.user_name+'/ '+self.text

    class Meta:
        verbose_name = 'Коментар'
        verbose_name_plural = 'Коментари'

""" 
***************************************
        Логове 
***************************************
"""
class Log(models.Model):
    user_id = models.IntegerField('id на потребител', default=0)
    user_name = models.CharField('име на потребител', max_length=50, default='', null=True)
    action = models.CharField('Действие', max_length=200, default='')
    date = models.DateTimeField('дата и час', default=timezone.now, null=True)

    def __str__(self):
        return '('+str(self.date)+') '+self.user_name+'/ '+self.action

    class Meta:
        verbose_name = 'Действие'
        verbose_name_plural = 'Действия'



""" 
***************************************
        Статистика 
***************************************
"""
class Test(models.Model):
    user = models.ForeignKey(User,verbose_name='потребител', on_delete=models.CASCADE, default=1)
    theme = models.ForeignKey(Theme, verbose_name='тема', on_delete=models.CASCADE, default=1)
    spec = models.ForeignKey(Specialty, verbose_name='специалност', on_delete=models.CASCADE, default=1)
    points = models.IntegerField('получени точки', default=0)
    time = models.CharField('продължителност',  max_length=10, default='00:00:00')
    date = models.DateTimeField('дата и час', default=datetime.now, null=True)

    def __str__(self):
        return self.user_name

    class Meta:
        verbose_name = 'Тест'
        verbose_name_plural = 'Тестове'
