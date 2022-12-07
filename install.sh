touch .env

mkdir -p ./mosquitto/log
touch ./mosquitto/log/mosquitto.log

mkdir -p ./grafana
chown 472:472 ./grafana

mkdir -p ./mosquitto/config
touch ./mosquitto/config/mosquitto.passwd 
cat > ./mosquitto/config/mosquitto.conf <<ENDOFFILE
###############Listener###############

listener 1883 0.0.0.0
### 1883 is the default port for Mosquitto,  0.0.0.0 means it will only run on the local network. No port forwarding is required.

#cafile <path to ca file>
#certfile <path to server cert>
#keyfile <path to server key>
#require_certificate false

#### Uncomment the code to enable TLS for better security. Clients must be configured in the same way.
#################Data#################

persistence true
persistence_location /mosquitto/data/
#log_dest file /mosquitto/log/mosquitto.log

###############Password###############
password_file /mosquitto/config/mosquitto.passwd
allow_anonymous false

#protocol websockets
######################################


ENDOFFILE


docker compose up -d
PSID=$(docker ps --filter "name=mosquitto"  --format "{{.ID}}")
echo -e "\e[0;32m################################ \e[0;31mIMPORTANT! \e[0;32m################################"
echo "Type in the following commands and after that type a password. The password is hidden so be careful! Remember this password you will need it:"
echo -e "\e[1;37m> \e[0;32mmosquitto_passwd -c /mosquitto/config/mosquitto.passwd airbus"
echo -e "\e[1;37m> \e[0;32mexit"
docker exec -it $PSID sh