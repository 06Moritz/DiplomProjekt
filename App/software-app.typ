#import "../config.typ": *

Die App dient zum Einstellen. Sie ermöglicht es die Sprache, den Modus, die Rundenzahl und Spielernamen einzustellen so wie die Verbindung zum Hauptmodul Display herzustellen.\ 
= Software

== App
#figure(
image("../Bilder/Appscreen.png", width: 50%),
caption: [
Startbildschirm
],)
\
Die App dient zum Einstellen vieler Parameter. Sie ermöglicht es die Sprache, den Modus, die Rundenzahl und Spielernamen einzustellen so wie die Verbindung zum Hauptmodul Display herzustellen. \
Es gibt verschiedene Modi, die unterschiedliche Schwierigkeitsgrade bieten. Je nach Modus variiert die Anzahl der Runden und die Schwierigkeit der Steuerung. Unter Schwierigkeit der Steuerung versteht man mit welcher Motorleistung die Autosfahren.
- Modis:

```c
  // Spielmodi Definition
enum class GameMode(
  val label: String, 
  val defaultLaps: Int, 
  val speedFactor: Float) 
  {
    EASY("Leicht", 5, 0.5f),
    MEDIUM("Mittel", 10, 0.75f),
    HARD("Schwer", 15, 1.0f)
}
```
\
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
Um einen sauberen Übergang beim drücken der Buttons zu simulieren, wurde eine Button Klasse erstellt, welche die Logik für das Drücken der Buttons enthält. Es wird überprüft, ob der Button gedrückt wurde, trifft das zu, wird die entsprechende Funktion ausgeführt. \
Ohne der Klasse würde bei jedem klick auf einen Butten das ganze Display aktualisiert werden. Mit der Klasse wird nur der Bereich aktualisiert, wo sich was ändern soll. Das ermöglicht es, die Benutzeroberfläche effizient zu aktualisieren und gleichzeitig eine reaktionsschnelle und flüssige Kommunikation zu erhalten.

\ \
Die Softwareseitige Umsetzung dieser selektiven Aktualisierung basiert auf der Kapselung von Positionsdaten und Zustandsvariablen innerhalb der Objektinstanzen. Die softwareseitige Umsetzung dieser selektiven Aktualisierung basiert auf der Kapselung von Positionsdaten und Zustandsvariablen innerhalb der Objektinstanzen. \ Bei einem registrierten Touch-Event werden die XY-Koordinaten des Sensors mit den Grenzwerten der Bounding-Box des jeweiligen Buttons verglichen. Eine Ausführung der verknüpften Logik erfolgt nur bei einer positiven Kollisionsabfrage. Durch diese Reduzierung der zu übertragenden Datenmenge über den Kommunikationsbus (z. B. SPI oder $I^2C$) wird die Prozessorlast gesenkt und das bei Vollbild-Refreshes übliche Screen-Flickering unterbunden. Zusätzlich wird durch eine softwareseitige Entprellung (Debouncing) sichergestellt, dass singuläre Berührungen nicht als fehlerhafte Mehrfach-Eingaben interpretiert werden. Diese Methode ermöglicht es, die Benutzeroberfläche effizient zu aktualisieren und gleichzeitig eine reaktionsschnelle und flüssige Kommunikation zu erhalten. 

Kapselung von Positionsdaten bedeutet, dass die Koordinaten und Dimensionen eines Buttons innerhalb der Button-Klasse gespeichert werden. Dadurch kann die Klasse selbstständig überprüfen, ob ein Touch-Event innerhalb ihrer Grenzen liegt.

\ \
== @tcp:both Programmierung
\
Um eine Verbindung zwischen der App und dem Hauptmodul Display herzustellen, wird das @tcp Protokoll verwendet. Dieses ermöglicht eine Bidirektionale Kommunikation zwischen den beiden Geräten. Das dient dazu, dass Änderungen, wie das Einstellen der Modi oder Spielernamen, auf das Display übertragen werden können.\ 

In dieser Konfiguration zählt der ESP32S3 als @tcp -Server, der auf einem definierten Port (8080) auf eingehende Verbindungsanfragen der App wartet.\ \

Bevor die App mit dem Display verbunden wurde, wurde ein Test Code geschrieben. Um das Signal auszuschreiben, das von der App an den ESP32 gesendet wird und im Terminal ausgeschrieben werden.

Terminal:

```c
  >>> Modus gesetzt: LEICHT (1)
  >>> Rundenzahl: 5
  >>> Modus gesetzt: MITTEL (2)
  >>> Rundenzahl: 10
  >>> Modus gesetzt: SCHWER (3)
  >>> Rundenzahl: 15
  >>> Spieler: Spieler1
  >>> Spieler: Spieler2
  >>> Spieler: Spieler3
  >>> Spieler: Spieler4

```
\
Als nächsten schritt wurde der ESP32 als Sender und die App als Empfänger konfiguriert, um die Datenübertragung zu testen.
Ins Terminal schreibt man zum Beispiel Spieler: Spieler1 oder Modus: Leicht. In der App wird dann die entsprechende Variable aktualisiert.
\ \
In das Terminal wurden folgende Parameter eingegeben:
```c
  Spieler: Spieler1
  Modus: Leicht
  Rundenzahl: 3

```
In der App wurden die eingegebenen Parameter aktualisiert. Spieler1 wurde als Spielername angezeigt, der Modus wurde auf leicht gestellt und die Rundenzahl auf drei.
\ \
#figure(
image("../Bilder/TestCode.png", width: 50%),
caption: [
Test Code
],)

\ \
Anschließend wurden die App und der ESP32 als Sender und Empfänger initialisiert. 
 \ \
@tcp Codeteil aus der App:
  ```c
    suspend fun connect(): BufferedReader? {
        return withContext(Dispatchers.IO) {
            try {
                if (socket == null || socket!!.isClosed || !socket!!.isConnected)
                {
                    socket = Socket(ESP_IP, ESP_PORT)
                    socket!!.tcpNoDelay = true
                    socket!!.soTimeout = 5000
                    writer = PrintWriter(socket!!.getOutputStream(), true)
                    reader = BufferedReader
                    (InputStreamReader(socket!!.getInputStream()))
                }
                reader
            } 
            catch (e: Exception) {
                e.printStackTrace()
                null
            }
        }
    }
   ```
- `suspend fun connect()`: Asynchrone Funktion zum Aufbau der Netzwerkverbindung
- `withContext(Dispatchers.IO)`: Ausführung im Hintergrundthread für Netzwerkzugriffe
- `if (socket == null || ...)`: Überprüfung, ob bereits eine Verbindung besteht
- `Socket(ESP_IP, ESP_PORT)`: Aufbau der TCP-Verbindung zum Mikrocontroller
- `tcpNoDelay = true`: Schnellere Datenübertragung ohne Verzögerung
- `soTimeout = 5000`: Begrenzung der Wartezeit auf eine Serverantwort
- `PrintWriter(...)`: Senden von Daten an den Mikrocontroller
- `BufferedReader(...)`: Empfangen von Daten vom Mikrocontroller
- `catch (Exception)`: Fehlerbehandlung zur Vermeidung von Abstürzen

\
In dem Code der App wird ein Client Socket erstellt, der sich mit der IP-Adresse des ESP32 und dem Port 8080 verbindet und eine Verbindungsanfrage an den ESP32 sendet. 
\ \ \ \ \

@tcp Codeteil aus dem ESP32:
```c
- Verbindung aufbauen
  WiFiServer server(8080);
  WiFiClient client;

- Verbindungsanfrage akzeptieren
  void loop() {
    if (!client || !client.connected()) {
        client = server.available();
    } 

-Daten empfangen
    else if (client.available()) {
        String line = client.readStringUntil('\n');
        parseCommand(line);
    }

- Daten senden
  if(client.connected()) 
  {
      client.println("Modus:" + currentMode);
  }

- Kommunikation beenden
  if(client.connected()) 
  {
     client.println("Stop"); 
  }

```
In dem Code des ESP32 wird ein Server Socket erstellt, der auf Port 8080 lauscht und Verbindungsanfragen der App akteptiert. Ist eine Verbindung hergestellt, können Daten in beide Richtungen gesendet und empfangen werden.
\ \




=== Synchronisation \ 
Um sicherzustellen, dass beide Geräte immer den gleichen Systemstatus anzeigen, wurde ein zeilenbasiertes Protokoll entwickelt.\ Jede Nachricht wird mit einem Newline-Zeichen (\n) abgeschlossen, damit der Empfänger das Ende eines Befehls eindeutig erkennt. Dies ist notwendig, da @tcp die Daten als kontinuierlichen Strom versendet.\ Sobald in der App ein Parameter wie der Spielmodus oder die Rundenzahl geändert wird, sendet die App sofort ein entsprechendes Datenpaket an das Display. Ein Befehl wie MODUS: Schwer bewirkt am Display eine sofortige Aktualisierung der Variable und einen Redraw der Benutzeroberfläche. Dieser Prozess funktioniert auch in die umgekehrte Richtung: Wird am Display der "Start"- oder "Modus"-Button gedrückt, erhält die App das Signal zum Starten des Renn-Timers beziehungsweise das ändern des Moduses.
\ \
=== Echtzeitverhalten\ 
Bei der Softwareimplementierung wurde besonders auf ein nicht-blockierendes Design geachtet. Da das Hauptmodul gleichzeitig den Touchscreen abfragen und das Display aktualisieren muss, darf der Netzwerkcode den Prozessor nicht aufhalten.\ Die Abfrage von eingehenden Daten erfolgt daher in jedem Programmdurchlauf, ohne den restlichen Ablauf zu verzögern.
\
Sollte die Verbindung zwischenzeitlich unterbrochen werden, verfügt die App über eine automatische Reconnect-Logik.\ Diese erkennt die unterbrochene Verbindung durch einen Timeout und versucht eigenständig, den Socket neu zu initialisieren, um die Verbindung wiederherzustellen. Während der Reconnect-Phase zeigt die App eine entsprechende Meldung an. Sobald die Verbindung wiederhergestellt ist, werden alle zuvor gesendeten Befehle erneut übertragen, um sicherzustellen, dass das Display den aktuellen Status korrekt anzeigt. 
\ \ 
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

- Das Display wird über die SPI Schnittstelle mit dem Esp32S3 verbunden, welcher die Daten empfängt und verarbeitet. Die Informationen werden in Echzeit übertragen.
- Auf dem Display werden Spiel Informationen
 - Spielername
 - Autoname
 - Rundenanzahl
 über die SPI Schnittstelle vom ESP32S3 übertragen.

 Die aktuellen Auto Informationen
  - Motorleistung (PWM)
 werden über BLE übertragen, da diese Informationen sehr schnell aktualisiert werden müssen und eine stabile Verbindung erfordern. 
