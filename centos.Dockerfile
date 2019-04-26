FROM centos:7

RUN yum install -y centos-release-scl && yum update -y && yum install -y openssh-server rh-python36
RUN mkdir /var/run/sshd
RUN echo 'root:ansible' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN /usr/bin/ssh-keygen -A

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
