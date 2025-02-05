# pip install openai
from openai import OpenAI

client = OpenAI(
  api_key="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"
)

completion = client.chat.completions.create(
  model="gpt-4o-mini",
  store=True,
  messages=[
    {"role": "user", "content": "write a haiku about ai"}
  ]
)

print(completion.choices[0].message);
