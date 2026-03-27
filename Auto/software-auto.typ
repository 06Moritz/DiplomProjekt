#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author2, #klasse])

= Software
== @ble:both
Die Basis der Implementierung bildet der @ble Beispielcode von WCH. Dieser Code stellt die notwendigen Low-Level-Funktionen für den Bluetooth-Stack und das @tmos zur Verfügung.
Das Auto ist als @ble\-Master (Central-Device) konfiguriert. Es sucht aktiv nach Geräten zum Verbinden und empfängt Geschwindigkeitswerte.

=== @clk:long\-Initialisierung
Es wird der interne niederfrequente 32kHz Quarz verwendet, der im _setup_ Kalibriert werden muss. Für @ble ist eine genaue Frequenz erforderlich.

```c
HSECFG_Capacitance(HSECap_18p); //Kondensatoren für Quarz einstellen
SetSysClock(SYSCLK_FREQ); //Systemfrequenz einstellen
SysTick->CTLR |= 0x05; //SysTick Timer auf Clock Frequenz einstellen
Calibration_LSI(Level_64); //Clock kalibrieren

```

- Es wird aktiv nach der eingestellen MAC-Adresse des Controllers gesucht, diese kann über @nfc eingestellt werden (siehe @sec-pairing).

- Das Auto ist als Client konfiguriert, das bedeutet er empfängt Daten die vom Controller gesendet werden. Die Daten werden als _notifications_ gesendet (siehe @sec_ble).

- Die empfangen Motorleistungsdaten werden direkt gespeichert und von der Motorregelung verarbeitet.

== Motorregelung
Die Drehzahl wird über den Drehzahlsensor eingelesen. Der Sensor gibt einmal in der Umdrehung ein Low-Signal. Auf dem Input-Pin ist ein Interrupt gesetzt. Die Zeit zwischen den Interrupts wird gemessen, um die Drehzahl festzustellen. Die Berechnung der Motorleistung erfolgt über einen @pi:short\-Regler, der die Abweichung von der gewünschten Drehzahl berechnet und entsprechend die Leistung anpasst.

```c
__attribute__((interrupt("WCH-Interrupt-fast")))
void GPIOA_IRQHandler(void) {
    if (GPIOA_ReadITFlagBit(GPIO_Pin_4)) {
        uint64_t current_tick = SysTick->CNT;
        period_ticks = current_tick - last_tick;
        last_tick = current_tick;
        flag = 1;
        GPIOA_ClearITFlagBit(GPIO_Pin_4);

    }
}
```
\ 
Für den @pi:short\-Regler ist ein periodischer Ablauf nötig. Die Motorleistung wird alle 10 Millisekunden berechnet. Es wird ein Timer-Interrupt gesetzt. Der Integralteil wird durch kontinuierliches Summieren des Fehlers berechnet.
\ \

```c
int x = per_norm - soll; //Abweichung vom Sollwert
i_sum += (float)x * 0.1f; //summieren für Integralteil

//begrenzen des Integralteils
if(i_sum > 1500) i_sum = 1500;
if(i_sum < 0)    i_sum = 0;

//Berechnung des PI-Reglers
int p = (int)((0.5f * (float)x) + (0.12f * i_sum));
if(p < 0) p = 0;
if(p > 255) p = 255; //Wertbegrenzung auf 0-255
```

== @nfc:both
Die @nfc ...


== Pairing mode <sec-pairing>
