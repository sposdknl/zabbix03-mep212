#!/usr/bin/env bash
set -e

echo "⚙️  Konfigurace Zabbix Agent2..."

ZABBIX_SERVER="192.168.1.2"

# Vygeneruj unikátní hostname
UNIQUE_HOSTNAME="ubuntu-$(uuidgen)"
SHORT_HOSTNAME=$(echo "$UNIQUE_HOSTNAME" | cut -d'-' -f1,2)

echo "🖥️  Nový hostname: $SHORT_HOSTNAME"

# Nastav systémový hostname
echo "$SHORT_HOSTNAME" | sudo tee /etc/hostname
sudo hostnamectl set-hostname "$SHORT_HOSTNAME"

# Záloha původního konfiguračního souboru
sudo cp -v /etc/zabbix/zabbix_agent2.conf /etc/zabbix/zabbix_agent2.conf-orig

# Úprava konfigurace
sudo sed -i "s/^Hostname=.*/Hostname=$SHORT_HOSTNAME/" /etc/zabbix/zabbix_agent2.conf
sudo sed -i "s/^Server=.*/Server=$ZABBIX_SERVER/" /etc/zabbix/zabbix_agent2.conf
sudo sed -i "s/^ServerActive=.*/ServerActive=$ZABBIX_SERVER/" /etc/zabbix/zabbix_agent2.conf
sudo sed -i "s/^# Timeout=.*/Timeout=30/" /etc/zabbix/zabbix_agent2.conf

# Přidání nebo úprava HostMetadata
if grep -q "^HostMetadata=" /etc/zabbix/zabbix_agent2.conf; then
    sudo sed -i "s/^HostMetadata=.*/HostMetadata=SPOS/" /etc/zabbix/zabbix_agent2.conf
else
    echo "HostMetadata=SPOS" | sudo tee -a /etc/zabbix/zabbix_agent2.conf
fi

# Restart agenta
sudo systemctl restart zabbix-agent2

# Výpis změn
echo "📋 Změny v konfiguraci:"
sudo diff -u /etc/zabbix/zabbix_agent2.conf-orig /etc/zabbix/zabbix_agent2.conf || true

echo "✅ Konfigurace dokončena."
