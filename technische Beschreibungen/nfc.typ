#import "../config.typ": *
#aktueller_autor.update(author1) // Melanie

= @nfc:both
*!* @nfc:long ist ein internationaler Übertragungsstandard zum kontaktlosen Austausch von Daten über kurze Distanzen (bis ca. 10 cm). @nfc basiert auf der RFID-Technologie und arbeitet bei einer festen Frequenz von 13,56 MHz und bietet folgende Merkmale:

- extrem schneller Verbindungsaufbau ("Touch-and-Go") ohne Pairing-Prozess
- hohe Sicherheit durch die geringe Reichweite (Eavesdropping erschwert)
- passiver Betrieb möglich (Transponder benötigen keine eigene Batterie)

Je nach Anwendungsfall unterscheidet man bei @nfc drei wesentliche Betriebsarten:

- *Reader/Writer-Modus:* Das aktive Gerät (z. B. Smartphone) liest Daten von einem passiven NFC-Tag aus oder beschreibt diesen (z. B. Smart Poster).
- *Card-Emulation-Modus:* Das aktive Gerät verhält sich wie eine kontaktlose Chipkarte (z. B. beim kontaktlosen Bezahlen oder als Zutrittskarte).
- *Peer-to-Peer-Modus:* Zwei aktive Geräte tauschen direkt Daten miteinander aus (z. B. zum Austausch von Kontaktdaten).

Die Datenübertragung erfolgt mittels induktiver Kopplung zweier Antennenspulen. Das Magnetfeld des aktiven Teils induziert im Gegenpart eine Spannung, wobei der Datentransfer über Lastmodulation realisiert wird. Hierbei beeinflusst der Transponder das Feld des Lesegeräts durch gezielte Laständerungen, um Signale zurückzusenden. @nfcSource