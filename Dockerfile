FROM python:3.6

RUN apt update

RUN mkdir /deploy/
RUN mkdir /deploy/sites/
RUN mkdir /deploy/sites/partner/
RUN mkdir /deploy/venvs/

RUN apt-get install -y nginx python3-dev supervisor
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3 get-pip.py
RUN pip install virtualenv

WORKDIR /deploy/venvs
RUN virtualenv env -p python3.6

WORKDIR /deploy/sites/partner

COPY . .

ADD gunicorn.conf /etc/supervisor/conf.d/

RUN pip install -r requirements.txt

ADD services.conf /etc/nginx/conf.d/

WORKDIR /deploy/sites/partner/

RUN python manage.py collectstatic

RUN nginx -t -c /etc/nginx/nginx.conf

RUN service nginx restart

ENV PORT 8080
ENV HOST 0.0.0.0

EXPOSE 8080

# RUN python3 manage.py makemigrations
# RUN python3 manage.py migrate

CMD [ "python3", "manage.py", "runserver", "0.0.0.0:8080"]