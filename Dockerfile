FROM python:3.10

WORKDIR /usr/src/app

ADD ./flask_web ./var/www/flask_web
COPY ./requirements.txt ./var/www/flask_web/requirements.txt
RUN pip install --no-cache-dir -r ./var/www/flask_web/requirements.txt
#COPY ./flask_web/app.py /var/www/flask_web/app.py
WORKDIR ./var/www/flask_web
EXPOSE 5000
CMD ["python", "-m", "app"]