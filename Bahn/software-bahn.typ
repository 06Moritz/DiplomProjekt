#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author3, #klasse])

= Software <sec_bahn-software>

Die Software des Hauptmoduls dient zum Rundenzeit messen mittels NFC, erkennen von Autos, sowie zum Anzeigen von Informationen auf einem Display.



== @nfc:long
Die Rundenzeit wird über NFC gemessen. Jedes Auto hat eine eingebaute NFC Spule. Sobald ein Auto über den NFC-Tag fährt, wird ein Signal an den ESP geschickt, welcher die Werte auswertet und die Rundenzeit über BLE an die App, den Hauptmodul Display und den Controller sendet.
\ I2C, zeitmessung genauer, @uuid, library, -> technischer
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

          // Rundenzeit über BLE senden
          sendLapTime(i, lapTime);
          }
        }
      }
    }
     vTaskDelay(10 / portTICK_PERIOD_MS); }
  }
```
auskommentieren, ausschreiben
vergleicht array und sucht spieler raus

zwei prozesse aufteilt

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
Die Daten werden in einen String umgewandelt und gesendet.
\ \


== @tcp:long
@tcp ist ein Netzwerk Protokoll, das benutzt wird, um Daten vom Hauptmodul an die App zu senden. Dafür ist eine @wifi verbindung notwendig.
Wenn keine WLAN Verbindung besteht, verbindet sich die App über Bluetooth und der Nutzer kann die Zugangsdaten über die App eingeben.
Sobald sich der ESP über @wifi verbunden hat,

Mit der @tcp programmierung wird sichergestellt, dass Signale von der APP und dem Display in beide Richtungen übertragen werden können.
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
tcp blaa bla


== Display
bla bla
tft library, I2C,

#figure(
  image("/Bilder/display.png", width: 80%),
  caption: [Display des Hauptmoduls]
)\



