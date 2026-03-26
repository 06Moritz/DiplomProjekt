#import "../config.typ": *
#aktueller_autor.update([#author1, #klasse])

= @buck:both <sec_buck>

*!* Ein @buck:long ist ein Gleichspannungswandler, der eine Eingangsspannung in eine niedrigere Ausgangsspannung wandelt. Im Gegensatz zu Linearreglern wird die Spannungsdifferenz nicht in Wärme umgewandelt, sondern durch ein getaktetes Prinzip umgesetzt. Dies ermöglicht: 

- hohe Wirkungsgrade (oft > 90%) durch minimale Spannungsdifferenz an den Schaltelementen
- geringe Wärmeentwicklung
- kompakte Bauformen aufgrund hoher Schaltfrequenzen
- stabile Ausgangsspannung trotz schwankender Eingangsspannung

// blablabla funktion erklären muss i erst ...
Der @buck nutzt eine Induktivität zur zeitgesteuerten Energiespeicherung. Ein @mosfet:short zerlegt die Eingangsspannung durch hochfrequentes Schalten in Pulse, wobei das Tastverhältnis der @pwm das Spannungsniveau am Ausgang definiert. Ein nachgeschalteter LC-Filter glättet diese Pulse schließlich zu einer stabilen Gleichspannung für den Lastkreis. @buckSource

#figure(
  fimage("/Bilder/buckconverter.png", width: 100%),
  caption: [@buck Schaltungprinzip],
)

//Das Funktionsprinzip basiert auf der Wechselwirkung zwischen einem elektronischen Schalter (MOSFET) und einer Speicherinduktivität. Wird der MOSFET geschlossen, steigt der Strom in der Induktivität rampenförmig an ($U = L dot (d i)/(d t)$), wodurch magnetische Energie gespeichert wird.
//Nach dem Öffnen des Schalters verhindert eine Freilaufdiode den abrupten Abriss des Stromflusses. Die Induktivität kehrt ihre Spannung um und fungiert nun als Energielieferant, der den Stromfluss durch die Last aufrechterhält, während sich das Magnetfeld langsam abbaut. Ein Kondensator glättet diese getaktete Energie zu einer konstanten Ausgangsspannung.

