import random
from .models import Theme, ThemeItem, Task, TaskItem


def generate_test(theme_id, user_school_id):
    """
    Generate a test for a given theme, applying the same rules as the JS startTest method.
    Returns a list of questions with options, randomized as per methodology.

    Parameters:
    theme_id (int): ID темы
    user_school_id (int): ID школы пользователя для фильтрации заданий
    """
    # Get the Theme and related ThemeItems
    theme = Theme.objects.get(id=theme_id)
    theme_items = ThemeItem.objects.filter(theme_id=theme).order_by('item')

    test = []
    seen_groups = set()

    # For each item in the theme ("точка по точка")
    for item in theme_items:
        # For each Bloom level (1-knowledge, 2-comprehension, 3-application, 4-analysis)
        for level_num, level_field in enumerate(['knowledge', 'comprehension', 'application', 'analysis'], start=1):
            # Number of questions required for this level
            level_nip = getattr(item, level_field)

            # Get all tasks for this item and Bloom level
            # Применяем фильтрацию по школе пользователя
            from django.db.models import Q
            # questions = list(Task.objects.filter(
            #     Q(item=item, level=level_num) &
            #     (Q(author=user_school_id) | Q(school__contains=[user_school_id]))
            # ))
            questions = list(Task.objects.filter(
                Q(item=item, level=level_num) &
                (Q(author=user_school_id) | Q(school=user_school_id))
            ))

            # Step 1: Remove duplicating groups
            cleaned_questions = []
            for q in questions:
                if q.group > 0:
                    if q.group in seen_groups:
                        continue  # Skip duplicate group
                    seen_groups.add(q.group)
                cleaned_questions.append(q)

            # Step 2: Randomly remove questions until only level_nip remain
            if len(cleaned_questions) > level_nip:
                cleaned_questions = random.sample(cleaned_questions, level_nip)

            # Step 3: For each selected task, build the question with options
            for q in cleaned_questions:
                # Generate options (deep copy for frontend filling)
                options = []
                for option in q.options.all().order_by('id'):
                    options.append({
                        "id": option.id,
                        "leading_char": option.leading_char,
                        "text": option.text,
                        "value": option.value,
                        "value_name": option.value_name,
                        "checked": option.checked,
                        "checked_t": False,  # As in original JS logic
                        "value_t": ""  # As in original JS logic
                    })
                test.append({
                    "id": q.id,
                    "text": q.text,
                    "type": q.type,
                    "level": q.level,
                    "options": options,
                    "group": q.group,
                    "context": q.context_id,
                    # Add more fields as needed (e.g. num, etc.)
                })

    # Final shuffle (Fisher–Yates)
    random.shuffle(test)
    # Numbering (optional, for frontend ease)
    for idx, q in enumerate(test, start=1):
        q['num'] = idx
    return test