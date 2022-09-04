FROM registry.access.redhat.com/ubi8/ubi
RUN yum install nginx -y
COPY ./run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/run.sh"]
