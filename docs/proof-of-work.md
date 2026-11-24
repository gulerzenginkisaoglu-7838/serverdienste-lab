# Proof of Work – Screenshots aus dem Lab

Diese Screenshots zeigen das laufende Lab (Hyper-V auf einem GFN-Schulungsrechner, Zugriff über den Client CL01).

[← zurück zur README](../README.md)

---

## Storage (TrueNAS CORE)

| TrueNAS Dashboard | Pool1 (RAIDZ, lz4) |
|---|---|
| ![TrueNAS Dashboard](images/01_truenas_dashboard.jpg) | ![Pool1](images/02_truenas_pool1_raidz.jpg) |

| iSCSI-Wizard (target02) | Proxmox: iSCSI-Storage anbinden |
|---|---|
| ![iSCSI Wizard](images/03_truenas_iscsi_wizard.jpg) | ![Proxmox iSCSI](images/04_proxmox_iscsi_storage.jpg) |

**SRV2 als iSCSI-Initiator:** Discovery zeigt beide Targets, nach dem Login erscheint `sdb` (200 G).

![iscsiadm und lsblk](images/05_srv2_iscsiadm_lsblk.jpg)

## Webserver (Apache, vhosts)

| vhost-Konfiguration | lf10b.gfn.internal |
|---|---|
| ![vhost config](images/06_apache_vhost_config.jpg) | ![lf10b](images/07_apache_vhost_lf10b.jpg) |

![website1.gfn.internal](images/08_apache_vhost_website1.jpg)

## Nextcloud (HTTPS)

![Nextcloud Dashboard](images/09_nextcloud_dashboard.jpg)

## Docker: Chrony und Portainer

**NTP-Abfrage** auf den Chrony-Container: `ntpdate` antwortet von `192.168.10.13`.

![ntpdate](images/10_ntp_query_chrony.jpg)

| Portainer über https://192.168.10.13:9443 |
|---|
| ![Portainer](images/11_portainer_9443.jpg) |

## Mailserver und Mailclient

| Proxmox: LXC-Container srv3 | Thunderbird: Testmail admin → student |
|---|---|
| ![LXC srv3](images/13_proxmox_lxc_srv3.jpg) | ![Thunderbird](images/14_thunderbird_testmail.jpg) |
