# FROM ubuntu:16.04
FROM tiangolo/uwsgi-nginx-flask:python3.7

ARG APP_2_PORT

RUN printenv

RUN apt-get update

RUN apt-get install -y libc-dev build-essential vim

WORKDIR /app
COPY ./datas/count_by_data.json /app/datas/count_by_data.json
COPY ./requirements.txt /app/requirements.txt
COPY ./ /app/

RUN pip install -U pip
RUN pip install -r /app/requirements.txt


EXPOSE ${APP_2_PORT}
CMD ["python", "app.py"]
