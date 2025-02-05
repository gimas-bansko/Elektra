"""
прехвърляне на данни за въпроси от старото приложение в новото
"""
import requests
HEADERS = {
    "Content-Type": "application/json"
}
OLD_SERVER = 'http://127.0.0.1:8000'
OLD_ALL_TASKS = '/diki/api/theme_items/'

def theme_items(theme=1):
    """Чете всички въпроси от дадена тема чрез API на старото приложение """

    response = requests.get(f'{OLD_SERVER}{OLD_ALL_TASKS}{theme}', headers=HEADERS)
    if response.status_code == 200:
        return response.json()  # Връща данните като Python речник/списък
    else:
        print(f"Грешка при четене от старото API: {response.status_code}")
        return None

if __name__ == "__main__":
    data = theme_items(1)
    if data is not None:
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
