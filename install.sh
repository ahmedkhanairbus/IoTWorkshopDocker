mkdir -p ./mosquitto/config
cat > ./mosquitto/config/mosquitto.conf <<ENDOFFILE
###############Listener###############

listener 1883 0.0.0.0
### 1883 is the default port for Mosquitto,  0.0.0.0 means it will only run on the local network. No port forwarding is required.

#cafile <path to ca file>
#certfile <path to server cert>
#keyfile <path to server key>
#require_certificate false

#### Uncomment the code to enable TLS for better security. Clients must be configured in the same way.
######################################

ENDOFFILE

cat .env