#import "../config.typ":*

#aktueller_autor.update([#author2, #klasse])

= Software

#import "../config.typ":*

#aktueller_autor.update([#author3, #klasse])


== Controller Display
Der CH572 wird in C programmiert. Auf dem Display werden Renndaten wie Rundenzeit und Spielername angezeigt (siehe @sec-controllerui). Das Display wird direkt über @spi\-Befehle angesprochen.

```c
void fillScreen(uint16_t color)
{   
    uint8_t colh = color >> 8;
    uint8_t coll = color & 0xff;

    TFT_CS_LOW;
    setAddrWindow(0, 0, TFT_WIDTH - 1, TFT_HEIGHT - 1);
    
    TFT_DC_HIGH;

    for (int y = 0; y < TFT_HEIGHT; y++) {
        for(int i = 0; i < TFT_WIDTH; i++) {
            spiWrite(colh);
            spiWrite(coll);
        }
    }
    TFT_CS_HIGH;
}
```


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
Die Analogwerte werden verarbeitet oder über @ble gesendet. Die Akkuspannung wird gemessen um den Ladestand des Akkus zu berechnen und anzuzeigen. Der Ladestand wird aus einer @lut:long abgelesen.

```c
    u_bat = bat_val * (3.3f/4096) * 2; //Akkuspannung berechnen
    charge = chargeval[u_bat]; //lookup table

```




