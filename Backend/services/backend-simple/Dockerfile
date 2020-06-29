# FROM ubuntu:16.04
FROM tiangolo/uwsgi-nginx-flask:python3.7

RUN apt-get update

RUN apt-get install -y libc-dev build-essential vim

ARG APP_1_PORT

WORKDIR /app
COPY ./requirements.txt /app/requirements.txt
COPY ./ /app/

RUN pip install -U pip
RUN pip install -r /app/requirements.txt

EXPOSE ${APP_1_PORT}
CMD ["python", "app.py"]
