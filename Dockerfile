FROM ubuntu

# Install useful packages
RUN apt -y update
RUN apt -y install nano wget git curl sudo unzip openssh-server systemctl inetutils-ping traceroute nmap

# Create my folder
RUN mkdir /usr/daniel
RUN chmod 777 /usr/daniel

# Create user that will be used to ssh into
RUN cp /usr/bin/bash /usr/bin/zsh
RUN mkdir /home/user
RUN useradd --home /home/user --shell /usr/bin/zsh user
RUN usermod -aG sudo user
RUN chown user /home/user/ -R
RUN chown user /home/ -R
RUN chown user /home/ -R
RUN chgrp user /home/user -R
RUN echo 'user:1234' | chpasswd user

# Add Daniel's zsh from his Github
RUN su daniel;/bin/bash -c "cd /usr/daniel;wget https://github.com/Daniel-Tomov/zsh/archive/refs/heads/main.zip; unzip main.zip; mv zsh-main zsh"
RUN rm /usr/daniel/zsh/install.sh
ADD zsh-install.sh /usr/daniel/zsh/install.sh
#RUN su daniel;/bin/bash -c "cd /usr/daniel/zsh; chmod +x install.sh; ./install.sh"

# Add coloried cat. May need to download your own if it doesn't work
RUN mv /usr/bin/cat /usr/bin/concat
RUN cp /usr/bin/concat /usr/bin/ccat
ADD concat /usr/bin/cat

# Setup ssh
RUN sed -i 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication no/g' /etc/ssh/sshd_config
RUN sed -i 's/#HostbasedAuthentication no/HostbasedAuthentication no/g' /etc/ssh/sshd_config
RUN service ssh restart
EXPOSE 22

# Change permissions on my folder. This has to be done here because other files are added that have root permissions
RUN chown user /usr/daniel -R
RUN chmod 700 /usr/daniel -R
