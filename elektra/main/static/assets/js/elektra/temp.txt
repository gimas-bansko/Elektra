"""
прехвърляне на данни за въпроси от старото приложение в новото
"""
import requests
HEADERS = {
    "Content-Type": "application/json"
}
OLD_SERVER = 'http://127.0.0.1:8000'

NEW_SERVER = 'http://127.0.0.1:8008'
NEW_ALL_TASKS = '/api/theme_items/'

def theme_items(theme=1):
    """Чете всички въпроси от дадена тема чрез API на старото приложение """

    response = requests.get(f'{OLD_SERVER}/diki/api/theme_items/{theme}', headers=HEADERS)
    if response.status_code == 200:
        return response.json()  # Връща данните като Python речник/списък
    else:
        print(f"Грешка при четене от старото API: {response.status_code}")
        return None

def transform_data(item):
    """Трансформира данните, ако структурата е различна"""
    # Пример за трансформация: промяна на имената на полетата
    return {
        "new_field_1": item["old_field_1"],
        "new_field_2": item["old_field_2"],
        # Добави други трансформации, ако е необходимо
    }


def migrate_data():
    """Прехвърля данни от старото приложение към новото"""
    for i in range(18):
        old_data = theme_items(i+1)
        if old_data:
            for item in old_data:
                # Тук можеш да трансформираш данните, ако структурата е различна
                transformed_data = transform_data(item)
                post_data_to_new_api(transformed_data)

def post_data_to_new_api(task_data):
    """Записва данни в API на новото приложение"""
    response = requests.post(NEW_API_URL, headers=HEADERS_NEW, json=task_data)
    if response.status_code == 201:  # 201 Created
        print("Данните са успешно записани в новото приложение.")
    else:
        print(f"Грешка при запис в новото API: {response.status_code}")
        print(response.text)

if __name__ == "__main__":
    data = theme_items(1)
    if data:
        for obj in data:
            print(obj["id"],'/',obj["item"])
            print(obj["title"])
            print(obj["criterion"])
            print(obj["total_points"], obj["knowledge"],obj["comprehension"],obj["application"],obj["analysis"])
            print("tasks_knowledge:")
            for task in obj["tasks_knowledge"]:
                print(f'    {task}')
            print("tasks_comprehension:")
            for task in obj["tasks_comprehension"]:
                print(f'    {task}')
            print("tasks_application:")
            for task in obj["tasks_application"]:
                print(f'    {task}')
            print("tasks_analysis:")
            for task in obj["tasks_analysis"]:
                print(f'    {task}')
