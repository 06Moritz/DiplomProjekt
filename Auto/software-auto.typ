= Software
== BLE
*!* @ble ist für die Übertragung von kleinen Datenmengen optimiert, dadurch auch Energiesparend. Es funktioniert mit einem Server-Client System. Das schnelle und einfache Verbinden ist ein weiter Pluspunkt. @bleSource \
Implementierung in unserem Fall: Der Controller ist als Server konfiguriert, der Motorleistungswerte an das Auto sendet. Der Client ist das Auto,
- scannt nach Geräten
- Verbindet mit eingestellter MAC-Adresse
- Service- und Characteristic-Discovery
- Aktivieren von Notifications
- Verarbeitung empfangener Daten 
Gliederung:
Application
host layer
controller layer