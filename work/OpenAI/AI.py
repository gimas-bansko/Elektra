from openai import OpenAI
import argparse  
import json  

# Задайте вашия OpenAI API ключ
client = OpenAI(
  api_key ="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"
)

def check_answer(question, example_answer, student_answer):  
    """  
    Проверява дали отговорът на ученика е правилен, използвайки OpenAI API.  
    """  
    try:  
        # Формулиране на prompt за OpenAI  
        prompt = f"""  
You are a teacher grading a student's answer to a question.   
The question is: "{question}"  
The correct answer is: "{example_answer}"  
The student's answer is: "{student_answer}"  

Is the student's answer correct? Respond with "Yes" or "No" and provide a brief explanation.  
"""  

        # Изпращане на заявка към OpenAI API  
        response = client.chat.completions.create(
            model="gpt-4",  # Можете да използвате и "gpt-3.5-turbo"  
            messages=[  
                {"role": "system", "content": "You are a helpful assistant."},  
                {"role": "user", "content": prompt},  
            ],  
            max_tokens=100,  
            temperature=0.2,  # По-ниска стойност за по-конкретни отговори  
        )  

        # Извличане на отговора от OpenAI  
        ai_response = response.choices[0].message.content.strip()  

        return ai_response  

    except Exception as e:  
        return f"Error: {str(e)}"  

if __name__ == "__main__":  

    qst = input('Въпрос: ')
    ea = input('Примерен отговор: ')
    sa = input('Даден отговор: ')
    # Извикване на функцията за проверка
    result = check_answer(qst, ea, sa)
    print(result)

    # Печат на резултата  
