#!/usr/bin/env bash
#################################################
#   author  huachao
#   date    2015-12-09
#   email   i@huachao.me
#   web     blog.huachao.me
#################################################

flagFile="/root/centos6-init.executed"

precheck(){

    if [[ "$(whoami)" != "root" ]]; then
    echo "please run this script as root ." >&2
    exit 1
    fi

    if [ -f "$flagFile" ]; then
    echo "this script had been executed, please do not execute again!!" >&2
    exit 1
    fi

    echo -e "\033[31m WARNING! THIS SCRIPT WILL \033[0m\n"
    echo -e "\033[31m *1 update the system; \033[0m\n"
    echo -e "\033[31m *2 setup security permissions; \033[0m\n"
    echo -e "\033[31m *3 stop irrelevant services; \033[0m\n"
    echo -e "\033[31m *4 reconfig kernel parameters; \033[0m\n"
    echo -e "\033[31m *5 setup timezone and sync time periodically; \033[0m\n"
    echo -e "\033[31m *6 setup tcp_wrapper and netfilter firewall; \033[0m\n"
    echo -e "\033[31m *7 setup vsftpd; \033[0m\n"
    sleep 5
    
}

yum_update(){
    yum -y update
    #update system at 5:40pm daily
    echo "40 3 * * * root yum -y update && yum clean packages" >> /etc/crontab
}

permission_config(){
    #chattr +i /etc/shadow
    #chattr +i /etc/passwd
}

selinux(){
    sed -i 's/SELINUX=disabled/SELINUX=enforcing/g' /etc/sysconfig/selinux
    setenforce 1
}

stop_services(){
    for server in `chkconfig --list |grep 3:on|awk '{print $1}'`
    do
        chkconfig --level 3 $server off
    done
     
    for server in crond network rsyslog sshd iptables
    do
       chkconfig --level 3 $server on
    done
}

limits_config(){
cat >> /etc/security/limits.conf <<EOF
* soft nproc 65535
* hard nproc 65535
* soft nofile 65535
* hard nofile 65535
EOF
echo "ulimit -SH 65535" >> /etc/rc.local
}

sysctl_config(){
sed -i 's/net.ipv4.tcp_syncookies.*$/net.ipv4.tcp_syncookies = 1/g' /etc/sysctl.conf
sed -i 's/net.ipv4.ip_forward.*$/net.ipv4.ip_forward = 1/g' /etc/sysctl.conf
cat >> /etc/sysctl.conf <<EOF
net.ipv4.tcp_max_syn_backlog = 65536
net.core.netdev_max_backlog =  32768
net.core.somaxconn = 32768
net.core.wmem_default = 8388608
net.core.rmem_default = 8388608
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2
net.ipv4.tcp_tw_recycle = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_mem = 94500000 915000000 927000000
net.ipv4.tcp_max_orphans = 3276800
net.ipv4.ip_local_port_range = 1024  65535
EOF
sysctl -p
}

sshd_config(){
    if [ ! -f "/root/.ssh/id_rsa.pub" ]; then
    ssh-keygen -t rsa -P '' -f /root/.ssh/id_rsa
    cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    fi

    #sed -i '/^#Port/s/#Port 22/Port 65535/g' /etc/ssh/sshd_config
    sed -i '/^#UseDNS/s/#UseDNS no/UseDNS yes/g' /etc/ssh/sshd_config
    #sed -i 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
    sed -i 's/#PermitEmptyPasswords yes/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
    /etc/init.d/sshd restart
}

time_config(){
    #timezone
    echo "TZ='Asia/Shanghai'; export TZ" >> /etc/profile

    # Update time
    if [! -f "/usr/sbin/ntpdate"]; then
        yum -y install ntpdate
    fi
    
    /usr/sbin/ntpdate pool.ntp.org
    echo "30 3 * * * root (/usr/sbin/ntpdate pool.ntp.org && /sbin/hwclock -w) &> /dev/null" >> /etc/crontab
    /sbin/service crond restart
}

iptables(){
cat > /etc/sysconfig/iptables << EOF
# Firewall configuration written by system-config-securitylevel
# Manual customization of this file is not recommended.
*filter
:INPUT DROP [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
:syn-flood - [0:0]
-A INPUT -i lo -j ACCEPT
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
-A INPUT -p icmp -m limit --limit 100/sec --limit-burst 100 -j ACCEPT
-A INPUT -p icmp -m limit --limit 1/s --limit-burst 10 -j ACCEPT
-A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j syn-flood
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A syn-flood -p tcp -m limit --limit 3/sec --limit-burst 6 -j RETURN
-A syn-flood -j REJECT --reject-with icmp-port-unreachable
COMMIT
EOF
/sbin/service iptables restart
source /etc/profile
}

other(){
    # initdefault
    sed -i 's/^id:.*$/id:3:initdefault:/' /etc/inittab
    /sbin/init q
    
    # PS1
    #echo 'PS1="\[\e[32m\][\[\e[35m\]\u\[\e[m\]@\[\e[36m\]\h \[\e[31m\]\w\[\e[32m\]]\[\e[36m\]$\[\e[m\]"' >> /etc/profile
     
    # Wrong password five times locked 180s
    sed -i '4a auth        required      pam_tally2.so deny=5 unlock_time=180' /etc/pam.d/system-auth
}

vsftpd_setup(){
    yum -y install vsftpd
    mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak
    touch /etc/vsftpd/chroot_list
    setsebool -P ftp_home_dir=1
cat >> /etc/vsftpd/vsftpd.conf <<EOF
# normal user settings
local_enable=YES
write_enable=YES
local_umask=022
chroot_local_user=YES
chroot_list_enable=YES
chroot_list_file=/etc/vsftpd/chroot_list
local_max_rate=10000000
# anonymous settings
anonymous_enable=YES
no_anon_password=YES
anon_max_rate=1000000
data_connection_timeout=60
idle_session_timeout=600
# ssl settings
#ssl_enable=YES             
#allow_anon_ssl=NO           
#force_local_data_ssl=YES    
#force_local_logins_ssl=YES  
#ssl_tlsv1=YES               
#ssl_sslv2=NO
#ssl_sslv3=NO
#rsa_cert_file=/etc/vsftpd/vsftpd.pem 
# server settings
max_clients=50
max_per_ip=5
use_localtime=YES
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
xferlog_std_format=YES
listen=YES
pam_service_name=vsftpd
tcp_wrappers=YES
#banner_file=/etc/vsftpd/welcome.txt
dual_log_enable=YES
pasv_min_port=65400
pasv_max_port=65410
EOF
    chkconfig --level 3 vsftpd on
    service vsftpd restart
}
 
main(){
    precheck
    
    printf "\033[32m================%40s================\033[0m\n" "updating the system            "
    yum_update

    printf "\033[32m================%40s================\033[0m\n" "re-config permission           "
    permission_config

    printf "\033[32m================%40s================\033[0m\n" "enabling selinux               "
    selinux

    printf "\033[32m================%40s================\033[0m\n" "stopping irrelevant services   "
    stop_services
    
    printf "\033[32m================%40s================\033[0m\n" "/etc/security/limits.config    "
    limits_config
    
    printf "\033[32m================%40s================\033[0m\n" "/etc/sysctl.conf               "
    sysctl_config

    printf "\033[32m================%40s================\033[0m\n" "sshd re-configuring            "
    sshd_config
    
    printf "\033[32m================%40s================\033[0m\n" "configuring time               "
    time_config
    
    printf "\033[32m================%40s================\033[0m\n" "configuring firewall           "
#   iptables
    
    printf "\033[32m================%40s================\033[0m\n" "someother stuff                "
    other

    printf "\033[32m================%40s================\033[0m\n" "done! rebooting                "
    touch "$flagFile"
    sleep 5
    reboot
}

main
