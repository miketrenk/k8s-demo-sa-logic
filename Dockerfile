FROM python:3.6.6-alpine
COPY sa /app
WORKDIR /app
RUN apk --update add python py-pip openssl ca-certificates py-openssl wget
RUN apk --update add --virtual build-dependencies libffi-dev openssl-dev python-dev py-pip build-base \
  && pip3 install --upgrade pip \
  && pip3 install -r requirements.txt \
  && python3 -m textblob.download_corpora \
  && apk del build-dependencies
EXPOSE 5000
ENTRYPOINT ["python3"]
CMD ["sentiment_analysis.py"]
