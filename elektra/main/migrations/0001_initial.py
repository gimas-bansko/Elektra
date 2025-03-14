# Generated by Django 4.2.17 on 2024-12-29 17:31

from django.conf import settings
import django.core.validators
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Documents',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(max_length=200, verbose_name='Име')),
                ('attachment', models.FileField(upload_to='docs/', verbose_name='Файл')),
            ],
            options={
                'verbose_name': 'Документ',
                'verbose_name_plural': 'Документи',
            },
        ),
        migrations.CreateModel(
            name='Log',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user_id', models.IntegerField(default=0, verbose_name='id на потрбител')),
                ('user_name', models.CharField(default='', max_length=50, null=True, verbose_name='име на потрбител')),
                ('action', models.CharField(default='', max_length=200, verbose_name='Действие')),
                ('date', models.DateTimeField(default=django.utils.timezone.now, null=True, verbose_name='дата и час')),
            ],
            options={
                'verbose_name': 'Действие',
                'verbose_name_plural': 'Действия',
            },
        ),
        migrations.CreateModel(
            name='School',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('short_name', models.CharField(blank=True, default='', help_text='Съкратено име на училището', max_length=20, verbose_name='Абревиатура')),
                ('full_name', models.TextField(blank=True, default='', help_text='Пълно име на училището', verbose_name='Име')),
                ('city', models.CharField(blank=True, default='', help_text='Населено място, където се намира училището', max_length=50, verbose_name='Населено място')),
                ('address', models.CharField(blank=True, default='', help_text='Адрес в населеното място (ул. ... №...)', max_length=50, verbose_name='Адрес')),
                ('phone_number', models.CharField(blank=True, default='', max_length=15, verbose_name='Телефон')),
                ('email', models.CharField(blank=True, default='', max_length=35, verbose_name='e-mail')),
                ('boss', models.CharField(blank=True, default='', help_text='Име на директора на училището', max_length=50, verbose_name='Директор')),
            ],
            options={
                'verbose_name': 'Училище/организация',
                'verbose_name_plural': 'Училища/организации',
            },
        ),
        migrations.CreateModel(
            name='Specialty',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('professional_field_num', models.CharField(blank=True, default='', max_length=3, verbose_name='Професионално направление - номер')),
                ('professional_field_name', models.CharField(blank=True, default='', max_length=100, verbose_name='Професионално направление - име')),
                ('profession_num', models.CharField(blank=True, default='', max_length=6, verbose_name='Професия - номер')),
                ('profession_name', models.CharField(blank=True, default='', max_length=100, verbose_name='Професия - име')),
                ('specialty_num', models.CharField(blank=True, default='', max_length=8, verbose_name='Специалност - номер')),
                ('specialty_name', models.CharField(blank=True, default='', max_length=100, verbose_name='Специалност - име')),
                ('nip', models.FileField(upload_to='docs/', verbose_name='НИП')),
            ],
            options={
                'verbose_name': 'Специалност',
                'verbose_name_plural': 'Специалности',
            },
        ),
        migrations.CreateModel(
            name='Task',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('num', models.PositiveSmallIntegerField(default=0, help_text='генерира се автоматично')),
                ('text', models.TextField(blank=True, default='', help_text='Формулировка (текст) на въпроса', verbose_name='Въпрос')),
                ('type', models.PositiveSmallIntegerField(choices=[(1, 'затворен тип без картинка'), (2, 'затворен тип с картинка'), (3, 'съпоставяне ляво --> дясно'), (4, 'съпоставяне картинка --> опции'), (5, 'отворен отговор')], default=1, help_text='тип на въпроса')),
                ('level', models.PositiveSmallIntegerField(choices=[(1, 'знание'), (2, 'разбиране'), (3, 'приложение'), (4, 'анализ')], default=1, help_text='ниво на въпроса по Блум')),
                ('picture', models.ImageField(blank=True, upload_to='task_pics', verbose_name='Картинка')),
                ('group', models.PositiveSmallIntegerField(default=0, help_text='0 - ако не е групирано')),
                ('mark_red', models.BooleanField(default=False, null=True, verbose_name='Червен маркер')),
                ('mark_green', models.BooleanField(default=False, null=True, verbose_name='Зелен маркер')),
                ('mark_yellow', models.BooleanField(default=False, null=True, verbose_name='Жълт маркер')),
            ],
            options={
                'verbose_name': 'Въпрос',
                'verbose_name_plural': 'Въпроси',
            },
        ),
        migrations.CreateModel(
            name='Theme',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('num', models.PositiveSmallIntegerField(default=1, help_text='№ на тема: 1, 2, ... 18', verbose_name='Тема №')),
                ('title', models.TextField(help_text='Заглавие на темата', verbose_name='Заглавие')),
                ('remark', models.TextField(blank=True, help_text='Допълнително указание или коментар към темата', verbose_name='Коментар/забележка')),
                ('tasks_total', models.PositiveSmallIntegerField(default=24, help_text='Максимален брой задачи', verbose_name='Общ брой задачи')),
                ('tasks_knowledge', models.PositiveSmallIntegerField(default=0, help_text='Знание - брой задачи ', verbose_name='Знание')),
                ('tasks_comprehension', models.PositiveSmallIntegerField(default=0, help_text='Разбиране - брой задачи ', verbose_name='Разбиране')),
                ('tasks_application', models.PositiveSmallIntegerField(default=0, help_text='Приложение - брой задачи ', verbose_name='Приложение')),
                ('tasks_analysis', models.PositiveSmallIntegerField(default=0, help_text='Анализ - брой задачи ', verbose_name='Анализ')),
            ],
            options={
                'verbose_name': 'Тема',
                'verbose_name_plural': 'Теми',
            },
        ),
        migrations.CreateModel(
            name='UserProfile',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('access_level', models.PositiveSmallIntegerField(choices=[(1, 'тъмна'), (2, 'светла')], default=5, help_text='роля (ниво на достъп)', verbose_name='Роля')),
                ('session_screen', models.PositiveSmallIntegerField(choices=[(1, 'тъмна'), (2, 'светла')], default=1, help_text='цветова схема на интерфейса', verbose_name='Интерфейс')),
                ('session_theme', models.PositiveSmallIntegerField(default=1, help_text='номер на тема от НИП по подразбиране', validators=[django.core.validators.MinValueValidator(1), django.core.validators.MaxValueValidator(100)], verbose_name='Тема')),
                ('school_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='user_school', to='main.school')),
                ('user', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
                ('Специалност', models.ForeignKey(help_text='специалност по подразбиране', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='user_speciality', to='main.specialty')),
            ],
            options={
                'verbose_name': 'Пофил на потребител',
                'verbose_name_plural': 'Пофили на потребител',
            },
        ),
        migrations.CreateModel(
            name='ThemeItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('item', models.PositiveSmallIntegerField(default=1, help_text='№ на точка в темата: 1, 2, ... ', verbose_name='Точка №')),
                ('title', models.TextField(help_text='Заглавие на точката', verbose_name='Заглавие')),
                ('criterion', models.TextField(help_text='Критерий за оценяване. За темата - забележка', verbose_name='Заглавие')),
                ('total_points', models.PositiveSmallIntegerField(default=20, help_text='Максимален брой точки', verbose_name='Точки max')),
                ('knowledge', models.PositiveSmallIntegerField(default=0, help_text='Знание - брой задачи ', verbose_name='Знание')),
                ('comprehension', models.PositiveSmallIntegerField(default=0, help_text='Разбиране - брой задачи ', verbose_name='Разбиране')),
                ('application', models.PositiveSmallIntegerField(default=0, help_text='Приложение - брой задачи ', verbose_name='Приложение')),
                ('analysis', models.PositiveSmallIntegerField(default=0, help_text='Анализ - брой задачи ', verbose_name='Анализ')),
                ('theme_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='items', to='main.theme')),
            ],
            options={
                'verbose_name': 'Тема - точка',
                'verbose_name_plural': 'Теми - точки',
            },
        ),
        migrations.CreateModel(
            name='TaskItem',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('leading_char', models.CharField(blank=True, default='', help_text='№ или буква', max_length=4, verbose_name='Водещ символ')),
                ('text', models.CharField(blank=True, default='', help_text='Формулировка (текст) на опцията(отговора)', max_length=200, verbose_name='Текст')),
                ('value', models.CharField(blank=True, default='', help_text='Отговор - стойност', max_length=20, verbose_name='Стойност')),
                ('value_name', models.CharField(blank=True, default='', help_text='Отговор - име', max_length=200, verbose_name='Стойност - име')),
                ('checked', models.BooleanField(help_text='Отговор за опции с маркиране', null=True, verbose_name='Отговор - маркирано')),
                ('checked_t', models.BooleanField(help_text='генерира се автоматично', null=True, verbose_name='Отговор - маркирано')),
                ('value_t', models.CharField(blank=True, default='', help_text='генерира се автоматично', max_length=20, verbose_name='Стойност')),
                ('task', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='options', to='main.task')),
            ],
            options={
                'verbose_name': 'Въпрос - опция',
                'verbose_name_plural': 'Въпроси - опции',
            },
        ),
        migrations.AddField(
            model_name='task',
            name='item',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, related_name='tasks_knowledge', to='main.themeitem'),
        ),
        migrations.AddField(
            model_name='task',
            name='school',
            field=models.ManyToManyField(blank=True, to='main.school', verbose_name='id на училище в което се ползва'),
        ),
        migrations.AddField(
            model_name='task',
            name='themes',
            field=models.ManyToManyField(blank=True, to='main.theme'),
        ),
        migrations.AddField(
            model_name='school',
            name='specialities',
            field=models.ManyToManyField(to='main.specialty', verbose_name='Езиково обучение'),
        ),
    ]
