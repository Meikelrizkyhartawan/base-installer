# Set environment to avoid interactive prompts
export DEBIAN_FRONTEND=noninteractive

# Update package list
apt update -y

# Disable UFW
ufw disable


#NTP Section

# Install NTP without prompts
apt install ntp -y

# Set the system timezone to Asia/Jakarta manually
ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Restart NTP to apply changes
service ntp restart

# Verify the timezone setting
date

#Add Open Files Limit
bash -c "echo '
# Ulimit settings for the root user
root soft     nproc          65535
root hard     nproc          65535
root soft     nofile         65535
root hard     nofile         65535
' >> /etc/security/limits.conf"

echo "Add ulimit complete"


# Update Inotify Watchers
echo fs.inotify.max_user_watches=5242880 | tee -a /etc/sysctl.conf
echo fs.inotify.max_user_instances=1024 | tee -a /etc/sysctl.conf

sysctl -p
