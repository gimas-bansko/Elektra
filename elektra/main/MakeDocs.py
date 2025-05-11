import os
import io
import json
import tempfile
from docxtpl import DocxTemplate, InlineImage
from docx.shared import Mm
from PIL import Image
from django.conf import settings
from pprint import pprint


def get_media_path(relative_path):
    """
    Връща абсолютния път към медиен файл
    """
    if not relative_path:
        return None

    # Премахваме началните слашове и 'media_files' от пътя, ако съществуват
    clean_path = relative_path
    if clean_path.startswith('/'):
        clean_path = clean_path[1:]
    if clean_path.startswith('media_files/'):
        clean_path = clean_path[len('media_files/'):]
    if clean_path.startswith('media/'):
        clean_path = clean_path[len('media/'):]
    if clean_path.startswith('_files/'):
        clean_path = clean_path[len('_files/'):]

    # Създаваме списък с възможни пътища
    possible_paths = [
        os.path.join(settings.MEDIA_ROOT, clean_path),
        os.path.join(settings.MEDIA_ROOT, '_files', clean_path),
        os.path.join(settings.MEDIA_ROOT, relative_path.lstrip('/')),
        os.path.normpath(relative_path)  # Ако пътят вече е абсолютен
    ]

    # Проверяваме всеки път
    for path in possible_paths:
        if os.path.exists(path):
            return path

    # Ако файлът не е намерен, записваме дебъг информация
    debug_info = f"Файлът не е намерен: {relative_path}\nПроверени пътища:\n"
    for path in possible_paths:
        debug_info += f"- {path} (съществува: {os.path.exists(path)})\n"

    print(debug_info)  # Извеждаме в конзолата за дебъгване

    # Връщаме първия път, въпреки че файлът не съществува
    # Грешката ще бъде обработена в извикващата функция
    return None


def make_test_doc(questions, common_data, template_path=None, output_filename=None):
    """
    Създава документ с тест на базата на шаблон

    Args:
        questions: Списък с въпроси и варианти за отговор
        template_path: Път към шаблона на Word
        output_filename: Име на изходния файл

    Returns:
        Път към създадения файл
    """
    doc_context = {
        'theme': common_data['theme'],
        'school': common_data['school'],
        'specialty': common_data['specialty'],
        'year_str': common_data['year_str'],
    }

    # Ако не е предоставен шаблон, използваме подразбиращ се от папката static/docs
    if not template_path:
        template_path = os.path.join(settings.BASE_DIR, 'main', 'static', 'docs', 'test_template.docx')

    # Ако не е предоставено изходно име, създаваме временен файл
    if not output_filename:
        temp_fd, output_filename = tempfile.mkstemp(suffix='.docx')
        os.close(temp_fd)

    # Зареждаме шаблона
    doc = DocxTemplate(template_path)

    # Временна директория за изображения
    temp_dir = tempfile.mkdtemp()

    # Обработваме изображенията
    temp_files = []

    #  Лого на училището
    logo_rel_path = common_data['school']['logo']
    if logo_rel_path:  # има ли лого?
        logo_abs_path = get_media_path(logo_rel_path)
        if os.path.exists(logo_abs_path):
            doc_context['school_logo'] = InlineImage(doc, logo_abs_path, width=Mm(19))
        else:
            doc_context['school_logo'] = ''
    else:
        doc_context['school_logo'] = ''

    for q in questions:
        # Обработка на изображение на въпроса
        if q.get('picture'):
            try:
                temp_img_path = os.path.join(temp_dir, f"question_{q['id']}.png")
                # Получаваме абсолютния път към изображението
                if q['picture'].startswith(('http://', 'https://')):
                    # За URL използваме requests
                    import requests
                    response = requests.get(q['picture'], stream=True)
                    img = Image.open(io.BytesIO(response.content))
                    img.save(temp_img_path)
                else:
                    # За локални файлове
                    img_path = get_media_path(q['picture'])
                    if img_path and os.path.exists(img_path):
                        img = Image.open(img_path)
                        img.save(temp_img_path)
                    else:
                        # Ако изображението не е намерено, пропускаме го
                        print(f"Изображението на въпроса не е намерено: {q['picture']}")
                        q['image'] = None
                        continue
                img_width = 90
                if q['textWrap'] in {'n','s'}:
                    img_width *= 2
                q['image'] = InlineImage(doc, temp_img_path, width=Mm(img_width))
                temp_files.append(temp_img_path)
            except Exception as e:
                print(f"Грешка при обработка на изображението на въпроса: {e}")
                q['image'] = None

        # Обработка на контекста
        if q.get('context') and q['context'].get('picture'):
            try:
                context = q['context']
                temp_img_path = os.path.join(temp_dir, f"context_{q['id']}.png")

                # Получаваме абсолютния път към изображението
                if context['picture'].startswith(('http://', 'https://')):
                    import requests
                    response = requests.get(context['picture'], stream=True)
                    img = Image.open(io.BytesIO(response.content))
                    img.save(temp_img_path)
                else:
                    img_path = get_media_path(context['picture'])
                    if img_path and os.path.exists(img_path):
                        img = Image.open(img_path)
                        img.save(temp_img_path)
                    else:
                        # Ако изображението не е намерено, пропускаме го
                        print(f"Изображението на контекста не е намерено: {context['picture']}")
                        context['image'] = None
                        continue
                img_width = 90
                if context['textWrap'] in {'n','s'}:
                    img_width *= 2
                context['image'] = InlineImage(doc, temp_img_path, width=Mm(img_width))
                temp_files.append(temp_img_path)
            except Exception as e:
                print(f"Грешка при обработка на изображението на контекста: {e}")
                context['image'] = None

    # Тук е КЛЮЧОВИЯТ ФИКс:
    # Уверяваме се, че всички числови стойности са числа, а не низове
    for q in questions:
        # Конвертираме 'num', 'id' и други числови полета към int
        if 'num' in q and isinstance(q['num'], str):
            q['num'] = int(q['num'])
        if 'id' in q and isinstance(q['id'], str):
            q['id'] = int(q['id'])

        # Ако има опции, проверяваме и тях
        if 'options' in q:
            for option in q['options']:
                if 'id' in option and isinstance(option['id'], str):
                    option['id'] = int(option['id'])
                if 'num' in option and isinstance(option['num'], str):
                    option['num'] = int(option['num'])

    # Сортираме въпросите по номер (ако има такъв)
    questions_sorted = sorted(questions, key=lambda x: int(x['num']) if isinstance(x['num'], str) else x['num'])

    # Създаваме контекст за шаблона
    doc_context['questions'] = questions_sorted
    doc_context['tasks_num'] = len(questions)

    # Рендерираме шаблона
    doc.render(doc_context)
    # Записваме резултата
    doc.save(output_filename)

    # Почистваме временните файлове
    for temp_file in temp_files:
        try:
            os.remove(temp_file)
        except Exception as e:
            print(f"Грешка при изтриване на временния файл: {e}")

    try:
        import shutil
        shutil.rmtree(temp_dir)
    except Exception as e:
        print(f"Грешка при изтриване на временната директория: {e}")

    return output_filename


def make_key_doc(questions, common_data, template_path=None, output_filename=None):
    """
    Създава документ с отговори (ключ) на базата на шаблон

    Args:
        questions: Списък с въпроси и варианти за отговор
        template_path: Път към шаблона на Word
        output_filename: Име на изходния файл

    Returns:
        Път към създадения файл
    """

    doc_context = {
        'theme': common_data['theme'],
        'school': common_data['school'],
        'specialty': common_data['specialty'],
        'year_str': common_data['year_str'],
    }

    # Ако не е предоставен шаблон, използваме подразбиращ се от папката static/docs
    if not template_path:
        template_path = os.path.join(settings.BASE_DIR, 'main', 'static', 'docs', 'keys_template.docx')

    # Ако не е предоставено изходно име, създаваме временен файл
    if not output_filename:
        temp_fd, output_filename = tempfile.mkstemp(suffix='.docx')
        os.close(temp_fd)

    # Зареждаме шаблона
    doc = DocxTemplate(template_path)

    #  Лого на училището
    logo_rel_path = common_data['school']['logo']
    if logo_rel_path:  # има ли лого?
        logo_abs_path = get_media_path(logo_rel_path)
        if os.path.exists(logo_abs_path):
            doc_context['school_logo'] = InlineImage(doc, logo_abs_path, width=Mm(19))
        else:
            doc_context['school_logo'] = ''
    else:
        doc_context['school_logo'] = ''

    # Тук е КЛЮЧОВИЯТ ФИКс:
    # Уверяваме се, че всички числови стойности са числа, а не низове
    for q in questions:
        # Конвертираме 'num', 'id' и други числови полета към int
        if 'num' in q and isinstance(q['num'], str):
            q['num'] = int(q['num'])
        if 'id' in q and isinstance(q['id'], str):
            q['id'] = int(q['id'])

        # Ако има опции, проверяваме и тях
        if 'options' in q:
            for option in q['options']:
                if 'id' in option and isinstance(option['id'], str):
                    option['id'] = int(option['id'])
                if 'num' in option and isinstance(option['num'], str):
                    option['num'] = int(option['num'])

# ------------------------------------------------
        # определям броя отговори и броя верни отговори
        numOkBase = 0   # брой верни отговори по ключ
        numOptions = len(q['options'])  #  брой отговори към въпроса
        q['points'] = q['level']*2
        if q['type'] < 3: #  затворен отговор
            for option in q['options']:
                if option['checked']:
                    numOkBase += 1
            if numOkBase == 1:
                key_list = [f'при посочен верен отговор - {q["points"]} точки;',
                                'във всички останали случаи - 0 точки',
                                ]
            else:
                key_list = [f'при посочен 1 верен отговор - {round(q["points"]*(1/numOkBase), 2)} точки;',]
                for i in range(2,numOkBase):
                    key_list.append(f'при посочен {i} верни отговора - {round(q["points"]*(i/numOkBase), 2)} точки;')
                key_list.append(f'при посочени {numOkBase} верни отговора - {q["points"]} точки')
                key_list.append(f'при посочени повече от {numOkBase} отговора - 0 точки')
                key_list.append('във всички останали случаи  - 0 точки')
            q['key_list'] = key_list
        elif q['type']<5:
            s = round(q["points"]*(1/numOptions), 2)
            p = ' точки'
            if s == 1.00:
                p = ' точка'
            q['ok'] = str(s)+p

# ------------------------------------------------

    # Сортираме въпросите по номер (ако има такъв)
    questions_sorted = sorted(questions, key=lambda x: int(x['num']) if isinstance(x['num'], str) else x['num'])

    # Създаваме контекст за шаблона
    doc_context['questions'] = questions_sorted
    doc_context['tasks_num'] = len(questions)

    # Рендерираме шаблона
    pprint(doc_context)
    doc.render(doc_context)

    # Записваме резултата
    doc.save(output_filename)

    return output_filename