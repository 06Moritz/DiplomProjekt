= Software
== BLE
*!* @ble ist für die Übertragung von kleinen Datenmengen optimiert, dadurch auch Energiesparend. Es funktioniert mit einem Server-Client System. Das schnelle und einfache Verbinden ist ein weiter Pluspunkt. @bleSource \
Implementierung in unserem Fall: Der Controller ist als Server konfiguriert, der Motorleistungswerte an das Auto sendet. Der Client ist das Auto,
- scannt nach Geräten
- Verbindet mit eingestellter MAC-Adresse
- Service- und Characteristic-Discovery
- Aktivieren von Notifications
- Verarbeitung empfangener Daten 
Gliederung:
Application
host layer
controller layer

== Motorregelung 
Die Drehzahl wird über den Drehzalsensor eingelesen. Der Sensor geht einmal in der Umdrehung auf low. Auf den Input-pin ist ein Interrupt gesetzt 

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
== NFC

== Pairing mode
