#append the sshd_config with the following:

#PermitRootLogin no
#AllowUsers localuser
#Protocol 2

systemctl restart sshd.service


yum update -y
yum install epel-release -y
yum update -y
yum install fail2ban -y
sytemctl enable fail2ban

cp /etc/fail2ban/jail.local "/etc/fail2ban/jail.local.$(date)"

echo"
[DEFAULT]
# Ban hosts for one hour:
bantime = 3600

#ignoreip = add_ip_you_would_like_to_ignore

# Override /etc/fail2ban/jail.d/00-firewalld.conf:
banaction = iptables-multiport

[sshd]
enabled = true" > /etc/fail2ban/jail.local

systemctl restart fail2ban
fail2ban-client status sshd


#copy default and make new rbash
cp /bin/bash /bin/rbash

#add remote user first parameter on CLI and assign /bin/rbash 
useradd -s /bin/rbash $1

#for existing user
#usermod -s /bin/rbash "existinguser"

#take snapshot of the .bash_profile
cp /home/$1/.bash_profile "./.bash_profile.$(date)"
#Create a directory under /home/localuser/
mkdir /home/$1/programs


#append .bash_profile with ....
echo "
#replace /home/localuser/.bash_profile with the following:

# cat /home/localuser/.bash_profile  
# .bash_profile  

# Get the aliases and functions  
if [ -f ~/.bashrc ]; then  
. ~/.bashrc  
fi  
# User specific environment and startup programs  
PATH=$HOME/programs  
export PATH" > /home/$1/.bash_profile

#after loggin in you should see the following:

#[localuser@example ~]$ ls  
#-rbash: ls: command not found  


