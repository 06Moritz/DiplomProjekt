#import "../config.typ": *
#aktueller_autor.update(author1) // Melanie

= Hardware
*!* Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung Einleitung

== Blockschaltbild
#figure(
image("../Bilder/Blockschaltbild-HW-Bahn.svg", width: 100%),
caption: [Blockschaltbild Hardware Bahn],
)

== Spannungsversorgung
- USB-C Eingang mit 12V @pd (X4 im Schaltplan)
- Warum USB-C @pd? → Standardisiert, keine eigene Steckerlösung nötig
- Spannungspfad: 12V → 5V (Buck) → 3.3V (LDO)

== Spannungsregler - Buck
- Eingang 12V, Ausgang 5V, 6A
- Warum dieser IC? (Effizienz, Strombelastbarkeit)
- Dimensionierung: Rückkopplung über Rfbt/Rfbb (220kΩ / 30kΩ sichtbar im Schaltplan)
- Ausgangskondensatoren: C7–C10, Cout (22µF × 3 + 100nF)
- Spule L1 (2.2µH), Cboot (33pF), Css (10nF), Cvcc (1µF)
- Cinx (100nF Eingangsfilter), C6 (22µF Bulk)

== Spannungsregler - LDO
- Eingang 5V, Ausgang 3.3V
- Versorgt ESP32-S3 und Display
- Stützkondensatoren C1–C4 (1µF)

== ESP32 S3
- Pinbelegung: 2× I2C (SDA1/SCL1 für NFC1, SDA2/SCL2 für NFC2)
- SPI-Bus für Display (SDO/MISO, SDI/MOSI, SCK, LCD_CS, LCD_RS, LCD_RST)
- Touch-Controller: CTP_INT, CTP_RST
- IO0 für Programmierung / Boot-Modus
- WiFi/BLE-Antenne integriert im Modul → keine externe Antenne nötig
- Warum ESP32-S3? → Dual-Core, ausreichend GPIOs, integriertes WiFi für TCP

== NFC-Module
- 2× PN532 über je einen eigenen I2C-Bus
- Pull-up Widerstände R1–R4 (10kΩ) auf SDA/SCL
- Steckverbinder X1, X2 (4-polig: VCC, GND, SDA, SCL)
- Warum 2 Module? → 2 Fahrspuren, gleichzeitige Erkennung beider Autos

== Display
- 4" TFT LCD mit SPI-Interface
- Kapazitiver Touchscreen (CTP = Capacitive Touch Panel)
- Warum dieses Display? (Größe, Touch-Fähigkeit für UI)

== Ladeausgang
- USB C Ausgang 5V für die Versorgung der Ladestation
- SN74LVC1T45DCKR (U4): bidirektionaler Levelshifter für DIR-Signal
- CJ2305 (V1): P-Kanal MOSFET als Schalter
- Spannungsteiler R5 (10kΩ), R6/R7 (je 5.1kΩ) → CC-Leitungen für USB-C
- Steckverbinder B12 (USB1, TYPE-C 6P): Ausgang 5V für Ladestation
- ADC1/ADC2 vom ESP32 zur Stromerkennung/Überwachung

== Programmierschnittstelle
- X5 (5-polig): EN, TX, RX, IO0, GND
- C11 (100nF) auf EN → Resetfilter
- Warum eigene Programmierbuchse? → kein USB direkt am ESP-Modul

== Leiterplatte
- 3D Modell der Platine
- Schaltplan und PCB-Layout im Anhang

#pagebreak()