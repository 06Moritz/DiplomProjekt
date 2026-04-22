#import "../config.typ": *
#pagebreak()
#aktueller_autor.update([#author2, #klasse])

= Software
== Bluetooth Low Energy (BLE)
Die Basis der Implementierung bildet der @ble Beispielcode von WCH. Dieser Code stellt die notwendigen Low-Level-Funktionen für den Bluetooth-Stack und das @tmos zur Verfügung.
Das Auto ist als @ble\-Master (Central-Device) konfiguriert. Es sucht aktiv nach Geräten zum Verbinden und empfängt Geschwindigkeitswerte.

=== Clock-Initialisierung

#figure(
  image("/Bilder/flowchart-ble.png", width: 80%),
  caption: [Blockschaltbild BLE Clock Initialisierung]
)
\
Es wird der interne niederfrequente 32kHz Quarz verwendet, der im _setup_ kalibriert werden muss. Für @ble ist eine genaue Frequenz erforderlich.

=== Verbindung
- Es wird aktiv nach der eingestellen MAC-Adresse des Controllers gesucht, diese kann über @nfc eingestellt werden (siehe @sec-pairing).

=== Empfang der Daten
- Das Auto ist als Client konfiguriert, das bedeutet er empfängt Daten die vom Controller gesendet werden. Die Daten werden als _notifications_ gesendet (siehe @sec_ble).

=== Verarbeitung der Daten
- Die empfangen Motorleistungsdaten werden direkt gespeichert und von der Motorregelung verarbeitet.


== Motorregelung
Die Drehzahl wird über den Drehzahlsensor eingelesen. Der Sensor gibt einmal in der Umdrehung ein Low-Signal. Auf dem Input-Pin ist ein Interrupt gesetzt. Die Zeit zwischen den Interrupts wird gemessen, um die Drehzahl festzustellen. Die Berechnung der Motorleistung erfolgt über einen @pi:short\-Regler, der die Abweichung von der gewünschten Drehzahl berechnet und entsprechend die Leistung anpasst.

#figure(
  image("/Bilder/flowchart-regler.png", width: 80%),
  caption: [Blockschaltbild Motorregelung]
)

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

== Near Field Communication (NFC) <sec_fahrzeug-nfc-sw>
Der CH585 wird im @picc Modus konfiguriert. Für eine einfache und schnelle Identifikation liest der @nfc\-Reader in der Bahn und die @uuid. Da kein Datenspeicher ausgelesen wird ist die Initialisierung des @nfc Teils einfach gestaltet.

Als Grundlage dient das @picc Codebeispiel von WCH. 
```c
// Definition der 7-Byte Hardware-Identität (UID)
uint8_t uuid[7] = {0x00, 0xAE, 0x38, 0xE2, 0xB5, 0x4C, 0x80};

// Zuweisung der Identität an den NFC-Treiber
nfca_picc_t2t_enable(uuid));

// Aktivierung der passiven Funk-Schnittstelle
nfca_picc_start();

```


== Pairing mode <sec-pairing>
Der _pairing-mode_ wird genutzt um das Auto mit einem Controller zu verbinden.  Um zu ermitteln ob der IC über die Bahn oder mit dem Superkondensator versorgt wird, wird die Eingangsspannung über den @adc gemessen, da die Spannung vom Kondensator 100mV niedriger ist als die vom @ldo. Wenn das erkannt wird wechselt der @nfc Modus zu @pcd um als Reader zu agieren. Es wird die @mac Adresse des Controllers von einem @nfc\-Tag gelesen und gespeichert. Das Auto kann sich dann mit dem Controller verbinden. 

```c
    readADC();
    if(readADC()>210 || PAIR == 0)
    {  //init main mode
        nfcPiccInit();
        nfca_picc_start();

        Main_Circulation();
    }

    else {
        //init PCD mode
        nfcPCDInit();
    }
```
