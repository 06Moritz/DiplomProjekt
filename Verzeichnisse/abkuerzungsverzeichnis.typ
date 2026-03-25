#import "@preview/glossy:0.9.0": glossary
// https://typst.app/universe/package/glossy/

#let eintraege = (
  pcb: (short: "PCB", long: "Printed Circuit Board", description: "Leiterplatte, auf der elektronische Bauteile montiert werden"),

  ble: (short: "BLE", long: "Bluetooth Low Energy", description: "Energiesparende Funktechnologie für die drahtlose Kommunikation"),

  pwm: (short: "PWM", long: "Pulsweitenmodulation", description: "Verfahren zur Steuerung der Leistung von elektrischen Geräten"),

  ldo: (short: "LDO", long: "Low Dropout Regulator", description: "Spannungsregler, der auch bei geringer Eingangsspannung stabil arbeitet"),

  nfc: (short: "NFC", long: "Near Field Communication", description: "Technologie für die drahtlose Kommunikation über kurze Distanzen"),

  adc: (short: "ADC", long: "Analog-Digital-Wandler", description: "Bauteil, das analoge Signale in digitale Werte umwandelt"),

  tcp: (short: "TCP", long: "Transmission Control Protocol", description: "Protokoll für die zuverlässige Übertragung von Daten über Netzwerke"),
  
  pd: (short: "PD", long: "Power Delivery", description: "Standard für die Stromversorgung über USB, ermöglicht höhere Leistungen und flexible Spannungsversorgung"),

  ic: (short: "IC", long: "Integrated Circuit", description: "Integrierter Schaltkreis, ein elektronisches Bauteil, das viele Funktionen auf einem kleinen Chip vereint"),

  mosfet: (short: "MOSFET", long: "Metal-Oxide-Semiconductor Field-Effect Transistor", description: "Transistor, der als elektronischer Schalter oder Verstärker in Schaltungen verwendet wird"),

  buck: (short: "Buck-Converter", long: "Abwärtswandler", description: "Schaltregler, der eine höhere Eingangsspannung in eine niedrigere Ausgangsspannung umwandelt"),

  fb: (short: "FB", long: "Feedback", description: "Rückkopplung, ein Signal, das zur Regelung von Systemen verwendet wird, um die gewünschte Leistung zu erreichen"),

  spi: (short: "SPI", long: "Serial Peripheral Interface", description: "Schnittstelle für die serielle Kommunikation zwischen Mikrocontrollern und Peripheriegeräten"),

  poti: (short: "Poti", long: "Potentiometer", description: "Drehbarer Widerstand, der zur Einstellung von Spannung oder Strom in einem Stromkreis verwendet wird"),

  levelshifter: (short: "Level Shifter", long: "Pegelwandler", description: "Schaltung, die Signale von einem Spannungspegel auf einen anderen übersetzt, um die Kompatibilität zwischen verschiedenen Komponenten zu gewährleisten"),

  cc: (short: "CC", long: "Configuration Channel", description: "Kanal für die Konfiguration von USB Power Delivery, über den die Stromversorgung und andere Parameter ausgehandelt werden"),

  via: (short: "Via", long: "Durchkontaktierung", description: "Leiterbahnverbindung zwischen verschiedenen Lagen einer Leiterplatte"),
  
  ti: (short: "TI", long: "Texas Instruments", description: "Amerikanisches Unternehmen, das Halbleiter und integrierte Schaltkreise herstellt"),

  usb: (short: "USB", long: "Universal Serial Bus", description: "Standard für die Verbindung von Peripheriegeräten mit Computern und anderen Geräten"),

  usbc: (short: "USB-C", long: "USB Type-C", description: "Reversible USB-Steckverbindung, die höhere Datenübertragungsraten und Stromversorgung ermöglicht"),

  ripple: (short: "Ripple", long: "Spannungswelligkeit", description: "Unerwünschte Schwankungen in der Ausgangsspannung von Netzteilen oder Spannungsreglern"),
  
  rf: (short: "RF", long: "Radio Frequency", description: "Funkfrequenz, ein Bereich elektromagnetischer Wellen, der für die drahtlose Kommunikation verwendet wird"),

  rfid: (short: "RFID", long: "Radio Frequency Identification", description: "Technologie zur drahtlosen Identifikation von Objekten mittels elektromagnetischer Felder"),

  easyeda: (short: "EasyEDA", long: "Easy Electronic Design Automation", description: "Software für die Erstellung von Schaltplänen und Leiterplattenlayouts"),

  wifi: (short: "Wi-Fi", long: "Wireless Fidelity", description: "Technologie für die drahtlose Vernetzung von Geräten über Funkwellen"),

  i2c: (short: "I²C", long: "Inter-Integrated Circuit", description: "Schnittstelle für die serielle Kommunikation zwischen Mikrocontrollern und Peripheriegeräten, die nur zwei Leitungen verwendet"),

  uart: (short: "UART", long: "Universal Asynchronous Receiver-Transmitter", description: "Schnittstelle für die serielle Kommunikation, die asynchron arbeitet und häufig für die Kommunikation zwischen Mikrocontrollern und Computern verwendet wird"),

  rx: (short: "RX", long: "Receive", description: "Empfangsleitung für die serielle Kommunikation"),

  tx: (short: "TX", long: "Transmit", description: "Sendeleitung für die serielle Kommunikation"),

  gnd: (short: "GND", long: "Ground", description: "Masse, Bezugspotential für elektrische Schaltungen"),

  en: (short: "EN", long: "Enable", description: "Aktivierungssignal, das verwendet wird, um ein Gerät oder eine Funktion zu aktivieren oder zu deaktivieren"),

  io0: (short: "IO0", long: "Input/Output Pin 0", description: "Allzweck-Ein-/Ausgangspin, der für verschiedene Funktionen konfiguriert werden kann, z.B. als Boot-Pin oder zur Steuerung von Peripheriegeräten"),

  sda: (short: "SDA", long: "Serial Data Line", description: "Datenleitung für die I²C-Kommunikation, über die Daten zwischen Geräten übertragen werden"),

  scl: (short: "SCL", long: "Serial Clock Line", description: "Taktleitung für die I²C-Kommunikation, die den Takt für die Datenübertragung vorgibt"),

  esp32: (short: "ESP32", long: "Espressif Systems 32-bit Microcontroller", description: "Mikrocontroller mit integrierter Wi-Fi- und Bluetooth-Funktionalität, der in vielen IoT-Projekten verwendet wird"),

  ram: (short: "RAM", long: "Random Access Memory", description: "Arbeitsspeicher, der es ermöglicht, Daten schnell zu lesen und zu schreiben, während ein Gerät in Betrieb ist"),
  psram: (short: "PSRAM", long: "Pseudo Static RAM", description: "Arbeitsspeicher, der die Vorteile von statischem und dynamischem RAM kombiniert, um eine kostengünstige und energieeffiziente Lösung zu bieten"),

  id: (short: "ID", long: "Identifier", description: "Eindeutige Kennung, die verwendet wird, um ein Objekt oder eine Entität zu identifizieren, z.B. eine NFC-Karte oder ein Gerät in einem Netzwerk"),

  gpio: (short: "GPIO", long: "General Purpose Input/Output", description: "Allzweck-Ein-/Ausgang, der von Mikrocontrollern zur Steuerung von Peripheriegeräten verwendet wird"),

  firmware: (short: "Firmware", long: "Firmware", description: "Software, die in Hardware eingebettet ist und grundlegende Funktionen steuert, z.B. die Steuerungslogik eines Mikrocontrollers"),

  bootloader: (short: "Bootloader", long: "Bootloader", description: "Spezielle Software, die beim Starten eines Geräts ausgeführt wird und dafür verantwortlich ist, die Hauptfirmware zu laden und auszuführen"),

  mosi: (short: "MOSI", long: "Master Out Slave In", description: "Datenleitung für die SPI-Kommunikation, über die der Master Daten an den Slave sendet"),

  miso: (short: "MISO", long: "Master In Slave Out", description: "Datenleitung für die SPI-Kommunikation, über die der Slave Daten an den Master sendet"),

  sck: (short: "SCK", long: "Serial Clock", description: "Taktleitung für die SPI-Kommunikation, die den Takt für die Datenübertragung vorgibt"),

  cs: (short: "CS", long: "Chip Select", description: "Steuerleitung für die SPI-Kommunikation, die verwendet wird, um ein bestimmtes Slave-Gerät auszuwählen und zu aktivieren"),

  tft: (short: "TFT", long: "Thin-Film Transistor", description: "Technologie für die Herstellung von Displays, die eine hohe Bildqualität und schnelle Reaktionszeiten bietet"),

  sd: (short: "SD", long: "Secure Digital", description: "Standard für Speicherkarten, die in vielen elektronischen Geräten verwendet werden, um Daten zu speichern"),

  lcd: (short: "LCD", long: "Liquid Crystal Display", description: "Flüssigkristallbildschirm, eine Art von Display, das Flüssigkristalle verwendet, um Bilder anzuzeigen"),

  hvga: (short: "HVGA", long: "Half Video Graphics Array", description: "Displayauflösung von 320 x 480 Pixeln, die häufig in kleinen Displays verwendet wird"),

  dir: (short: "DIR", long: "Direction", description: "Richtungssignal, das bei bidirektionalen Level Shiftern verwendet wird, um die Richtung der Signalübertragung festzulegen"),

  lipo: (short: "LiPo", long: "Lithium-Polymer-Akku", description: "Wiederaufladbarer Akku, der eine hohe Energiedichte und flexible Formfaktoren bietet, häufig in tragbaren elektronischen Geräten verwendet wird"),

  abs: (short: "ABS", long: "Acrylonitrile Butadiene Styrene", description: "Thermoplastischer Kunststoff, der für seine Festigkeit, Schlagzähigkeit und Hitzebeständigkeit bekannt ist, häufig im 3D-Druck verwendet wird")


)


#let my-theme = (
  section: (title, body) => {
    heading(level: 1, title)
    body
  },

  group: (name, index, total, body) => {
    if name != "" and total > 1 {
      heading(level: 2, name)
    }
    body
  },

  entry: (entry, index, total) => {
    let output = [*#entry.short*#entry.label]
    if entry.long != none {
      output = [#output -- #entry.long]
    }
    if entry.description != none {
      output = [#output: #emph(entry.description)]
    }
    block(
      grid(
        columns: (auto, 1fr, auto),
        gutter: 0.5em,
        output,
        repeat([#h(0.05em).#h(0.05em)]),
        entry.pages.join(", "),
      )
    )
  }
)

#glossary(title: "Glossar", theme: my-theme, sort: true, show-all: true)

#pagebreak()