[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/4-0NpdbV)
# zbx7-auto-reg

The independent work - Vagrant and Zabbix Agent2 7.0 LTS - Auto-registration to Appliance

# Zabbix Appliance monitoring Ubuntu by Agent2

V adresáři Ubuntu máte připraven Vagrantfile z prvního pololetí se scripty
pro registraci na server enceladus.

## Požadované známkované úkoly

- Použijte svůj Zabbix server - Zabbix aplliance, kde máte z minuleho zadání funkční interní síť 192.168.1.0/24
- Upravíme Vagrant file tak, že přidáme do ně ho ubuntu.vm.network "private_network", ip: "192.168.1.3", virtualbox__intnet: "intnet"
- Vytvoříme v Zabbbix GUI Appliance auto-registracni pravidlo, kde dáme že HostMetadata matches SPOS 
- V konfigurančím souboru přidáme:
if grep -q "^HostMetadata=" /etc/zabbix/zabbix_agent2.conf; then
    sudo sed -i "s/^HostMetadata=.*/HostMetadata=SPOS/" /etc/zabbix/zabbix_agent2.conf
else
    echo "HostMetadata=SPOS" | sudo tee -a /etc/zabbix/zabbix_agent2.conf
fi
sudo diff -u /etc/zabbix/zabbix_agent2.conf-orig /etc/zabbix/zabbix_agent2.conf || true
- V instalační souboru přidáme:
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_7.0-1+ubuntu22.04_all.deb
- Výsledný registrovaný host s unikátním jmenem vložte jako Screenshot do adresáře Images.
- Upravte Ubuntu/README.md tak, aby informace v něm odpovídaly upravám ve scriptech.

# Nápověda

- Zabbix [Version 7.0 LTS - repo](https://www.zabbix.com/download?zabbix=7.0&os_distribution=ubuntu&os_version=22.04&components=agent_2&db=&ws=)
- Vagrant [virtualbox internal network](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/networking#virtualbox-internal-network)

...
