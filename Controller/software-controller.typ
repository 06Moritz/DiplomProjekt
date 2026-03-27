#import "../config.typ":*

#aktueller_autor.update([#author2, #klasse])

= Software

== Controler Display
Das Controller Display XY zeigt folgende funktionen an:
- aktuelle Motorleistung (PWM)
- Timer
- Durchschnittsgeschwindigkeit
- beste Rundendauer
- abweichung zur besten
- Spielername
- Zugewiesenes Auto
- Runden anzahl z.B.: 2/5 Runden // in dem fall leichter modus

Das Display dient dazu, wichtige Informationen während des Rennens anzuzeigen. Es zeigt die aktuelle Motorleistung an, die über die PWM gesteuert wird, sowie einen Timer, der die Dauer des Rennens anzeigt. In der mitte des Displays wird die Durchschnittsgescchwindigkeit angezeigt, welche mithilfe der Drehzahl des Motors berechnet wird. Darunter wird die schnellste Runde angezeigt, sowie die Abweichung. 
\
$ v = (n*π*d)/60 $

- v: Geschwindigkeit in m/s
- n: Drehzahl in U/min
- d: Durchmesser des Rades in m 
Damit man auf dem Display die Geschwindigkeit in Meter pro Sekunde angezeigt bekommt, wird die Drehzahl durch 60 dividiert, um auf Umdrehung pro Sekunde zu kommen. \ \
Der Spielername und das zugewiesene Auto werden ebenfalls auf dem Display angeziegt, um verwechslungen zu vermeiden. Zudem wird die aktuelle Rundenanzahl angezeigt, um den Spieler zu informieren, in welcher Runde er sich befindet.

- Das Display wird mit dem CH572 verbunden, welcher die Daten empfängt und verarbeitet. Die Informationen werden in Echzeit übertragen.
- Auf dem Display werden Spiel Informationen
 - Spielername
 - Autoname
 - Rundenanzahl
 über die SPI Schnittstelle vom CH572 übertragen.

 Die aktuellen Auto Informationen
  - Motorleistung (PWM)
 werden über @ble übertragen, da diese Informationen sehr schnell aktualisiert werden müssen und eine stabile Verbindung erfordern. 
