FROM debian:stretch
MAINTAINER Josh Cox <josh 'at' webhosting coop>

ENV OCTOSSH_UPDATED 20170721

RUN apt-get update && apt-get install -y wget curl openssh-server autossh; \
apt-get -y autoremove ; \
apt-get clean ; \
rm -Rf /var/lib/apt/lists/*

RUN mkdir /var/run/sshd
# RUN echo 'root:screencast' | chpasswd
# RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# ENV NOTVISIBLE "in users profile"
# RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22
ENV KEY_URL https://raw.githubusercontent.com/WebHostingCoopTeam/keys/master/keys
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh
CMD ["/start.sh"]
