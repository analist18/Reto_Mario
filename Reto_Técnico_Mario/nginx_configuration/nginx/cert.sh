#!/bin/bash

#te permitira crear una clave encriptada solo se tiene que ingresar el password que desees para el "CA Key"
echo -n 1: Ingresar CA Sever Key password:
read -s cakey_pass
openssl genrsa -des3 -passout pass:$cakey_pass -out ca.key 4096 -noout
openssl req -new -x509 -days 3650 -key ca.key -passin pass:$cakey_pass -out ca.crt  -subj "Agile_ops_Engineer"

# te permitira crear una clave encriptada solo se tiene que ingresar el password que desees para el "Client Key"
echo -n 2: Ingresar Server.crt password:
read -s clientkey_pass
openssl genrsa -des3 -passout pass:$clientkey_pass -out server.key 4096 -noout
openssl req -new -key server.key -passin pass:$clientkey_pass -out server.csr -subj "Agile_ops_Engineer"
openssl x509 -req -days 365 -in server.csr -CA ca.crt -CAkey ca.key -passin pass:$cakey_pass -set_serial 01 -out server.crt

#te permitira crear una clave encriptada solo se tiene que ingresar el password que desees para el "caclientkey_pass"
echo -n 3: Ingresar CA Client Key password:
read -s caclientkey_pass
openssl genrsa -des3 -passout pass:$caclientkey_pass -out client.key 4096 -noout

openssl req -new -key client.key -passin pass:$caclientkey_pass -out client.csr -subj "Agile_ops_Engineer"
openssl x509 -req -days 365 -in client.csr -CA ca.crt -CAkey ca.key -passin pass:$cakey_pass -set_serial 01 -out client.crt

openssl rsa -passin pass:$clientkey_pass   -in server.key -out server.key
openssl rsa -passin pass:$caclientkey_pass -in client.key -out client.key

#Ingresar password para el "passwordPfx"
echo -n 4: Ingresar Pfx password:
read -s passwordPfx
openssl pkcs12 -export -passout pass:$passwordPfx -out client.pfx -inkey client.key -in client.crt

