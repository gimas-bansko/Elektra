# document_generation.py
from django.conf import settings
from docxtpl import DocxTemplate, InlineImage
from docx.shared import Mm, Pt
import os
import uuid
from PIL import Image
import io
import requests
from django.core.files.storage import default_storage


def get_template_path(template_name):
    """Връща пътя до шаблонен файл"""
    return os.path.join(settings.MEDIA_ROOT, 'templates', template_name)


def get_output_path(filename):
    """Генерира път за изходен файл"""
    if not filename.endswith('.docx'):
        filename += '.docx'
    return os.path.join(settings.MEDIA_ROOT, 'generated', filename)


def load_image_from_path(path, is_url=False):
    """
    Зарежда изображение от път (може да бъде локален път или URL)

    Args:
        path: Път към изображението
        is_url: Дали пътят е URL

    Returns:
        Временен път към изображението за включване в документ
    """
    temp_dir = os.path.join(settings.MEDIA_ROOT, 'temp')
    os.makedirs(temp_dir, exist_ok=True)

    temp_path = os.path.join(temp_dir, f"{uuid.uuid4()}.png")

    if is_url:
        # Ако е URL, изтегляме изображението
        response = requests.get(path, stream=True)
        response.raise_for_status()
        with open(temp_path, 'wb') as f:
            for chunk in response.iter_content(chunk_size=8192):
                f.write(chunk)
    else:
        # Ако е локален път, копираме изображението
        # Първо проверяваме дали пътят е относителен към MEDIA_URL
        if path.startswith(settings.MEDIA_URL):
            path = path[len(settings.MEDIA_URL):]

        # Построяваме абсолютния път
        abs_path = os.path.join(settings.MEDIA_ROOT, path)

        # Проверяваме дали файлът съществува
        if os.path.exists(abs_path):
            # Копираме изображението
            with open(abs_path, 'rb') as f_in:
                with open(temp_path, 'wb') as f_out:
                    f_out.write(f_in.read())
        else:
            raise FileNotFoundError(f"Изображението не е намерено: {abs_path}")

    return temp_path


def make_test_doc(test_questions, template_path=None, output_filename=None):
    """
    Създава Word документ с тест по списък от въпроси, използвайки docxtpl

    Args:
        test_questions: Списък от речници с въпроси и опции
        template_path: Път до шаблонен файл (или None за чист документ)
        output_filename: Име на изходния файл (или автоматично генерирано)

    Returns:
        Път до генерирания файл
    """
    # Ако не е предоставен шаблон, използваме стандартен
    if not template_path:
        template_path = get_template_path('test_template.docx')

        # Ако стандартният шаблон не съществува, създаваме празен документ
        if not os.path.exists(template_path):
            from docx import Document
            doc = Document()
            os.makedirs(os.path.dirname(template_path), exist_ok=True)
            doc.save(template_path)

    # Създаваме контекст за шаблона
    context = {}

    # Подготвяме въпросите с изображения
    temp_files = []  # Списък за проследяване на временни файлове

    # Обработка на контекстите и изображенията
    for i, q in enumerate(test_questions):
        # Номериране
        q['num'] = i + 1

        # Обработка на изображение на въпроса
        if q.get('picture'):
            try:
                is_url = q['picture'].startswith('http')
                temp_path = load_image_from_path(q['picture'], is_url)
                q['image'] = InlineImage(None, temp_path, width=Mm(90))
                temp_files.append(temp_path)
            except Exception as e:
                print(f"Грешка при обработка на изображение: {e}")

        # Обработка на контекст, ако има такъв
        if q.get('context'):
            context_data = q['context']
            if context_data.get('picture'):
                try:
                    is_url = context_data['picture'].startswith('http')
                    temp_path = load_image_from_path(context_data['picture'], is_url)
                    context_data['image'] = InlineImage(None, temp_path, width=Mm(120))
                    temp_files.append(temp_path)
                except Exception as e:
                    print(f"Грешка при обработка на изображение на контекст: {e}")

    # Добавяме въпросите в контекста
    context['questions'] = test_questions

    # Зареждаме шаблона
    doc = DocxTemplate(template_path)

    # Актуализираме всички InlineImage обекти с правилния документ
    for q in test_questions:
        if 'image' in q:
            q['image'].docx = doc
        if q.get('context') and 'image' in q['context']:
            q['context']['image'].docx = doc

    # Рендиране на шаблона
    doc.render(context)

    # Определяне на изходния път
    if not output_filename:
        output_filename = f"test_{uuid.uuid4()}.docx"

    output_path = get_output_path(output_filename)
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    # Запазване на документа
    doc.save(output_path)

    # Почистване на временните файлове
    for temp_file in temp_files:
        try:
            os.remove(temp_file)
        except:
            pass

    return output_path


def make_key_doc(test_questions, template_path=None, output_filename=None):
    """
    Създава Word документ с ключове към тест, използвайки docxtpl

    Args:
        test_questions: Списък от речници с въпроси и опции
        template_path: Път до шаблонен файл (или None за чист документ)
        output_filename: Име на изходния файл (или автоматично генерирано)

    Returns:
        Път до генерирания файл
    """
    # Ако не е предоставен шаблон, използваме стандартен
    if not template_path:
        template_path = get_template_path('keys_template.docx')

        # Ако стандартният шаблон не съществува, създаваме празен документ
        if not os.path.exists(template_path):
            from docx import Document
            doc = Document()
            os.makedirs(os.path.dirname(template_path), exist_ok=True)
            doc.save(template_path)

    # Подготовка на ключове
    for q in test_questions:
        # Определяне на точки
        level = q.get('level', 1)
        if level == 1:
            points = 2
        elif level == 2:
            points = 4
        elif level == 3:
            points = 6
        else:  # level 4 или друго
            points = 8

        q['points'] = points

        # Определяне на ключове
        q_type = q.get('type', 1)
        options = q.get('options', [])

        # Броим верните отговори
        correct_options = [opt for opt in options if opt.get('value', 0) > 0]
        num_correct = len(correct_options)
        num_options = len(options)

        if q_type < 3:  # Затворен отговор
            if num_correct == 1:
                q['key_list'] = [
                    f'при посочен верен отговор - {points} точки;',
                    'във всички останали случаи - 0 точки',
                ]
            else:
                key_list = [f'при посочен 1 верен отговор - {round(points * (1 / num_correct), 2)} точки;']
                for i in range(2, num_correct):
                    key_list.append(f'при посочени {i} верни отговора - {round(points * (i / num_correct), 2)} точки;')
                key_list.append(f'при посочени {num_correct} верни отговора - {points} точки')
                key_list.append(f'при посочени повече от {num_correct} отговора - 0 точки')
                key_list.append('във всички останали случаи - 0 точки')
                q['key_list'] = key_list
        elif q_type < 5:  # Отворен отговор
            s = round(points * (1 / num_options), 2)
            p = ' точки'
            if s == 1.00:
                p = ' точка'
            q['ok'] = str(s) + p

    # Създаваме контекст за шаблона
    context = {
        'questions': test_questions
    }

    # Зареждаме шаблона
    doc = DocxTemplate(template_path)

    # Рендиране на шаблона
    doc.render(context)

    # Определяне на изходния път
    if not output_filename:
        output_filename = f"key_{uuid.uuid4()}.docx"

    output_path = get_output_path(output_filename)
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    # Запазване на документа
    doc.save(output_path)

    return output_path