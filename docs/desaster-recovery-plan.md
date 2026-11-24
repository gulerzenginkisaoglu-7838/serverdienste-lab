# Aufgabe 26: Desaster Recovery Plan

**Standard:** BSI-Standard 200-4 (Business Continuity Management / Notfallmanagement)

[← zurück zur README](../README.md)

---

## Frage 1: Welche vier Phasen umfasst das Notfallmanagement laut BSI und was ist das Ziel jeder Phase?

### Phase 1: Initiierung und BCM-Analyse
- **Inhalt:** Aufbau der Notfallorganisation (Rollen, Verantwortlichkeiten) und Verabschiedung der Notfall-Leitlinie durch die Leitungsebene. Durchführung der Business Impact Analyse (BIA) und einer Risikoanalyse.
- **Ziel:** Kritische Geschäftsprozesse identifizieren, maximale Ausfallzeiten (RTO/RPO) festlegen und Bedrohungen bewerten.

### Phase 2: Notfallkonzeption
- **Inhalt:** Ausarbeitung von Kontinuitäts- und Wiederherstellungsstrategien, z. B. Redundanzen, Ausweichrechenzentren und Backup-Konzepte wie die 3-2-1-Regel. Festlegung vorbeugender Maßnahmen.
- **Ziel:** Ausfälle vorbeugend verhindern oder Alternativlösungen für den Weiterbetrieb vorbereiten.

### Phase 3: Notfallbewältigung und Pläne
- **Inhalt:** Erstellung konkreter Handlungsanweisungen: Alarmierungspläne, Geschäftsfortführungspläne (Notbetrieb) und detaillierte Wiederanlaufpläne für die IT-Systeme. Alles wird im Notfallhandbuch zusammengefasst.
- **Ziel:** Im Ernstfall sofort handlungsfähig sein und den Schaden koordiniert und ohne Zeitverlust begrenzen.

### Phase 4: Tests, Übungen und kontinuierliche Verbesserung (KVP)
- **Inhalt:** Regelmäßige Notfallübungen (z. B. Restore-Tests von Backups, Stabsübungen) und Schulung aller Mitarbeitenden. Die Pläne werden bei Änderungen aktualisiert.
- **Ziel:** Praxistauglichkeit und Wirksamkeit der Pläne überprüfen und kontinuierlich verbessern.

---

## Frage 2: Was ist ein Notfallhandbuch und welche zentralen Inhalte sollte es laut BSI enthalten?

### Definition
Ein zentrales, sofort greifbares Nachschlagewerk (gedruckt und digital). Es bündelt alle Anweisungen, Pläne und Kontakte, die nötig sind, um einen Notfall oder eine Krise schnell und strukturiert zu bewältigen.

### Zentrale Inhalte
1. **Alarmierungs- und Eskalationsplan:** Wer muss wann benachrichtigt werden? Kontaktdaten von Krisenstab, Geschäftsleitung, IT-Administration, Feuerwehr, Polizei und externen Dienstleistern.
2. **Kriterien für die Notfall-Einstufung:** Klare Schwellenwerte, um eine normale Betriebsstörung (Incident) von einem echten Notfall oder einer Krise zu unterscheiden.
3. **Geschäftsfortführungspläne (Workarounds):** Maßnahmen für den Mindestbetrieb, z. B. manuelle Prozesse, Notstrom und Ausweicharbeitsplätze.
4. **Wiederanlauf- und Wiederherstellungspläne:** Detaillierte Schritt-für-Schritt-Anleitungen (Runbooks) zur Wiederinbetriebnahme von Servern, Netzwerken, Datenbanken und Backups.

---

## Frage 3: Warum ist die regelmäßige Durchführung von Tests und Übungen besonders wichtig?

1. **Wiederherstellbarkeit prüfen (Backup-Restore):** Ein Backup ohne erfolgreichen Restore-Test ist wertlos. Erst der Test beweist, dass die Daten unbeschädigt und lesbar sind.
2. **Aktualität sichern:** IT-Infrastrukturen ändern sich laufend (neue IP-Adressen, Software-Updates, Personalwechsel). Übungen decken veraltete Kontaktdaten und unvollständige Anleitungen auf.
3. **Handlungssicherheit und Routine:** In echten Notsituationen herrscht Stress. Übungen schaffen Routine, sodass die Verantwortlichen ruhig nach Checkliste handeln können.
4. **Schwachstellen rechtzeitig beheben:** Fehler im Notfallkonzept werden im geschützten Testbetrieb sichtbar und können korrigiert werden, bevor ein echter Schaden entsteht.

---

## Prüfungsrelevante Begriffe (IHK AP1/AP2)

- **RTO (Recovery Time Objective):** Maximal tolerierbare Ausfallzeit. Wie lange darf das System offline sein?
- **RPO (Recovery Point Objective):** Maximal tolerierbarer Datenverlust. Bis zu welchem Zeitpunkt müssen die Daten wiederhergestellt werden? Beispiel: höchstens 1 Stunde Datenverlust.
- **3-2-1-Backup-Regel:** 3 Kopien der Daten, auf 2 verschiedenen Medientypen, mindestens 1 Kopie extern (außer Haus).

## Umsetzung im Lab

Das automatisierte Backup auf SRV2 setzt einen Teil davon praktisch um. Es bindet das iSCSI-Target `target02` nur während der Sicherung ein (Offline-Backup) und läuft täglich per cron.
➡️ [`configs/srv2/backup/`](../configs/srv2/backup/)
