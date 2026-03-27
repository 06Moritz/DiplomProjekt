#import "../config.typ": *
#aktueller_autor.update([#author3, #klasse])

Die App dient zum Einstellen. Sie ermöglicht es die Sprache, den Modus, die Rundenzahl und Spielernamen einzustellen, sowie die Verbindung zum Hauptmodul  herzustellen.\ 
= Software
??Die Software besteht aus drei Modulen:
- App
- Hauptmodul Display
- Controller Display
\
Die Software ist in Kotlin für die App und in PlatformIO für die Displays programmiert.\
Die Kommunikation zwischen der App und dem Hauptmodul Display erfolgt über das @tcp Protokoll, während die Kommunikation zwischen dem Hauptmodul Display und dem Controller Display über BLE erfolgt.


== App Programmierung


#figure(
     figure(
      image("/Bilder/App/Appscreen.png", width: 50%),
    ),
    caption: [Startbildschirm der App],
)



Es gibt verschiedene Modi, die unterschiedliche Schwierigkeitsgrade bieten. Je nach Modus variiert die Anzahl der Runden und die Schwierigkeit der Steuerung. Unter Schwierigkeit der Steuerung versteht man mit welcher Motorleistung die Autos fahren.
\ \
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

  - DefaultLaps: Hier werden die Rundenanzahl standardisiert.
  - speedFactor: Hier wird die Motorleistung eingestellt. Zum Beispiel: 0.5f bedeutet, dass die Autos mit halber Leistung fahren.

\
Beim Start des Rennens zeigt die App die Dauer (mit einer Timer Methode) und den Rundenfortschritt der Spieler. Nach dem Beenden des Rennens werden die Spieler des aktuellen Rennens nach der Bestzeit sortiert und angezeigt. In diesem Menü hat man die Wahl wieder zum Hauptmenü zu gelangen oder sich das gesamte Ranking aller Rennen anzusehen. Diese werden nach folgenden Kriterien sortiert: 
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
     figure(
      image("/Bilder/App/rennen.png", width: 40%),
    ),
     figure(
      image("/Bilder/App/podium.png", width: 40%),
    ),
    
  ),
  caption: [Rennen und schnelleste Runde],
  gap: 1em,
)

#figure(
  grid(
    columns: (1fr),
    gutter: -10em,
    align: bottom + center,
      image("/Bilder/App/leaderboard.png", width: 25%),
    ),
  caption: [Leaderboard],
  gap: 1em,
)
 
== Hauptmodul Display
Das Display MSP4030 verfügt über einen Kapazitiven Touchscreen, welcher einfache Einstellungen über das Display ermöglicht.
- Modi (einstellbar)
- Spieler anzahl
- Start/Stop
- Podium
Um das @ui Design zu erleichtern, wurde eine Button Klasse erstellt, welche die Logik für das Drücken der Buttons enthält. Es wird überprüft, ob der Button gedrückt wurde, trifft das zu, wird die entsprechende Funktion ausgeführt. \ \
Durch Polymorphismus muss nicht jeder Button einzeln erstellt werden. Das ermöglicht es, die Benutzeroberfläche effizient zu aktualisieren und gleichzeitig eine reaktionsschnelle und flüssige Kommunikation zu erhalten. 

\ \
Wenn das Display gedrückt sendet es über I2C die XY-Koordinaten des Touch-Events and den Mikrocontroller. Es werden die Koordinaten mit den Positionen der Buttons verglichen. Wenn die Koordinaten innerhalb der Grenzen eines Buttons liegen, wird die Funktion des Buttons ausgeführt.


```c
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

```
Zustand wird abgefragt, Buttons werden Entprellt, bei Button klick werden Zustände geändert.
...


== @tcp:both Programmierung
\
Um eine Verbindung zwischen der App und dem Hauptmodul Display herzustellen, wird das @tcp Protokoll verwendet. Dieses ermöglicht eine Bidirektionale Kommunikation zwischen den beiden Geräten. Das dient dazu, dass Änderungen, wie das Einstellen der Modi oder Spielernamen, auf das Display übertragen werden können.\ 

In dieser Konfiguration zählt der ESP32S3 als @tcp -Server, der auf einem definierten Port (8080) auf eingehende Verbindungsanfragen der App wartet.\ \

=== Prototyp TCP Verbindung
Vor der Verbindung der App mit dem Display wurde ein Test-Code geschrieben, um das Signal auszuschreiben, das von der App an den ESP32 gesendet und im Terminal ausgeschrieben wird. \ \
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
Als nächsten schritt wurde der ESP32 als Sender und die App als Empfänger konfiguriert, um die Datenübertragung zu testen.
Im Serial Terminal werden Befehler eingegeben. In der App wird dann die entsprechende Variable aktualisiert.
\ \
In das Terminal wurden folgende Parameter eingegeben:\

```c
  Spieler: Spieler1
  Modus: Leicht
  Rundenzahl: 3

```

/*
In der App wurden die eingegebenen Parameter aktualisiert. Spieler1 wurde als Spielername angezeigt, der Modus auf leicht gestellt und die Rundenzahl auf drei.*/

\ \
#figure(
image("../Bilder/App/testTCP.png", width: 50%),
caption: [App Menü],)
\ \
Die App und der ESP32 als Sender und Empfänger initialisiert. 
 \
@tcp Kotlin:

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
\ \ \

@tcp ESP32:

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
An dem ESP32 wird ein Server Socket erstellt, der auf Port 8080 auf verbindungsanfragen von der Appwartet. Ist eine Verbindung hergestellt, können Daten in beide Richtungen gesendet und empfangen werden.
\ \


=== Synchronisation
Um sicherzustellen, dass beide Geräte immer den gleichen Systemstatus anzeigen, wurde ein zeilenbasiertes Protokoll entwickelt.\ Jede Nachricht wird mit einem Newline-Zeichen (\n) abgeschlossen, damit der Empfänger das Ende eines Befehls eindeutig erkennt. Dies ist notwendig, da @tcp die Daten als kontinuierlichen Strom versendet.\ Sobald in der App ein Parameter wie der Spielmodus oder die Rundenzahl geändert wird, sendet die App sofort ein entsprechendes Datenpaket an das Display. Ein Befehl wie MODUS: Schwer bewirkt am Display eine sofortige Aktualisierung der Variable und einen Redraw der Benutzeroberfläche. Dieser Prozess funktioniert auch in die umgekehrte Richtung: Wird am Display der "Start"- oder "Modus"-Button gedrückt, erhält die App das Signal zum Starten des Renn-Timers beziehungsweise das ändern des Moduses.
\ \

