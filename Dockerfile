FROM drecom/centos-base:latest

RUN cd /
RUN yum update -y
RUN yum install -y python34 python-pip
RUN yum install -y python-django
RUN yum install -y epel-release yum-utils
RUN yum install -y nodejs
RUN yum install -y git

RUN mkdir -p /opt/beautifulmind/
RUN cd /opt/beautifulmind/
RUN git clone https://github.com/person896/BeautifulMind.io.git www
RUN cd www
RUN cd www && git checkout production
RUN chown -R www-data:www-data /opt/beautifulmind/

RUN cd beautifulmind
RUN pip install -U pip
RUN pip install -U virtualenv
RUN virtualenv --no-site-packages virtualenv
RUN source virtualenv/bin/activate
RUN pip install -r REQUIREMENTS
RUN cd /opt/beautifulmind/www/beautifulmind && ./manage.py syncdb
RUN cd /opt/beautifulmind/www/beautifulmind && ./manage.py migrate

WORKDIR /opt/beautifulmind/www/beautifulmind

CMD [ "bash", "start.sh" ]