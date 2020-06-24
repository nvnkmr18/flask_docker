FROM ubuntu:20.04

WORKDIR /usr/src/app

#COPY requirements.txt .

RUN apt-get update
RUN apt-get install -y python3 python3-pip

#copy all source to /usr/src/app
COPY . .

RUN python3 setup.py install

EXPOSE 5000
#CMD ["python", "app.py"]

CMD gunicorn --worker-class gevent --workers 8 --bind 0.0.0.0:5000 run:app --max-requests 10000 --timeout 5 --keep-alive 5 --log-level info