FROM phusion/baseimage 

RUN mkdir /mymdb 
WORKDIR /mymdb 
COPY requirements* /mymdb/
COPY mymdb/ mymdb/ 
RUN mkdir /var/log/mymdb/
RUN touch /var/log/mymdb/mymdb.log
RUN apt-get -y update
RUN apt-get install -y \
    nginx \
    postgresql-client \ 
    python3 \
    python3-pip 
RUN  pip3 install virtualenv 
RUN virtualenv /mymdb/venv 
RUN bash /mymdb/scripts/pip_install.sh /mymdb 
RUN bash /mymdb/scripts/collect_static.sh /mymdb 
COPY nginx/mymdb.conf /etc/nginx/sites-available/mymdb.conf 
RUN rm /etc/nginx/sites-enabled/*
RUN ln -s /etc/nginx/sites-available/mymdb.conf /etc/nginx/sites-available/mymdb.conf 
COPY runit/nginx /etc/service/nginx 
RUN  chmod +x /etc/service/nginx/run 

COPY uwsgi/mymdb.ini /etc/uswgi/apps-enabled/mymdb.ini 
RUN mkdir -p /var/log/uswgi/
RUN touch /var/log/uwsgi/mymdb.log 
RUN chown www-data /var/log/uwsgi/mymdb.log 
RUN chown www-data /var/log/mymdb/mymdb.log 

COPY runit/uwsgi /etc/service/uswgi
RUN chmod +x /etc/service/uwsgi/run 