#!/bin/bash

# Mise à jour des listes de paquets
echo "Mise à jour des listes de paquets..."
sudo apt-get update

# Installation des packages nécessaires
echo "Installation de git, curl, wget, vim, python3, python3-pip, et mysql..."
sudo apt-get install -y git curl wget vim python3 python3-pip mysql-server

# Installation de Ansible
echo "Installation de Ansible..."
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt-get install -y ansible

# Installation du package PyMySQL pour Python3 (pour l'utilisateur et pour root)
echo "Installation du package PyMySQL pour Python3..."
pip3 install pymysql
sudo pip3 install pymysql

# Installation du package community.mysql pour Ansible
echo "Installation du package community.mysql pour Ansible..."
ansible-galaxy collection install community.mysql

# Exécution du playbook Ansible
echo "Lancement du playbook Ansible..."
ansible-playbook playbook.yml --ask-become-pass

echo "Script terminé."
