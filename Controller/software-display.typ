#import "../config.typ":*

#aktueller_autor.update([#author3, #klasse])


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


== Bluetooth Low Energy (BLE)
Die Basis der Implementierung bildet der @ble Beispielcode von WCH. Dieser Code stellt die notwendigen Low-Level-Funktionen für den Bluetooth-Stack und das @tmos zur Verfügung.
Das Auto ist als Peripheral-Device konfiguriert. Es advertised und wartet bis das Auto sich damit verbindet.
Der Controller sendet periodisch die aktuellen Analogwerte die er vom @adc über @uart einliest. Die Daten werden als notify gesendet da keine Antwort notwendig ist.

```c

static void performPeriodicTask(void)
{
    // 3. Daten für die Notification vorbereiten
    uint8_t notiData[SIMPLEPROFILE_CHAR4_LEN];
    uint16_t num = (uint16_t) adc_buffer[cnt];
    notiData[0] = num/16;
    cnt++;
    uint16_t raw = adc_buffer[0];
    int32_t calibrated = (int32_t)raw - 1536; // 0V Offset abziehen
    if (calibrated < 0) calibrated = 0;
    //auf 0-255 skalieren
    uint8_t final_val = (calibrated * 255) / 1609; 
    notiData[0] = final_val;
    peripheralChar4Notify(notiData, SIMPLEPROFILE_CHAR4_LEN);
}

```

== Analog-Digital-Wandler (ADC)
Potentiometer, Schieberegler und Akkuspannung werden mit dem CH32v003 gemessen. Die Messwerte werden in periodischen Abständen über @uart an den Hauptcontroller CH572 gesendet.
Die Analogwerte werden verarbeitet oder über @ble gesendet. Die Akkuspannung wird gemessen um den Ladestand des Akkus zu berechnen und anzuzeigen. Der Ladestand wird aus einer @lookup:short abgelesen.

```c
    u_bat = bat_val * (3.3f/4096) * 2; //Akkuspannung berechnen
    charge = chargeval[u_bat]; //lookup table

```
