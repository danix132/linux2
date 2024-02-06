#!/bin/bash

# Pedir al usuario la configuración
read -p "Ingrese el rango de IP (Ejemplo: 192.168.1.10-192.168.1.100): " ipRange
read -p "Ingrese la máscara de subred (Ejemplo: 255.255.255.0): " subnetMask
read -p "Ingrese la puerta de enlace predeterminada: " gateway
read -p "Ingrese la dirección del servidor DNS: " dns

# Instalar y configurar el servidor DHCP en Linux (en este caso usando ISC DHCP Server)
sudo apt-get update
sudo apt-get install isc-dhcp-server

# Configurar el archivo /etc/dhcp/dhcpd.conf
cat <<EOF | sudo tee /etc/dhcp/dhcpd.conf
subnet $(echo $ipRange | cut -d'-' -f1) netmask $subnetMask {
  range $(echo $ipRange | sed 's/-/ /') ;
  option routers $gateway;
  option domain-name-servers $dns;
}
EOF

# Reiniciar el servicio DHCP
sudo service isc-dhcp-server restart
