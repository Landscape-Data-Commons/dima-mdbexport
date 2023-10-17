FROM postgis/postgis:16-3.4 

RUN apt update && \
    apt install mdbtools -y

# CMD ["tail", "-f","/dev/null"]
CMD ["./client-bind/export.sh"]