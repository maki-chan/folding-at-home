# Folding@home
#
# VERSION               0.1
# Run with: docker run -d -t -i jordan0day/folding-at-home
# Inspired by magglass1/docker-folding-at-home

# Set environment variables USERNAME, TEAM, and POWER to customize your Folding client.

FROM fedora

# If you set USERNAME to Anonymous, the folding@home client pauses for 5 minutes, but will then begin processing data.
ENV USERNAME toughIQ
ENV TEAM 0
ENV POWER medium

# Install updates
RUN yum update -y

# Install Folding@home
RUN rpm -i https://fah.stanford.edu/file-releases/public/release/fahclient/centos-5.3-64bit/v7.3/fahclient-7.3.6-1.x86_64.rpm
ADD config.xml /etc/fahclient/
RUN chown fahclient:root /etc/fahclient/config.xml
RUN sed -i -e "s/{{USERNAME}}/$USERNAME/;s/{{TEAM}}/$TEAM/;s/{{POWER}}/$POWER/" /etc/fahclient/config.xml

CMD /etc/init.d/FAHClient start && tail -F /var/lib/fahclient/log.txt
