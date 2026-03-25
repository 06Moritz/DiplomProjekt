#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author2, #klasse])

= Software
== BLE
*!* Das Auto ist als @ble Master(Central-Device) konfiguriert. Es sucht aktiv nach Geräten zum Verbinden und und empfängt Geschwindigkeitswerte.

== Motorregelung 
Die Drehzahl wird über den Drehzahlsensor eingelesen. Der Sensor geht einmal in der Umdrehung auf low. Auf den Input-pin ist ein Interrupt gesetzt, die Zeit zwischen den Interrupts wird gemessen. 
\ \


#figure(
  table(
    columns: (1fr),
    rows: (auto),
    [
```c
__attribute__((interrupt("WCH-Interrupt-fast")))
void GPIOA_IRQHandler(void) {
    if (GPIOA_ReadITFlagBit(GPIO_Pin_4)) {
        uint64_t current_tick = SysTick->CNT;
        period_ticks = current_tick - last_tick;
        last_tick = current_tick;
        flag = 1;
        GPIOA_ClearITFlagBit(GPIO_Pin_4);
        ```
    }
}
    ],
  ),
  caption: [Interrupt-Service-Routine]
  )


\ \
Für den PI-Regler ist ein periodischer Ablauf nötig. Die Motorleistung wird alle 10 Millisekunden berechnet. Es wird ein Timer-Interrupt gesetzt. Der Integralteil wird durch kontinuierliches summieren des Fehlers berechnet.
\ \


#figure(
  table(
    columns: (1fr),
    rows: (auto),
    [
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
    ],
  ),
  caption: [Implementierung des PI-Reglers in C]
  )


== NFC



== Pairing mode
