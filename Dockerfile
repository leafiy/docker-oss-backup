FROM jfloff/alpine-python:3.7

RUN apk --update add --no-cache bash zip

RUN pip install oss2
RUN rm -rf /src
RUN mkdir -p /src
WORKDIR /src
COPY backup.sh /src/backup.sh
COPY entrypoint.sh /src/entrypoint.sh
COPY upload.py /src/upload.py

VOLUME /oss-backups

CMD ["/src/entrypoint.sh"]