from django.contrib.auth.models import User  
from django.db import models  
from django.db.models.signals import post_save
from django.dispatch import receiver

# ****************************************
#             потребители
# ****************************************
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

