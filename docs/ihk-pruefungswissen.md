# Prüfungswissen IHK AP1/AP2 – aus dem LF10b-Lab

Kurze Erklärungen zu den Themen, die im Lab praktisch umgesetzt wurden. ⭐ = besonders prüfungsrelevant.

[← zurück zur README](../README.md)

---

## Netzwerk und Routing

| Begriff | Erklärung | Im Lab |
|---|---|---|
| ⭐ **NAT / SNAT (Masquerading)** | Private Quell-IPs werden beim Verlassen des Netzes durch die öffentliche IP des Routers ersetzt. | `iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE` |
| ⭐ **DNAT / Port-Forwarding** | Eingehende Pakete auf einem Port werden an einen internen Host weitergeleitet. | WAN :80 → `192.168.10.13:80` |
| **IP-Forwarding** | Linux leitet nur dann Pakete zwischen Schnittstellen weiter, wenn `net.ipv4.ip_forward=1` gesetzt ist. | Router |
| **Private Adressbereiche (RFC 1918)** | `10.0.0.0/8`, `172.16.0.0/12`, `192.168.0.0/16`, werden im Internet nicht geroutet. | `192.168.10.0/24` |
| **Well-known Ports** | Ports 0–1023 (z. B. 22 SSH, 53 DNS, 80 HTTP, 443 HTTPS). | SSH auf 6464 verlegt |

## DHCP

- ⭐ **DORA-Ablauf:** **D**iscover (Broadcast) → **O**ffer → **R**equest → **A**cknowledge
- **Ports:** Server UDP 67, Client UDP 68
- **Lease-Zeit:** IP-Adresse wird nur geliehen (`valid-lifetime`), Client verlängert rechtzeitig
- **Wichtige Optionen:** Router/Gateway (3), DNS-Server (6), Domain-Name (15), NTP-Server (42)

## DNS

| Record | Bedeutung | Beispiel aus dem Lab |
|---|---|---|
| ⭐ **A** | Name → IPv4-Adresse | `srv2 IN A 192.168.10.13` |
| **AAAA** | Name → IPv6-Adresse | – |
| ⭐ **CNAME** | Alias auf einen anderen Namen | `nextcloud IN CNAME srv2` |
| ⭐ **MX** | Mailserver der Domain (mit Priorität) | `@ IN MX 10 mail` |
| ⭐ **PTR** | IP → Name (Reverse-Lookup) | `11 IN PTR srv1.gfn.internal.` |
| **NS** | Zuständiger Nameserver der Zone | `@ IN NS srv1.gfn.internal.` |
| **SOA** | Start of Authority: Serial, Refresh, Retry, Expire, TTL | Kopf jeder Zonendatei |

- **Forward-Zone** (Name → IP) und **Reverse-Zone** (`10.168.192.in-addr.arpa`, IP → Name)
- **Forwarder:** Anfragen, die der Server nicht selbst beantworten kann, gehen an `1.1.1.1` / `8.8.8.8`
- **Rekursiv vs. iterativ:** Ein rekursiver Resolver liefert die fertige Antwort, iterativ bekommt der Client nur Verweise.
- DNS nutzt **Port 53** (UDP, bei großen Antworten/Zonentransfer TCP).

## Virtualisierung

| | Virtuelle Maschine (KVM) | Container (LXC / Docker) |
|---|---|---|
| Kernel | eigener Kernel, eigenes OS | teilt den Kernel des Hosts |
| Ressourcen | höher | sehr gering |
| Isolation | stark | schwächer |
| Im Lab | SRV1, SRV2 | SRV3 (LXC), Chrony, Portainer, Mailserver (Docker) |

- ⭐ **Hypervisor Typ 1** (bare metal, z. B. Proxmox VE, Hyper-V, ESXi) vs. **Typ 2** (auf einem Betriebssystem, z. B. VirtualBox)
- **Docker-Begriffe:** Image (Vorlage) · Container (laufende Instanz) · Volume (persistente Daten) · Compose (mehrere Container per YAML)

## Storage

- ⭐ **NAS** (dateibasiert: SMB, NFS) vs. **SAN** (blockbasiert: iSCSI, Fibre Channel)
- ⭐ **iSCSI:** SCSI-Befehle über TCP/IP (Port **3260**)
  - **Target** = stellt Speicher bereit (TrueNAS)
  - **Initiator** = nutzt den Speicher (Proxmox, SRV2)
  - **IQN** = eindeutiger Name, z. B. `iqn.2005-10.org.freenas.ctl:target02`
  - **LUN** = logische Einheit (Disk) im Target
  - **Portal** = IP:Port, an dem das Target lauscht
- **ZFS RAIDZ (≈ RAID 5):** Paritätsinformation verteilt, **1 Platte** darf ausfallen; nutzbar ≈ (n−1) × Plattengröße
- **RAID-Überblick:** RAID 0 (Striping, keine Redundanz) · RAID 1 (Spiegelung) · RAID 5 (Parität, min. 3) · RAID 6 (doppelte Parität, min. 4) · RAID 10 (Spiegel + Striping)
- ⚠️ **RAID ersetzt kein Backup!**

## Backup und Notfallmanagement

- ⭐ **3-2-1-Regel:** 3 Kopien, 2 verschiedene Medien, 1 Kopie extern (offsite)
- ⭐ **Vollbackup / inkrementell / differenziell**
  - inkrementell = Änderungen seit dem **letzten Backup** (schnell, aufwendige Wiederherstellung)
  - differenziell = Änderungen seit dem **letzten Vollbackup**
- ⭐ **RTO** (Recovery Time Objective) = maximal tolerierbare Ausfallzeit
- ⭐ **RPO** (Recovery Point Objective) = maximal tolerierbarer Datenverlust (Zeitraum)
- **Offline-Backup:** Im Lab ist das Backup-Target nur während des Backups eingebunden (Schutz vor Ransomware).
- **Cron-Syntax:** `Minute Stunde Tag Monat Wochentag Befehl`, also `0 1 * * *` = täglich 01:00 Uhr
- Notfallmanagement nach **BSI-Standard 200-4**: siehe [desaster-recovery-plan.md](desaster-recovery-plan.md)
- **Ein Backup ohne Restore-Test ist wertlos.**

## Webserver, TLS und Proxy

- ⭐ **Namensbasierte vhosts:** mehrere Websites auf einer IP; Apache wählt anhand des HTTP-Headers `Host:`
- ⭐ **Reverse Proxy:** nimmt Anfragen von Clients an und leitet sie an interne Server weiter (Schutz, ein zentraler Einstiegspunkt, TLS-Terminierung).
  **Forward Proxy:** vermittelt Anfragen der Clients ins Internet.
- ⭐ **HTTPS = HTTP über TLS**, Port 443
- **Zertifikat:** selbstsigniert (nicht vertrauenswürdig → Warnung im Browser) vs. von einer **CA** signiert (z. B. Let’s Encrypt)
- **Asymmetrische Verschlüsselung** für Schlüsselaustausch/Authentisierung, **symmetrische** für die eigentlichen Daten (hybrides Verfahren)
- **HTTP → HTTPS-Weiterleitung:** `Redirect` im Port-80-vhost (Alternative: `mod_rewrite`, HSTS)

## SSH

- **Public-Key-Authentifizierung:** privater Schlüssel bleibt beim Client, öffentlicher Schlüssel liegt in `~/.ssh/authorized_keys` auf dem Server
- **Portänderung** reduziert nur Bot-Scans und ist **keine** echte Sicherheitsmaßnahme. Wichtig sind Updates und Schlüssel statt Passwörter.

## E-Mail

| Protokoll | Port | Aufgabe |
|---|---|---|
| ⭐ **SMTP** | 25 | Mailtransport zwischen Servern (MTA ↔ MTA) |
| **Submission** | 587 (STARTTLS) | Client sendet Mail an den eigenen Server |
| **SMTPS** | 465 (implizites TLS) | Client sendet Mail, verschlüsselt ab Verbindungsbeginn |
| ⭐ **IMAP** | 143 / 993 (TLS) | Mails bleiben auf dem Server, Synchronisation |
| **POP3** | 110 / 995 (TLS) | Mails werden heruntergeladen (meist gelöscht) |

- **MUA** (Mail User Agent, z. B. Thunderbird) · **MTA** (Mail Transfer Agent, z. B. Postfix) · **MDA** (Mail Delivery Agent, z. B. Dovecot)
- **STARTTLS** = Verbindung startet unverschlüsselt und wird dann auf TLS hochgestuft. **Implizites TLS** = von Anfang an verschlüsselt.
- **SPF / DKIM / DMARC** = Schutz gegen gefälschte Absender (im Lab deaktiviert, da nur internes Netz)

## Zeit (NTP)

- **NTP** über **UDP 123**; Stratum = Abstand zur Referenzuhr
- Richtige Zeit ist wichtig für Logs, Zertifikate, Kerberos/AD und Backups.
