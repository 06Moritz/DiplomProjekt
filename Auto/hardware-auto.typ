#import "../config.typ": *
#aktueller_autor.update(author2) // Moritz

= Hardware
*!* Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung...

== Blockschaltbild
#figure(
image("../Bilder/BlockschaltbildAuto.png", width: 100%),
caption: [
Blockschaltbild des Systems
],
)

== Spannungsversorgung
*!* An den Schienen liegt eine Spannung von 12V an, die Schleifkontakte greifen die Spannung ab. Die Eingangspannung wird mit einem Buck-Converter auf 5V geregelt, dann auf 3,3V mit einem Linear-Regler. Die Stufenweise Spannungsregelung dient dazu eine sauberere Spannung mit geringen Ripple zu erhalten. 
== Motor 
*!* Als Motor wird ein 12V Gleichstrommotor verwendet, der über eine H-Brücke gesteuert wird. Die H-Brücke ermöglicht es, die Drehrichtung des Motors zu ändern und die Geschwindigkeit zu steuern. 
== Funkverbindung – BLE





































































== Zeitmessung – NFC

== Hauptcontroller – WCH CH585

== Leiterplatte
