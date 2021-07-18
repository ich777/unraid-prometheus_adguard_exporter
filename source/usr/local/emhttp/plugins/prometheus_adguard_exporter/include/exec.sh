#!/bin/bash

function get_adguard_hostname(){
echo -n "$(cat /boot/config/plugins/prometheus_adguard_exporter/settings.cfg | grep "adguard_hostname=" | cut -d '=' -f2-)"
}

function get_adguard_username(){
echo -n "$(cat /boot/config/plugins/prometheus_adguard_exporter/settings.cfg | grep "adguard_username=" | cut -d '=' -f2-)"
}

function get_adguard_password(){
echo -n "$(cat /boot/config/plugins/prometheus_adguard_exporter/settings.cfg | grep "adguard_password=" | cut -d '=' -f2-)"
}

function get_adguard_protocol(){
echo -n "$(cat /boot/config/plugins/prometheus_adguard_exporter/settings.cfg | grep "adguard_protocol=" | cut -d '=' -f2-)"
}

function get_adguard_port(){
echo -n "$(cat /boot/config/plugins/prometheus_adguard_exporter/settings.cfg | grep "adguard_port=" | cut -d '=' -f2-)"
}

function get_exporter_port(){
echo -n "$(cat /boot/config/plugins/prometheus_adguard_exporter/settings.cfg | grep "exporter_port=" | cut -d '=' -f2-)"
}

function get_exporter_interval(){
echo -n "$(cat /boot/config/plugins/prometheus_adguard_exporter/settings.cfg | grep "exporter_interval=" | cut -d '=' -f2-)"
}

function change_adguard_settings(){
sed -i "/adguard_hostname=/c\adguard_hostname=${1}" "/boot/config/plugins/prometheus_adguard_exporter/settings.cfg"
sed -i "/adguard_username=/c\adguard_username=${2}" "/boot/config/plugins/prometheus_adguard_exporter/settings.cfg"
sed -i "/adguard_password=/c\adguard_password=${3}" "/boot/config/plugins/prometheus_adguard_exporter/settings.cfg"
sed -i "/adguard_port=/c\adguard_port=${5}" "/boot/config/plugins/prometheus_adguard_exporter/settings.cfg"
if [ ! -z "$(pgrep -f prometheus_adguard_exporter_init.sh)" ]; then
  kill $(pgrep -f prometheus_adguard_exporter_init.sh)
fi
kill $(pidof prometheus_adguard_exporter)
echo -n "$(/usr/local/emhttp/plugins/prometheus_adguard_exporter/include/prometheus_adguard_exporter_start.sh $1 $2 $3 $4 $5 $6 $7)"
}

function get_status(){
if [ ! -z "$(pgrep -f prometheus_adguard_exporter_init.sh)" ]; then
  echo -e "starting"
elif [ ! -z "$(pidof prometheus_adguard_exporter)" ]; then
  echo -e "running"
else
  echo "stopped"
fi
}

function start(){
echo -n "$(/usr/local/emhttp/plugins/prometheus_adguard_exporter/include/prometheus_adguard_exporter_start.sh $1 $2 $3 $4 $5 $6 $7)"
}

function stop_exporter(){
echo -n "$(kill $(pidof prometheus_adguard_exporter))"
}

$@