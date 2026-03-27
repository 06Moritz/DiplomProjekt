#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author2, #klasse])

= Software <sec_bahn-software>

Die Software des Hauptmoduls dient zum Rundenzeit messen mittels NFC, erkennen von Autos, sowie zum Anzeigen von Informationen auf einem Display.



== @nfc:long
Die Rundenzeit wird über NFC gemessen. Jedes Auto hat eine eingebaute NFC Spule. Sobald ein Auto über den NFC-Tag fährt, wird die @id:short des Fahrzeugs über @i2c an den @esp32:short geschickt. Die Rundenzeit wird berechnet und am Display dargestellt.
\
\
```c
success = nfc.readPassiveTargetID(
  PN532_MIFARE_ISO14443A,
  uuid,
  &uuidLength,
  50);

    if (success) {
      for(int i=0; i<players; i++){
        if (memcmp(uuid, playeruuid[i], uuidLength) == 0) {
          // Rundenzeit berechnen
          unsigned long currentTime = millis();
          unsigned long lapTime = currentTime - lastLapTimes[i];
          lastLapTimes[i] = currentTime;

          // Rundenzeit über TCP senden
          sendLapTime(i, lapTime);
          }
        }
      }
    }
     vTaskDelay(10 / portTICK_PERIOD_MS); }
  }
```
Der @esp32 verfügt über 2 Kerne, um genaue Zeiten zu messen wird ein Kern für die Zeitmessung reserviert.
Wenn ein Auto erkannt wird, rechnet der Prozess die Zeit für die Runde aus und sendet sie an die APP.

== @ble:long
Die @wifi Zugangsdaten werden über @ble durch die App eingestellt.
Es werden kleine Datenpakete vom Hauptmodul an die Controler mit @ble Advertising gesendet.
\
@ble Advertising ermöglicht es, kleine Datenpakete vom Hauptmodul an den Controller zu senden, ohne sich zu verbinden. Dies ist besonders nützlich für die Übertragung von Informationen wie Rundenzeiten oder Statusupdates, da es eine schnelle und effiziente Kommunikation ermöglicht, ohne den Overhead einer vollständigen Verbindung aufzubauen.
\

//einkasteln


```c
std::string strData = "";
  strData += (char)MANUFACTURER_ID & 0xFF;
  strData += (char)(MANUFACTURER_ID >> 8) & 0xFF;
  for(int i=0; i<3; i++) {
    strData += (char)myData[i];
  }

  oAdvertisementData.setManufacturerData(strData);

  pAdvertising->setAdvertisementData(oAdvertisementData);
  pAdvertising->setScanResponse(false); // Scan Response ist hier nicht nötig

  // Start Advertising
  pAdvertising->start();
```
Es werden Auto spezifische Werte wie Rundenzeit oder Startnummer übertragen. Die Daten werden in einen String umgewandelt und gesendet.
\ \


== @tcp:long
@tcp ist ein Netzwerk Protokoll, das benutzt wird, um Daten vom Hauptmodul an die App zu senden. Dafür ist eine @wifi verbindung notwendig.
Wenn keine Netzwerk Verbindung besteht, verbindet sich die App über Bluetooth und der Nutzer kann die Zugangsdaten über die App eingeben.
Sobald sich der ESP über @wifi verbunden hat, nimmt er verbindung mit der App übber @tcp auf.

Mit dem @tcp\-Protokoll wird sichergestellt, dass Signale von der App und dem Display in beide Richtungen übertragen werden können.
\
```c
    if (!client.connected()) {
        client = server.available();
    } else if (client.available()) {
        String cmd = client.readStringUntil('\n');
        cmd.trim();
        if (cmd.startsWith("MODUS:")) {
            currentMode = cmd.substring(6);
            if (gameState == MENU) drawMenu();
        } else if (cmd.equals("Start")) {
            gameState = RACE;
            drawRace();
        }

```
Der Codeausschnitt beschreibt die Verarbeitung von @tcp Befehlen auf dem Hauptmodul Display. Es wird überprüft, ob die App  verbunden ist. Je nach Befehl wird der Modus geändert oder das Rennen gestartet.



