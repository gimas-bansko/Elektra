import os
import tempfile
import shutil
from django.conf import settings
from django.core.files import File
from django.contrib.staticfiles import finders
from .models import GeneratedTest, Theme, School, Specialty
from .dzi_test import generate_test
from .MakeDocs import make_test_doc, make_key_doc
from pprint import pprint
from datetime import date

def generate_test_and_key(theme_id, school_id, shuffle):
    """
    Генерира документи с тест и ключ за зададена тема и училище.
    Запазва резултатите в модела GeneratedTest.

    Args:
        theme_id (int): ID на темата
        school_id (int): ID на училището

    Returns:
        GeneratedTest: Инстанция на модела със запазените документи
    """
    # Проверяваме съществуването на темата и училището
    print(f'generate_test_and_key({theme_id}, {school_id}, {shuffle})')
    try:
        theme = Theme.objects.get(id=theme_id)
        school = School.objects.get(id=school_id)
        specialty = theme.specialty
        level = 'втора'
        if specialty.level==3:
            level = 'трета'
        params= {
            'theme': {
                'num': theme.num,
                'name': theme.title,
                },
            'school': {
                'short_name': school.short_name,
                'full_name': school.full_name,
                'city': school.city,
                'logo': school.logo.url if school.logo else '',
                'address': school.address,
                'phone_number': school.phone_number,
                'email': school.email,
                'boss': school.boss,
                },
            'specialty': {
                'level': level,
                'profession': specialty.profession_name,
                'specialty': specialty.specialty_name
                },
            'year_str': str(date.today().year),
        }
    except Theme.DoesNotExist:
        raise ValueError(f"Тема с ID={theme_id} не съществува")
    except School.DoesNotExist:
        raise ValueError(f"Училище с ID={school_id} не съществува")
    except Specialty.DoesNotExist:
        raise ValueError(f"Сшециалност с ID={theme.specialty} не съществува")

    # Генерираме данните за теста
    test_data = generate_test(theme_id=theme_id, user_school_id=school_id, shuffle=shuffle)

    if not test_data:
        raise ValueError(f"Не може да се генерира тест за тема {theme_id} и училище {school_id}")

    # Намираме пътищата към шаблоните, използвайки различни методи
    test_template_path = None
    key_template_path = None

    # Метод 1: Проверяваме директно в директорията на приложението
    app_static_dir = os.path.join(settings.BASE_DIR, 'elektra', 'main', 'static', 'docs')
    if os.path.exists(os.path.join(app_static_dir, 'test_template.docx')):
        test_template_path = os.path.join(app_static_dir, 'test_template.docx')
    if os.path.exists(os.path.join(app_static_dir, 'keys_template.docx')):
        key_template_path = os.path.join(app_static_dir, 'keys_template.docx')

    # Метод 2: Използваме Django static finders (работи и с collectstatic и без)
    if not test_template_path:
        test_static_path = finders.find('docs/test_template.docx')
        if test_static_path:
            test_template_path = test_static_path

    if not key_template_path:
        key_static_path = finders.find('docs/keys_template.docx')
        if key_static_path:
            key_template_path = key_static_path

    # Метод 3: Проверяваме в STATIC_ROOT (след collectstatic)
    if not test_template_path and hasattr(settings, 'STATIC_ROOT'):
        test_root_path = os.path.join(settings.STATIC_ROOT, 'docs', 'test_template.docx')
        if os.path.exists(test_root_path):
            test_template_path = test_root_path

    if not key_template_path and hasattr(settings, 'STATIC_ROOT'):
        key_root_path = os.path.join(settings.STATIC_ROOT, 'docs', 'keys_template.docx')
        if os.path.exists(key_root_path):
            key_template_path = key_root_path

    # Проверяваме дали сме намерили шаблоните
    if not test_template_path:
        checked_paths = [
            os.path.join(app_static_dir, 'test_template.docx'),
            f"Django finder result: {finders.find('docs/test_template.docx')}",
            os.path.join(settings.STATIC_ROOT if hasattr(settings, 'STATIC_ROOT') else '', 'docs', 'test_template.docx')
        ]
        paths_str = "\n".join(
            [f"- {p} (exists: {os.path.exists(p.split(': ')[1]) if ': ' in p else os.path.exists(p)})" for p in
             checked_paths])
        raise FileNotFoundError(f"Шаблонът на теста не е намерен. Проверени пътища:\n{paths_str}")

    if not key_template_path:
        checked_paths = [
            os.path.join(app_static_dir, 'keys_template.docx'),
            f"Django finder result: {finders.find('docs/keys_template.docx')}",
            os.path.join(settings.STATIC_ROOT if hasattr(settings, 'STATIC_ROOT') else '', 'docs', 'keys_template.docx')
        ]
        paths_str = "\n".join(
            [f"- {p} (exists: {os.path.exists(p.split(': ')[1]) if ': ' in p else os.path.exists(p)})" for p in
             checked_paths])
        raise FileNotFoundError(f"Шаблонът на ключа не е намерен. Проверени пътища:\n{paths_str}")

    # Създаваме временна директория за генериране на файловете
    temp_dir = tempfile.mkdtemp()

    # Задаваме имена на файловете
    test_filename = f"test_{theme.id}_{school.id}.docx"
    key_filename = f"key_{theme.id}_{school.id}.docx"

    test_output_path = os.path.join(temp_dir, test_filename)
    key_output_path = os.path.join(temp_dir, key_filename)

    try:
        # Генерираме документите
        test_path = make_test_doc(test_data, params, template_path=test_template_path, output_filename=test_output_path)
        key_path = make_key_doc(test_data, params, template_path=key_template_path, output_filename=key_output_path)

        # Търсим съществуващ обект GeneratedTest или създаваме нов
        # Забележка: от модела виждам, че използвате 'topic' вместо 'theme'
        generated_test, created = GeneratedTest.objects.get_or_create(
            topic=theme,
            school=school,
            defaults={'test_file': None, 'answer_key_file': None}
        )

        # Обновяваме файловете

        # Изтриваме старите файлове, ако съществуват,
        # иначе Django ще добави суфикс към името при конфликт!
        if generated_test.test_file and generated_test.test_file.storage.exists(generated_test.test_file.name):
            generated_test.test_file.delete(save=False)
        if generated_test.answer_key_file and generated_test.answer_key_file.storage.exists(
                generated_test.answer_key_file.name):
            generated_test.answer_key_file.delete(save=False)

            # Качваме новите файлове
        with open(test_path, 'rb') as test_file:
            generated_test.test_file.save(test_filename, File(test_file), save=False)
        with open(key_path, 'rb') as key_file:
            generated_test.answer_key_file.save(key_filename, File(key_file), save=False)
        # Записваме промените
        generated_test.save()

        # Връщаме създадения/обновения обект
        return generated_test

    except Exception as e:
        # В случай на грешка, предаваме я нагоре
        raise ValueError(f"Грешка при генериране на документи: {str(e)}")

    finally:
        # Почистване на временните файлове
        try:
            shutil.rmtree(temp_dir)
        except Exception as e:
            print(f"Грешка при изтриване на временните файлове: {e}")

