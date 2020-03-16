### Dockerfile
# Purpose: This file will create Ubuntu Based image, which openssh server and root password configured 
FROM ubuntu:latest
MAINTAINER "Nilesh Attarde"
RUN echo exit 0 > /usr/sbin/policy-rc.d && \
    apt-get update -y && apt-get clean all && apt-get install -y systemd systemd-sysv sudo passwd openssh-server
RUN cd /lib/systemd/system/sysinit.target.wants/ \
    && ls | grep -v systemd-tmpfiles-setup | xargs rm -f $1 \
    rm -f /lib/systemd/system/multi-user.target.wants/* \
    /etc/systemd/system/*.wants/* \
    /lib/systemd/system/local-fs.target.wants/* \
    /lib/systemd/system/sockets.target.wants/*udev* \
    /lib/systemd/system/sockets.target.wants/*initctl* \
    /lib/systemd/system/basic.target.wants/* \
    /lib/systemd/system/anaconda.target.wants/* \
    /lib/systemd/system/plymouth* \
    /lib/systemd/system/systemd-update-utmp*

##### OpenSSH server Configuration
#RUN apt-get install -y sudo passwd openssh-server

# Permit Root Login
RUN cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    echo "root:ubuntu" | chpasswd \
    mkdir /var/run/sshd

VOLUME ["/sys/fs/cgroup"]
EXPOSE 22

WORKDIR /
CMD ["sh","-c","service ssh restart ; bash"]
