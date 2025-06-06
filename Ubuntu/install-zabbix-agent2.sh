#!/usr/bin/env bash
set -e


# Instalace základních nástrojů
sudo apt-get update
sudo apt-get install -y net-tools wget gnupg2

# Stažení a instalace Zabbix repozitáře (Ubuntu 22.04 - jammy)
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_7.0-1+ubuntu22.04_all.deb

# Aktualizace balíčků
sudo apt-get update

# Instalace agenta a pluginů
sudo apt-get install -y zabbix-agent2 zabbix-agent2-plugin-*

# Povolení služby
sudo systemctl enable zabbix-agent2
sudo systemctl stop zabbix-agent2

