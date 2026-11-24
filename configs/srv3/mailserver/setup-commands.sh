#!/bin/bash
# Mailserver auf SRV3 (LXC-Container) – wichtigste Befehle

# Selbstsigniertes Zertifikat (im Ordner ./cert)
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -sha256 -days 3650 -nodes \
  -subj "/C=DE/ST=BaWue/L=Heidelberg/O=GFN/OU=/CN=mail.gfn.internal"

# Debian-eigenen Postfix stoppen, damit Port 25 frei ist
sudo systemctl stop postfix
sudo systemctl disable postfix

# Stack starten
docker compose up -d

# Postfächer anlegen (<PASSWORT> ersetzen)
docker exec -it mailserver setup email add admin@gfn.internal <PASSWORT>
docker exec -it mailserver setup email add student@gfn.internal <PASSWORT>
