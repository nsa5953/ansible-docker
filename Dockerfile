FROM centos:latest
MAINTAINER "Nilesh Attarde" 
ENV container docker
RUN yum update -y; yum clean all
RUN yum -y install systemd; yum clean all; \
(cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN yum install -y sudo zip unzip openssh-server sudo passwd java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel; yum clean all
RUN systemctl enable sshd.service
COPY id_rsa.pub /tmp/id_rsa.pub
ADD useradm.sh /tmp/useradm.sh
RUN mkdir /var/run/sshd
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN chmod 755 /tmp/useradm.sh && chmod 755 /tmp/useradm.sh
ENV 
RUN ./tmp/useradm.sh
VOLUME [ "/sys/fs/cgroup" ]
EXPOSE 22
CMD ["/usr/sbin/init"]
