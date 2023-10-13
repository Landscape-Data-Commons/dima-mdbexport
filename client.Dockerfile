FROM postgis/postgis:16-3.4 

RUN apt update && \
    apt install mdb-tools -y

CMD ["tail", "-f","/dev/null"]
# CMD ["entrypoint.sh"]