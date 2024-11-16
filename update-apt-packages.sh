#!/bin/bash

# Detect the OS name
os_name=$( cat /etc/os-release | grep -E "^NAME" | sed -e "s|^NAME=||g" | tr -d '"' )

# Detect the OS Version
os_codename=$( cat /etc/os-release | grep -E "^VERSION_CODENAME" | sed -e "s|^VERSION_CODENAME=||g" | tr -d '"' )

echo "os_name: $os_name"
echo "os_codename: $os_codename"
echo ""

# Make sure this script is for Debian Linux
if [[ -z $( echo "$os_name" | grep "Debian" ) ]]; then
	echo "Error: This script is made for Debian Linux."
	exit 1
fi

echo ""
echo "Recreating the file /etc/apt/sources.list ..."

echo "deb http://deb.debian.org/debian $os_codename main contrib non-free" > /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian $os_codename main contrib non-free" >> /etc/apt/sources.list
echo "" >> /etc/apt/sources.list
echo "deb http://deb.debian.org/debian $os_codename-updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://deb.debian.org/debian $os_codename-updates main contrib non-free" >> /etc/apt/sources.list
echo "" >> /etc/apt/sources.list
echo "deb http://security.debian.org/debian-security/ $os_codename/updates main contrib non-free" >> /etc/apt/sources.list
echo "deb-src http://security.debian.org/debian-security/ $os_codename/updates main contrib non-free" >> /etc/apt/sources.list

echo ""
echo "Updating APT packages ..."

apt-get update
apt-get install -y linux-headers-amd64 linux-image-amd64
apt-get upgrade -y
