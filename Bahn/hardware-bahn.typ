#import "../config.typ": *
#aktueller_autor.update(author1) // Melanie

= Hardware
*!* Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung

== Blockschaltbild
#figure(
image("../Bilder/Blockschaltbild-StartZiel.png", width: 100%),
caption: [
Blockschaltbild des Systems (Bahn)
],
)

== Spannungsversorgung
USB C PowerDelivery Ausgang für die Versorgung der Elektronik

== Spannungsregler - Buck
12V auf 5V 

== Spannungsregler - LDO
5V auf 3,3V für das Display und ESP

== ESP32 S3
Verwendet: 2x I2C für NFC

== Ladeausgang
USB C Ausgang für die Versorgung der Ladestation

== Leiterplatte
Schaltplan und Platine?

#pagebreak()