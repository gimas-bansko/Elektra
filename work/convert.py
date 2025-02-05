import requests

# URL на API на старото приложение
OLD_API_URL = "http://old-app.com/api/themes/"
# URL на API на новото приложение
NEW_API_URL = "http://new-app.com/api/themes/"

# Ако API изисква автентикация, добави токен или потребителски данни
HEADERS_OLD = {
    "Authorization": "Bearer YOUR_OLD_APP_TOKEN",  # Замени с токена за старото приложение
    "Content-Type": "application/json"
}

HEADERS_NEW = {
    "Authorization": "Bearer YOUR_NEW_APP_TOKEN",  # Замени с токена за новото приложение
    "Content-Type": "application/json"
}

def fetch_data_from_old_api():
    """Чете данни от API на старото приложение"""
    response = requests.get(OLD_API_URL, headers=HEADERS_OLD)
    if response.status_code == 200:
        return response.json()  # Връща данните като Python речник/списък
    else:
        print(f"Грешка при четене от старото API: {response.status_code}")
        return None

def post_data_to_new_api(data):
    """Записва данни в API на новото приложение"""
    response = requests.post(NEW_API_URL, headers=HEADERS_NEW, json=data)
    if response.status_code == 201:  # 201 Created
        print("Данните са успешно записани в новото приложение.")
    else:
        print(f"Грешка при запис в новото API: {response.status_code}")
        print(response.text)

def migrate_data():
    """Прехвърля данни от старото приложение към новото"""
    old_data = fetch_data_from_old_api()
    if old_data:
        for item in old_data:
            # Тук можеш да трансформираш данните, ако структурата е различна
            transformed_data = transform_data(item)
            post_data_to_new_api(transformed_data)

def transform_data(item):
    """Трансформира данните, ако структурата е различна"""
    # Пример за трансформация: промяна на имената на полетата
    return {
        "new_field_1": item["old_field_1"],
        "new_field_2": item["old_field_2"],
        # Добави други трансформации, ако е необходимо
    }

if __name__ == "__main__":
    migrate_data()