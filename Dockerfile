FROM ubuntu:24.04

# Update and install OpenSSH server
RUN apt-get update && apt-get install -y openssh-server nano git

# Create a directory for sshd to run
# RUN mkdir /var/run/sshd

# Set root password
RUN echo 'root:wibu' | chpasswd

# Allow root login with password
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Configure PAM to skip password for root
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

# Expose SSH port
# EXPOSE 22

# Switch to root user
USER root

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]