# Install Zabbix Agent2 on Ubuntu
Repositories for teaching purposes at SPOS DK

![Ubuntu and ZabbixAgent2 OSY AI](../Images/osy-Ubuntu-ZabbixAgent2.webp)

Repository pro vyuku na SPOS DK

## Automatická instalace Zabbix Agent2 na OS Linux Ubuntu

- Vagrantfile obsahuje sekci pro aplikaci příkazů pro instalaci monitorovacího
[Zabbix Agent2](https://www.zabbix.com/).

### Změny Instalace Zabbix Agent2

```console
sudo apt-get install -y net-tools wget gnupg2
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu22.04_all.deb
```

### Změny Konfigurace Zabbix Agent2

```console
if grep -q "^HostMetadata=" /etc/zabbix/zabbix_agent2.conf; then
    sudo sed -i "s/^HostMetadata=.*/HostMetadata=SPOS/" /etc/zabbix/zabbix_agent2.conf
else
    echo "HostMetadata=SPOS" | sudo tee -a /etc/zabbix/zabbix_agent2.conf
fi
sudo diff -u /etc/zabbix/zabbix_agent2.conf-orig /etc/zabbix/zabbix_agent2.conf || true

systemctl restart zabbix-agent2
```
...