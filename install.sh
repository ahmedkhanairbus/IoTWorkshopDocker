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
sudo docker exec mosquitto mosquitto_passwd -c -b ./mosquitto/config/mosquitto.passwd airbus shed