FROM python:3.7

WORKDIR /app

COPY hello.py /app
COPY requirements.txt /app

RUN pip install --upgrade pip

RUN pip install -r requirements.txt

CMD ["python", "hello.py"]
