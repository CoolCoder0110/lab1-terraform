#!/bin/bash
apt-get update
apt-get install -y ufw fail2ban unattended-upgrades auditd

# G-krav: Bas-härdning
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable
dpkg-reconfigure -plow unattended-upgrades

# VG-krav: CIS Benchmark Hardening
echo "install cramfs /bin/true" >> /etc/modprobe.d/cis.conf
echo "install freevxfs /bin/true" >> /etc/modprobe.d/cis.conf
echo "install squashfs /bin/true" >> /etc/modprobe.d/cis.conf

echo "net.ipv4.ip_forward = 0" >> /etc/sysctl.d/99-cis.conf
echo "net.ipv4.conf.all.accept_source_route = 0" >> /etc/sysctl.d/99-cis.conf
echo "net.ipv4.conf.all.accept_redirects = 0" >> /etc/sysctl.d/99-cis.conf
sysctl -p /etc/sysctl.d/99-cis.conf

sed -i 's/^#LogLevel.*/LogLevel INFO/' /etc/ssh/sshd_config
sed -i 's/^X11Forwarding yes/X11Forwarding no/' /etc/ssh/sshd_config
sed -i 's/^#MaxAuthTries.*/MaxAuthTries 4/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

systemctl enable auditd
systemctl start auditd

echo "Startup script completed at $(date)" > /var/log/startup-complete.log
