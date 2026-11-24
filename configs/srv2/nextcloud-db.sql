-- Datenbank und Benutzer für Nextcloud (MariaDB)
-- <DB_PASSWORT> durch ein eigenes, starkes Passwort ersetzen
CREATE DATABASE nextcloud_db;
CREATE USER nextclouduser@localhost IDENTIFIED BY '<DB_PASSWORT>';
GRANT ALL PRIVILEGES ON nextcloud_db.* TO nextclouduser@localhost;
FLUSH PRIVILEGES;
SHOW GRANTS FOR nextclouduser@localhost;
