FROM alpine:3.7
COPY ./lineage /usr/local/bin/
RUN chmod 700 /usr/local/bin/lineage
RUN mkdir /data
COPY ./whitelist.txt /data/
RUN chmod a+r /data/whitelist.txt
ENTRYPOINT ["lineage"]
CMD ["-whitelist /data/whitelist.txt"]