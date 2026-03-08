#import "../config.typ"

= Hardware //blockdiagramm einfügen 

? Der Controller ist Bateriebetrieben und besteht aus einem Mikrocontroller, einem Laderegler, einem ADC und einer Spannungsversorgung.

#figure(
image("../Bilder/DA BlockschaltbildCont.png", width: 100%),
caption: [Blockschaltbild des Systems],
)


== Spannungsversorgung
? Der Controller mit einem Lipo Akku betrieben, der eine Spannung von 3,7V liefert. Der Laderegler sorgt dafür, dass der Akku sicher geladen wird und schützt vor Überladung und Tiefentladung. @sec-charger

== Laderegler <sec-charger>

#figure(
image("../Bilder/laderegler.png", width: 100%),
caption: [Laderegler],
)

? Als LAderegeler wird der TP4056 verwendet, der speziell für das Laden von Lithium-Ionen-Akkus entwickelt wurde. Er bietet eine konstante Strom- und Spannungsregelung, um den Akku sicher und effizient zu laden.

TP4056 Laderegler:
- Konstantstrom- und Konstantspannungsregelung
- Überladungsschutz
- Tiefentladungsschutz

