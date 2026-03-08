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
*!* Als Motor wird ein 12V Gleichstrommotor verwendet, der über eine H-Brücke gesteuert wird. Die H-Brücke ermöglicht es, die Drehrichtung des Motors zu ändern und die Geschwindigkeit zu steuern. siehe @sec-hbridge Die Motorleistung wird über @pwm gesteuert. Der Motor hat folgende technische Daten: \
- Nennspannung: 12V
- Leerlaufstrom: 0.14A
- Leerlaufdrehzahl: 16500 U/min

Der Motor wurde aufgrund folgender Kriterien ausgewählt: \
- Hohe Spannung (12V) für ausreichend Leistung
- Drehzahl wurde wurde gewählt um eine Geschwindigkeit von ca. 8m/s zu erreichen bei 15mm Raddurchmesser. 
$ U = 0.015 upright("m") *pi=0.0045m $ 
$ (8m/s)/(0.0045m) *60s= 9600U/m $

Der Motor soll belastet eine Drehzahl von mindestens 9600 U/min erreichen, um die gewünschte Geschwindigkeit zu erreichen.

Für größeres Drehmoment ist ein Getriebe verbaut siehe /*@sec-getriebe*/




== H-Brückenschaltung<sec-hbridge>

#figure(
image("../Bilder/HBrueke.png", width: 50%),
caption: [
H-Brückenschaltung
],
)

*!* Eine H-Brücke ist eine Schaltung mit der man Motoren ansteuern kann. Die Drehrichtung kann durch die Ansteuerung der Transistoren geändert werden. Mit der Brücke kann man mit Signalspannung Motoren mit viel höherer Spannung steuren. @hbrueke

== Hauptcontroller – WCH CH585
*!* https://www.wch-ic.com/products/CH585.html \
Der Hauptcontroller ist ein Risc-V Microcontroller von WCH. Er hat native Periferals für Bluetooth Low Energy (BLE) und Near Field Communication (NFC).

== Antennendesign – BLE 
*!* @ble hat eine Frequenz von 2.4GHz, dafür eignet sich am besten eine "Inverteted-F" Antenne. Beim entwickeln der Antenne sind einige Punkte zu beachten:
- 50 \u{03A9} Wellenwiderstand der Leitung von der Antenne zum Anpassungsnetzwerk
- Antennen GND mit vielen Durchkontaktierungen mit GND verbinden
- keine GND Fläche unter der Antenne 
- hinter der Antenne GND mit vielen Vias setzen @antennaSource
Für die Berechnung des Wellenwiderstandes wurde PCB-tookit verwendet, dabei wurden folgende Parameter verwendet: \

- parameter

$w=((5.98*h)/(e^(((sqrt(e_r+ 1.41)*Z_0)/87)))-t)*1/0.8$ @Wellenwiderstand

t=0.035mm (Kupferdicke)\
h=1.5mm (Dicke des Dielektrikums)\
e_r=4.5 (Dielektrizitätskonstante)\
Z_0=50 \u{03A9} (Wellenwiderstand)

$w=((5.98*1.5)/(e^(((sqrt(4.5+ 1.41)*50)/87)))-0.035)*1/0.8 = 2.73"mm" => 106"mil"$

#figure(
image("../Bilder/antenna.png", width: 50%),
caption: [
BLE Antennendesign
],
)

== Derhzahlsensor 
! Die Drehzahl wird optisch mit einem VCNT2020 gemessen. Der Sensor besteht aus einer Infrarot LED und einem Fototransistor. Auf der Antriebswelle ist das Zahnrad zu Hälfte schwarz bemalt, wenn sich die Welle dreht ändert sich die Lichtintensität, die der Sensor empfängt, dadurch kann die Drehzahl berechnet werden. Das Ausgangssignal des Sensors wird mit einem Komperator aufbereitet, damit es vom Controller verarbeitet werden kann. 



== NFC Antenne 
#figure(
image("../Bilder/NFC.png", width: 50%),
caption: [
NFC Antenne
],
)

== Leiterplatte
