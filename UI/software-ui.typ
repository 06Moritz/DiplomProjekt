#import "../config.typ": *
#aktueller_autor.update([#author3, #klasse])


Das @ui:long  besteht aus drei Modulen:
- App
- Basismodul Display
- Controller Display
\
Die Software ist in Kotlin für die App und in PlatformIO für die Displays programmiert.\
Die Kommunikation zwischen der App und dem Basismodul Display erfolgt über das @tcp Protokoll, während die Kommunikation zwischen dem Basismodul Display und dem Controller Display über @ble erfolgt. 

= App
== App Entwicklung
Die App dient zum Einstellen. Sie ermöglicht es die Sprache, den Modus, die Rundenzahl und Spielernamen einzustellen, sowie die Verbindung zum Basismodul herzustellen.\

#figure(
  image("/Bilder/App/Appscreen.png", width: 50%),
  caption: [Startbildschirm der App],
)

Es gibt verschiedene Modi, die unterschiedliche Schwierigkeitsgrade bieten. Je nach Modus variiert die Anzahl der Runden und die Schwierigkeit der Steuerung. Unter Schwierigkeit der Steuerung versteht man mit welcher Motorleistung die Autos fahren.

#pagebreak()
Modi Initialisierung:
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

- DefaultLaps: Jedem Modus ist eine Standardanzahl von Runden zugeordnet.
- speedFactor: Die Motorleistung werden eingestellt. Zum Beispiel: 0.5f bedeutet, dass die Autos mit halber Leistung fahren.

\
Beim Start des Rennens zeigt die App die Dauer (mit einer Timer Methode) und den Rundenfortschritt der Spieler an. Nach dem Beenden des Rennens werden die Spieler des aktuellen Rennens nach der Bestzeit sortiert und angezeigt. In diesem Menü hat man die Wahl wieder zum Hauptmenü zu gelangen oder sich das gesamte Ranking aller Rennen anzusehen. Diese werden nach folgenden Kriterien sortiert:
- Tag
- Woche
- Monat
- Gesamt
\
#figure(
  grid(
    columns: (1fr, 1fr),
    gutter: -10em,
    align: bottom + center,
    image("/Bilder/App/rennen.png", width: 40%), 
    image("/Bilder/App/podium.png", width: 40%),
  ),
  caption: [Rennen und schnellste Runde],
  gap: 1em,
)

- Rennen: Renndauer mit Spieleranzeige
- Platzierung: Spieler werden nach schnellster Zeit sortiert. Der Spieler mit der schnellsten Runde auf Platz 1, rot markiert und Rennzeit angezeigt.
\
#figure(
  grid(
    columns: 1fr,
    gutter: -10em,
    align: bottom + center,
    image("/Bilder/App/leaderboard.png", width: 25%),
  ),
  caption: [Leaderboard],
  gap: 1em,
)
- Leaderboard: Alle Spieler werden am @esp32:short mit ihrer Bestzeit gespeichert. In diesem Menü werden die Spieler nach Tag, Woche, Monat und Gesamt sortiert und angezeigt.

== Basismodul Display
Das Display MSP4031 verfügt über einen Kapazitiven Touchscreen, welcher einfache Einstellungen über das Display ermöglicht.
- Modi (einstellbar)
- Spieleranzahl
- Start/Stop
- Podium
Um das @ui Design zu erleichtern, wurde eine Button Klasse erstellt, welche die Logik für das Drücken der Buttons enthält. Es wird überprüft, ob der Button gedrückt wurde, trifft das zu, wird die entsprechende Funktion ausgeführt.

Durch Polymorphismus muss nicht jeder Button einzeln erstellt werden. Das ermöglicht es, die Benutzeroberfläche effizient zu aktualisieren und gleichzeitig eine reaktionsschnelle und flüssige Kommunikation zu erhalten.

\ 
Wenn das Display gedrückt sendet es über @i2c die XY-Koordinaten des Touch-Events and den Mikrocontroller. Es werden die Koordinaten mit den Positionen der Buttons verglichen. Wenn die Koordinaten innerhalb der Grenzen eines Buttons liegen, wird die Funktion des Buttons ausgeführt.
\
#figure(
  image("/Bilder/display.png", width: 80%),
  caption: [Display des Basismoduls]
)


\
Das Display des Basismoduls ist ein @tft:short\-Display, verfügt über @i2c\-Touch und hat eine Auflösung von 320*480 Pixeln. Es werden Spieler, Modis und Bestenliste angezeigt. 

- TFT_eSPI Library: Es wird die TFT_eSPI Library verwendet, um die grafische Benutzeroberfläche auf dem Display zu erstellen. Diese Bibliothek bietet Funktionen zum Zeichnen von Text, Formen und Bildern.

- @i2c: Das Display verfügt über @i2c. Durch die @i2c\-Schnittstelle werden XY Koordinaten übertragen, wodurch Touch Events erkannt und verarbeitet werden können. Durch Toucheingaben können der Modus geändert, Spieler hinzugefügt und das Rennen gestartet/gestoppt werden. @sourcei2c


Hier wird überprüft, ob der Start- oder Modus-Button gedrückt wurde.

#pagebreak()
/*```c
unsigned long now = millis();
    bool startIsPressed = (btnStart && btnStart->isPressed());
    bool modusIsPressed = (btnModus && btnModus->isPressed());

    if (startIsPressed && !startWasPressed &&
              (now - lastClick > debounceTime)) {
        lastClick = now;
        if (gameState == MENU) {
            gameState = RACE;
            drawRace();
        } else if (gameState == RACE) {
            finalTime = millis() - startTime;
            gameState = PODIUM;
            gameManager.endRace();
            drawPodium();
        } else if (gameState == PODIUM) {
            gameState = MENU;
            drawMenu();
        }
    }
    startWasPressed = startIsPressed;

```*/

Die Logik des Basismodul Displays funktioniert so, dass der Zustand der Buttons abgefragt wird. Der zugehörige Screen wird durch Zustandsautomaten ermittelt. \
Es gibt drei Zustände:
- Hauptmenü 
- Rennen
- Spielergebnis
Je nachdem welcher Button gedrückt wird, ändert sich der Zustand.

#figure(
  image("/Bilder/App/Blockdiagramm.png", width: 100%),
  caption: [Blockdiagramm der UI des Basismoduls],
)


== Transmission Control Protocol (TCP) Programmierung <sec-app-tcp>
Um eine Verbindung zwischen der App und dem Basismodul Display herzustellen, wird das @tcp Protokoll verwendet. Dieses ermöglicht eine Bidirektionale Kommunikation zwischen den beiden Geräten. Das dient dazu, dass Änderungen, wie das Einstellen der Modi oder Spielernamen, auf das Display übertragen werden können.\

In dieser Konfiguration zählt der @esp32:short\-S3 als @tcp -Server, der auf einem definierten Port (8080) auf eingehende Verbindungsanfragen der App wartet.\ 

=== Prototyp TCP Verbindung @sourceTCP
Vor der Verbindung der App mit dem Display wurde ein Test-Code geschrieben, um das Signal auszuschreiben, das von der App an den @esp32:short gesendet und im Terminal ausgeschrieben wird. \ \
Terminal Ausgabe:

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
Als nächsten schritt wurde der @esp32:short als Sender und die App als Empfänger konfiguriert, um die Datenübertragung zu testen.
Im Serial Terminal werden Befehle eingegeben. In der App wird dann die entsprechende Variable aktualisiert.
\ \
In das Terminal wurden folgende Parameter eingegeben:\

```c
  Spieler: Spieler1
  Modus: Leicht
  Rundenzahl: 3

```

/*
In der App wurden die eingegebenen Parameter aktualisiert. Spieler1 wurde als Spielername angezeigt, der Modus auf leicht gestellt und die Rundenzahl auf drei.*/

\ Senden der Daten vom @esp32:short an die App:
```c 
 if (Serial.available()) {
    String input = Serial.readStringUntil('\n');
    input.trim();

    if (client && client.connected()) {
      client.println(input);   
     }
  }
```
- `Serial.available()`: Überprüft, ob Daten im Serial Buffer verfügbar sind.
- `client.println(input)`: Sendet die eingelesenen Daten über die TCP-Verbindung an die App.
\ 

#figure(
  image("../Bilder/App/testTCP.png", width: 50%),
  caption: [Geänderte Parameter im Menü der App],
)
\
Datenübertragung: 

#figure(
  image("/Bilder/App/Datenverb.png", width: 80%),
  caption: [Datenübertragung],
)
Die Daten werden Packetiert übertragen. Jedes Paket enthält einen Hexadezimalen Code, der den Typ des Pakets angibt. Der Längen Indicator gibt an, wie viele Bytes das Paket enthält.  

#pagebreak()
Übersicht Packettypen:
#figure(
  align(center)[
    #set text(size: 12pt)
    #table(
      columns: (120pt, 120pt),
      inset: 5pt,
      stroke: 0.3pt + black,
      align: center,

      [*Hex*], [*Pakettyp*],
      [0x00], [Einstellungen],
      [0x01], [Spielername],
      [0x02], [Modus],
      [0x03], [Rundenzahl],
      [0x04], [Start],
      [0x05], [Stop],
      [0x06], [Leaderboard],
      [0x07], [\- \- -],
    )
  ],
  caption: [Daten],
) <fig-tmc5160driveroverview>

/*```kotlin
fun handleMessage(msg: String) {

    when {
        msg.startsWith("Modus:") -> {
            val value = msg.substringAfter("Modus:").trim()
            modeText.text = "Modus: $value"
        }

        msg.startsWith("Spieler:") -> {
            val value = msg.substringAfter("Spieler:").trim()
            playerText.text = "Spieler: $value"
        }

        msg.startsWith("Rundenzahl:") -> {
            val value = msg.substringAfter("Rundenzahl:").trim()
            lapsText.text = "Runden: $value"
        }
    }
}
```
- `msg.startsWith("Modus:")`: Überprüft, ob die empfangene Nachricht mit "Modus:" beginnt.
- `substringAfter("Modus:")`: Extrahiert den Wert nach "Modus:" und aktualisiert die entsprechende TextView in der App.
- `msg.startsWith("Spieler:")`: Überprüft, ob die empfangene Nachricht mit "Spieler:" beginnt.
- `substringAfter("Spieler:")`: Extrahiert den Wert nach "Spieler:" und aktualisiert die entsprechende TextView in der App.
- `msg.startsWith("Rundenzahl:")`: Überprüft, ob die empfangene Nachricht mit "Rundenzahl:" beginnt.
- `substringAfter("Rundenzahl:")`: Extrahiert den Wert nach "Rundenzahl:" und aktualisiert die entsprechende TextView in der App.*/

\ \


Initialisierung der Bidirektionalen Kommunikaation zwischen der App und dem @esp32:short
\
@tcp Kotlin: @sourceTCPApp

```kotlin
 suspend fun connect(): BufferedReader? {
     return withContext(Dispatchers.IO) {
         try {
             if (socket == null || socket!!.isClosed ||
              !socket!!.isConnected)
             {
                 socket = Socket(ESP_IP, ESP_PORT)
                 socket!!.tcpNoDelay = true
                 socket!!.soTimeout = 5000
                 writer = PrintWriter(
                  socket!!.getOutputStream(),true)
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

In dem Code der App wird ein Client Socket erstellt, der sich mit der IP-Adresse des @esp32:short und dem Port 8080 verbindet und eine Verbindungsanfrage an den @esp32:short sendet.
\ \

@tcp @esp32:short: @sourceTCPESP

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
An dem @esp32:short wird ein Server Socket erstellt, der auf Port 8080 auf verbindungsanfragen von der Appwartet. Ist eine Verbindung hergestellt, können Daten in beide Richtungen gesendet und empfangen werden.
\ 

=== Synchronisation
Um sicherzustellen, dass beide Geräte immer den gleichen Systemstatus anzeigen, wurde ein zeilenbasiertes Protokoll entwickelt.\ Jede Nachricht wird mit einem Newline-Zeichen (\\n) abgeschlossen, damit der Empfänger das Ende eines Befehls eindeutig erkennt. Dies ist notwendig, da @tcp die Daten als kontinuierlichen Strom versendet.\ Sobald in der App ein Parameter wie der Spielmodus oder die Rundenzahl geändert wird, sendet die App sofort ein entsprechendes Datenpaket an das Display. Ein Befehl wie MODUS: Schwer bewirkt am Display eine sofortige Aktualisierung der Variable und einen Redraw der Benutzeroberfläche. Dieser Prozess funktioniert auch in die umgekehrte Richtung: Wird am Display der "Start"- oder "Modus"-Button gedrückt, erhält die App das Signal zum Starten des Renn-Timers beziehungsweise das ändern des Moduses.

== Echtzeitverhalten
Bei der Softwareimplementierung wurde besonders auf ein nicht blockierendes Design geachtet. Da das Basismodul gleichzeitig den Touchscreen abfragen und das Display aktualisieren muss, darf der Netzwerkcode den Prozessor nicht aufhalten.\ Die Abfrage von eingehenden Daten erfolgt daher in jedem Programmdurchlauf, ohne den restlichen Ablauf zu verzögern.
\
Sollte die Verbindung zwischenzeitlich unterbrochen werden, verfügt die App über eine automatische Reconnect-Logik. Diese erkennt die unterbrochene Verbindung durch einen Timeout und versucht eigenständig, den Socket neu zu initialisieren, um die Verbindung wiederherzustellen. Während der Reconnect-Phase zeigt die App eine entsprechende Meldung an. Sobald die Verbindung wiederhergestellt ist, werden alle zuvor gesendeten Befehle erneut übertragen, um sicherzustellen, dass das Display den aktuellen Status korrekt anzeigt. 
\ \ 


== Controller Display <sec-controllerui>
Das Controller Display GC9A01 zeigt folgende Funktionen an:
- aktuelle Motorleistung 
- Timer
- Durchschnittsgeschwindigkeit
- beste Rundendauer
- Abweichung zum Besten
- Spielername
- Zugewiesenes Auto
- Rundenanzahl z.B.: 2/5 Runden // in dem fall leichter modus

Das Display dient dazu, wichtige Informationen während des Rennens anzuzeigen. Es zeigt die aktuelle Motorleistung an, die über die @pwm gesteuert wird, sowie einen Timer, der die Dauer des Rennens anzeigt. In der Mitte des Displays wird die Durchschnittsgeschwindigkeit angezeigt, welche mithilfe der Drehzahl des Motors berechnet wird. Darunter wird die schnellste Runde sowie die Abweichung angezeigt.
\
$ v = (n*π*d)/60 $

- v: Geschwindigkeit in m/s
- n: Drehzahl in U/min
- d: Durchmesser des Rades in m 
Damit man auf dem Display die Geschwindigkeit in Meter pro Sekunde angezeigt bekommt, wird die Drehzahl durch 60 dividiert, um auf Umdrehung pro Sekunde zu kommen. \ \

#figure(
  image("/Bilder/controllerScreen.png", width: 50%),
  caption: [Controller Display],
)

Der Spielername und das zugewiesene Auto werden ebenfalls auf dem Display angezeigt, um Verwechslungen zu vermeiden. Zudem wird die aktuelle Rundenanzahl angezeigt, um Aufschluss über die aktuelle Runde zu geben.

- Das Display wird mit dem CH572 verbunden, welcher die Daten empfängt und verarbeitet. Die Informationen werden in Echtzeit übertragen.
- Auf dem Display werden Spiel Informationen
 - Spielername
 - Autoname
 - Rundenanzahl
 über die SPI Schnittstelle vom CH572 übertragen.

 Die aktuellen Auto Informationen
  - Motorleistung 
 werden über @ble übertragen, da diese Informationen sehr schnell aktualisiert werden müssen und eine stabile Verbindung erfordern. 


