#import "../config.typ": *

= Software

== App
#figure(
image("../Bilder/Appscreen.png", width: 50%),
caption: [
Startbildschirm
],)
Die App dient zum Einstellen vieler Parameter. Sie ermöglicht es die Sprache, den Modus, die Rundenzahl und Spielernamen einzustellen so wie die Verbindung zum Hauptmodul Display herzustellen. \
Es gibt verschiedene Modi, die unterschiedliche Schwierigkeitsgrade bieten. Je nach Modus variiert die Anzahl der Runden und die Schwierigkeit der Steuerung. Unter Schwierigkeit der Steuerung versteht man mit welcher Motorleistung die Autosfahren.
- Modis:
  #figure(
    image("../Bilder/Modis.png", width: 100%),

    caption: [
      Modi Definition
    ]
  )
  - DefaultLaps: Hier werden die Rundenanzahl standardisiert.
  - speedFactor: Hier wird die Motorleistung eingestellt. Zum Beispiel: 0.5f bedeutet, dass die Autos mit halber Leistung fahren.

\
Nach dem start des Rennens zeigt die App die dauer (mit einer Timer Methode) und den Runden fortschritt der Spieler. Nach dem beenden des Rennes werden die Spieler des aktuellen Rennens nach der Bestzeit sortiert und angezeigt. Danach hat man die wahl wieder zum Hauptmenü zu gelangen oder sich das gesamte Ranking aller Rennen anzusehen. Diese werden nach der Bestzeit am Tag, Woche Monat, Gesamt und nach schnellste Runde sortiert.\ \


== Hauptmodul Display
Das Display XX verfügt über einen Kapazitiven Touchscreen, welcher einfache Einstellungen über das Display ermöglicht.
- Modi (einstellbar)
- Spieler anzahl
- Start/Stop
- Podium
Um einen sauberen Übergang beim drücken der Buttons zu simulieren, wurde eine Button Klasse erstellt, welche die Logik für das Drücken der Buttons enthält. Es wird überprüft, ob der Button gedrückt wurde, trifft das zu, wird die entsprechende Funktion ausgeführt. 
Ohne der Klasse würde bei jedem klick auf einen Butten das ganze Display aktualisiert werden, was zu einem unsauberen Übergang führt. Mit der Klasse wird nur der Bereich aktualisiert, wo sich was ändert.

\ \
== TCP Protokoll

#figure(
  image("../Bilder/TCPApp.png", width: 100%),

  caption: [
    TCP Deklaration in 
  ]
)

Um eine Verbindung zwischen der App und dem Hauptmodul Display herzustellen, wird das TCP Protokoll verwendet. Dieses ermöglicht eine Bidirektionale Kommunikation zwischen den beiden Geräten. Das dient dazu, dass Änderungen, wie das Einstellen der Modi oder Spielernamen, auf das Display übertragen werden können.\ 

In dieser Konfiguration zählt der ESP32S3 als TCP-Server, der auf einem definierten Port (8080) auf eingehende Verbindungsanfragen der App wartet.\ \

- Synchronisation und Datenübertragung\ Um sicherzustellen, dass beide Geräte immer den gleichen Systemstatus anzeigen, wurde ein zeilenbasiertes Protokoll entwickelt.\ Jede Nachricht wird mit einem Newline-Zeichen (\n) abgeschlossen, damit der Empfänger das Ende eines Befehls eindeutig erkennt. Dies ist notwendig, da TCP die Daten als kontinuierlichen Strom versendet.\ Sobald in der App ein Parameter wie der Spielmodus oder die Rundenzahl geändert wird, sendet die App sofort ein entsprechendes Datenpaket an das Display. Ein Befehl wie MODUS: Schwer bewirkt am Display eine sofortige Aktualisierung der Variable und einen Redraw der Benutzeroberfläche. Dieser Prozess funktioniert auch in die umgekehrte Richtung: Wird am Display der "Start"- oder "Modus"-Button gedrückt, erhält die App das Signal zum Starten des Renn-Timers beziehungsweise das ändern des Moduses.
\
- Echtzeitverhalten\ Bei der Softwareimplementierung wurde besonders auf ein nicht-blockierendes Design geachtet. Da das Hauptmodul gleichzeitig den Touchscreen abfragen und das Display aktualisieren muss, darf der Netzwerkcode den Prozessor nicht aufhalten.\ Die Abfrage von eingehenden Daten erfolgt daher in jedem Programmdurchlauf, ohne den restlichen Ablauf zu verzögern.
\
Sollte die Verbindung zwischenzeitlich unterbrochen werden, verfügt die App über eine automatische Reconnect-Logik.\ Diese erkennt die unterbrochene Verbindung durch einen Timeout und versucht eigenständig, den Socket neu zu initialisieren, um die Verbindung wiederherzustellen. Während der Reconnect-Phase zeigt die App eine entsprechende Meldung an. Sobald die Verbindung wiederhergestellt ist, werden alle zuvor gesendeten Befehle erneut übertragen, um sicherzustellen, dass das Display den aktuellen Status korrekt anzeigt.

\ 
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