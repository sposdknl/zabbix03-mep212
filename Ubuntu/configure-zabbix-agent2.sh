#!/usr/bin/env bash
set -e


# Vygeneruj unikátní hostname
UNIQUE_HOSTNAME="ubuntu-$(uuidgen)"
SHORT_HOSTNAME=$(echo "$UNIQUE_HOSTNAME" | cut -d'-' -f1,2)

# Nastav systémový hostname
echo "$SHORT_HOSTNAME" | sudo tee /etc/hostname
sudo hostnamectl set-hostname "$SHORT_HOSTNAME"

# Záloha původního konfiguračního souboru
sudo cp -v /etc/zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf-orig

# Úprava konfigurace
sudo sed -i "s/^Hostname=.*/Hostname=$SHORT_HOSTNAME/" /etc/zabbix/zabbix_agent2.conf
sudo sed -i "s/^Server=.*/Server=192.168.1.2/" /etc/zabbix/zabbix_agent2.conf
sudo sed -i "s/^ServerActive=.*/ServerActive=192.168.1.2/" /etc/zabbix/zabbix_agent2.conf
sudo sed -i "s/^# Timeout=.*/Timeout=30/" /etc/zabbix/zabbix_agent2.conf

if grep -q "^HostMetadata=" /etc/zabbix/zabbix_agent2.conf; then
    sudo sed -i "s/^HostMetadata=.*/HostMetadata=SPOS/" /etc/zabbix/zabbix_agent2.conf
else
    echo "HostMetadata=SPOS" | sudo tee -a /etc/zabbix/zabbix_agent2.conf
fi

sudo systemctl restart zabbix-agent2

sudo diff -u /etc/zabbix/zabbix_agent2.conf-orig /etc/zabbix/zabbix_agent2.conf || true

