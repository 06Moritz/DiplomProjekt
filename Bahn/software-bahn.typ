#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author2, #klasse])

= Software <sec_bahn-software>

Die Software des Basismoduls dient zum Rundenzeit messen mittels NFC, erkennen von Autos, sowie zum Anzeigen von Informationen auf einem Display.



== Near Field Communication <sec_nfc-bahn-sw>
Die Rundenzeit wird über NFC gemessen. Jedes Auto hat eine eingebaute NFC Spule. Sobald ein Auto über den NFC-Tag fährt, wird über @i2c die @id des Fahrzeugs gesendet. Es wird die Rundenzeit berechnet und am Display angezeigt. 
\

Der @esp32:short hat zwei Kerne (siehe @sec_bahn-esp). Ein Kern ist für die Zeitmessung reserviert um präzise zu messen ohne unterbrochen zu werden.
Bei der Zeitmessung wird nach der @id des Autos gesucht und die Zeit berechnet.

== Bluetooth Low Energy <sec-ble_bahn>

#figure(
  image("/Bilder/flowchart-hmble.png", width: 80%),
  caption: [Blockschaltbild BLE Kommunikation Bahn]
)\
Die @wifi Zugangsdaten werden über @ble durch die App eingestellt.
Es werden Informationen vom Basismodul an die Controller mit @ble Advertising gesendet.
\
@ble Advertising ermöglicht es, kleine Datenpakete vom Basismodul an den Controller zu senden, ohne sich zu verbinden. Dies ist besonders nützlich für die Übertragung von Informationen wie Rundenzeiten oder Statusupdates, da es eine schnelle und effiziente Kommunikation ermöglicht, ohne den Overhead einer vollständigen Verbindung aufzubauen.

\
Es werden Auto spezifische Werte wie Rundenzeit oder Spielername übertragen. Die Daten werden packetiert und gesendet.
\

#figure(
  image("/Bilder/App/Datenverb.png", width: 80%),
  caption: [Blockschaltbild TCP Kommunikation Bahn]
)\

Übersicht Packettypen:
#figure(
  align(center)[
    #set text(size: 12pt)
    #table(
      columns: (120pt, 240pt),
      inset: 5pt,
      stroke: 0.3pt + black,
      align: center,

      [*Hex*], [*Pakettyp*],
      [0x00], [Spielername],
      [0x01], [Autonummer],
      [0x02], [schnellste Runde],
      [0x03], [abweichung zur schnellsten Runde],
      [0x04], [Modus],
      [0x05], [Zeitstempel],
      [0x06], [Rundenanzahl],
      [0x07], [Durchschnittsgeschwindigkeit],
    )
  ],
  caption: [Daten],
) <fig-tmc5160driveroverview>



== Transmission Control Protocol
@tcp ist ein Netzwerk Protokoll, das benutzt wird, um Daten vom Basismodul an die App zu senden. Dafür ist eine @wifi:short\-Verbindung notwendig.
Wenn keine Netzwerkverbindung besteht, verbindet sich die App über Bluetooth (siehe @sec-ble_bahn).
Sobald sich der @esp32:short über @wifi verbunden hat, nimmt er Verbindung mit der App über @tcp auf.

Mit dem @tcp\-Protokoll wird sichergestellt, dass Signale von der App und dem Display in beide Richtungen übertragen werden können.
\

#figure(
  image("/Bilder/BlockdiagrammTCP.png", width: 100%),
  caption: [Blockschaltbild TCP Kommunikation],
)



Der Codeausschnitt beschreibt die Verarbeitung von @tcp Befehlen auf dem Display des Basismoduls. Es wird überprüft, ob die App  verbunden ist. Je nach Befehl wird der Modus geändert oder das Rennen gestartet.



