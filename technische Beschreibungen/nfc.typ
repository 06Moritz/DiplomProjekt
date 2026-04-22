#import "../config.typ": *
#aktueller_autor.update([#author1, #klasse])

= Near Field Communication (NFC) <sec_nfc>
/* @nfc:long ist ein Übertragungsstandard zum kontaktlosen Austausch von Daten über kurze Distanzen (bis ca. 10 cm). @nfc basiert auf der @rfid:short\-Technologie, verwendet @ask bei einer festen Trägerfrequenz von 13,56 MHz und bietet folgende Merkmale:

- extrem schneller Verbindungsaufbau ("Tap-and-Go") ohne Pairing-Prozess
- hohe Sicherheit durch die geringe Reichweite (Eavesdropping erschwert)
- passiver Betrieb möglich (Transponder benötigen keine eigene Batterie)

Je nach Anwendungsfall unterscheidet man bei @nfc drei wesentliche Betriebsarten:

- Reader/Writer-Modus: Das aktive Gerät (z. B. Smartphone) liest Daten von einem passiven @nfc:short\-Tag aus oder beschreibt diesen (z. B. Smart Poster).
- Card-Emulation-Modus: Das aktive Gerät verhält sich wie eine kontaktlose Chipkarte (z. B. beim kontaktlosen Bezahlen oder als Zutrittskarte).
- Peer-to-Peer-Modus: Zwei aktive Geräte tauschen direkt Daten miteinander aus (z. B. zum Austausch von Kontaktdaten).

Die Datenübertragung erfolgt mittels induktiver Kopplung zweier Antennenspulen. Das Magnetfeld des aktiven Teils induziert im Gegenpart eine Spannung, wobei der Datentransfer über Lastmodulation realisiert wird. Hierbei beeinflusst der Transponder das Feld des Lesegeräts durch gezielte Laständerungen, um Signale zurückzusenden. @NfcSource2 \ \ */

@nfc:long ist ein Übertragungsstandard zum kontaktlosen Datenaustausch über kurze Distanzen (bis ca. 10cm). @nfc:short basiert auf der @rfid:short\-Technologie und verwendet @ask bei einer festen Trägerfrequenz von 13,56 MHz. 

Der Verbindungsaufbau erfolgt ohne Pairing-Prozess, wobei die induktive Energieübertragung einen passiven Betrieb des Transponders ermöglicht und die geringe Reichweite das Abhören erschwert. @NfcSource2

Die Datenübertragung wird mittels induktiver Kopplung zweier Antennenspulen umgesetzt. Der Transponder beeinflusst das Magnetfeld des Lesegeräts durch gezielte Laständerungen (Lastmodulation), um Daten zurückzusenden. Im Projekt kommen zwei Betriebsarten zum Einsatz:
- Reader/Writer-Modus: \ Das aktive Gerät liest Daten von einem passiven @nfc:short\-Tag aus.
- Card-Emulation-Modus: \ Das Gerät verhält sich wie ein passiver @nfc:short\-Tag.

#figure(
  image("/Bilder/nfcfunktion.png", width: 90%),
  caption: [NFC-Datenübertragung],
)

Verwendung im Projekt:
- Basismodul: \ Zwei @nfc:short\-Module im Reader/Writer-Modus lesen die @uuid:short der Fahrzeuge zur Rundenzeitmessung (siehe @sec_nfc-bahn-sw)
- Fahrzeug: \ Der interne @nfc:short\-Controller emuliert im @picc:short\-Modus einen passiven Tag. Im Pairing-Modus wechselt er in den @pcd:short\-Modus um die @mac:short\-Adresse des Controllers zu lesen (siehe @sec_fahrzeug-nfc-sw)

