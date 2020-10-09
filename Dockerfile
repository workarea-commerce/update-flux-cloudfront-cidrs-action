FROM python:latest

RUN apt-get update
RUN apt-get install -y jq curl bash
RUN pip3 install yq

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]