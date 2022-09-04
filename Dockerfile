FROM registry.access.redhat.com/ubi8/ubi

# install packages
RUN yum install nginx -y

# set run command
COPY ./run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
