#import "@preview/glossy:0.9.0": glossary
// https://typst.app/universe/package/glossy/

#let eintraege = (
  pcb: (short: "PCB", long: "Printed Circuit Board", description: "Leiterplatte, auf der elektronische Bauteile montiert werden"),

  tmos: (short: "TMOS", long: "Task Management Operating System", description: "Echtzeitbetriebssystem, das von WCH für die Verwaltung von Aufgaben und Ressourcen in ihren Bluetooth-Chips verwendet wird"),

  led: (short: "LED", long: "Light Emitting Diode", description: "Halbleiterbauelement, das Licht emittiert, wenn Strom durch es fließt"),

  riscv: (short: "RISC-V", long: "Reduced Instruction Set Computer - Five", description: "Offene Befehlssatzarchitektur für Mikroprozessoren"),

  ble: (short: "BLE", long: "Bluetooth Low Energy", description: "Energiesparende Funktechnologie für die drahtlose Kommunikation"),

  pwm: (short: "PWM", long: "Pulsweitenmodulation", description: "Verfahren zur Steuerung der Leistung von elektrischen Geräten"),

  deepsleep:(short: "deep-sleep", long:"deepsleep", description: "Tiefschlafmodus von Mikrocontrollern in dem sie wenig Strom verbrauchen"),
  
  mac:(short: "MAC", long:"Media-Access-Control", description: "Eindeutige Kennung, die einem Netzwerkgerät zugewiesen wird, um es in einem Netzwerk zu identifizieren"),

  picc:(short: "PICC", long:"Proximity Integrated Circuit Card", description: "NFC modus in dem der IC als passiver Transponder fungiert und von einem aktiven NFC-Lesegerät ausgelesen wird"),
  
  lookup:(short: "Lookup-Table", long: "Lookup-Table",description: "Datenstruktur, die verwendet wird, um Werte schnell nachzuschlagen, z.B. zur Umwandlung von Sensorwerten in physikalische Größen"),

  pcd:(short: "PCD", long:"Proximity Coupling Device", description:"NFC modus in dem der IC als aktiver Sender fungiert und mit einem passiven NFC-Transponder kommuniziert"),

  uuid: (short: "UUID", long: "Universally Unique Identifier", description: "Eindeutige Kennung, die zur Identifikation von Objekten oder Entitäten verwendet wird"),

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

  ask: (short: "ASK", long: "Amplitude Shift Keying", description: "Modulationsverfahren, bei dem die Amplitude eines Trägersignals zur Übertragung von Daten variiert wird"),

  via: (short: "Via", long: "Durchkontaktierung", description: "Leiterbahnverbindung zwischen verschiedenen Lagen einer Leiterplatte"),
  
  ti: (short: "TI", long: "Texas Instruments", description: "Amerikanisches Unternehmen, das Halbleiter und integrierte Schaltkreise herstellt"),

  usb: (short: "USB", long: "Universal Serial Bus", description: "Standard für die Verbindung von Peripheriegeräten mit Computern und anderen Geräten"),

  usbc: (short: "USB-C", long: "USB Type-C", description: "Reversible USB-Steckverbindung, die höhere Datenübertragungsraten und Stromversorgung ermöglicht"),

  ripple: (short: "Ripple", long: "Spannungswelligkeit", description: "Unerwünschte Schwankungen in der Ausgangsspannung von Netzteilen oder Spannungsreglern"),
  
  rf: (short: "RF", long: "Radio Frequency", description: "Funkfrequenz, ein Bereich elektromagnetischer Wellen, der für die drahtlose Kommunikation verwendet wird"),

  rfid: (short: "RFID", long: "Radio Frequency Identification", description: "Technologie zur drahtlosen Identifikation von Objekten mittels elektromagnetischer Felder"),

  easyeda: (short: "EasyEDA", long: "Easy Electronic Design Automation", description: "Software für die Erstellung von Schaltplänen und Leiterplattenlayouts"),

  wifi: (short: "WiFi", long: "Wireless Fidelity", description: "Technologie für die drahtlose Vernetzung von Geräten über Funkwellen"),

  i2c: (short: "I²C", long: "Inter-Integrated Circuit", description: "Schnittstelle für die serielle Kommunikation zwischen Mikrocontrollern und Peripheriegeräten, die nur zwei Leitungen verwendet"),

  uart: (short: "UART", long: "Universal Asynchronous Receiver-Transmitter", description: "Schnittstelle für die serielle Kommunikation, die asynchron arbeitet und häufig für die Kommunikation zwischen Mikrocontrollern und Computern verwendet wird"),

  rx: (short: "RX", long: "Receive", description: "Empfangsleitung für die serielle Kommunikation"),

  tx: (short: "TX", long: "Transmit", description: "Sendeleitung für die serielle Kommunikation"),

  gnd: (short: "GND", long: "Ground", description: "Masse, Bezugspotential für elektrische Schaltungen"),

  m2: (short: "M2", long: "Metric 2mm", description: "Standardgröße für Schrauben, die in der Elektronik und Mechanik verwendet wird"),

  en: (short: "EN", long: "Enable", description: "Aktivierungssignal, das verwendet wird, um ein Gerät oder eine Funktion zu aktivieren oder zu deaktivieren"),

  io0: (short: "IO0", long: "Input/Output Pin 0", description: "Allzweck-Ein-/Ausgangspin, der für verschiedene Funktionen konfiguriert werden kann, z.B. als Boot-Pin oder zur Steuerung von Peripheriegeräten"),

  pi: (short: "PI", long: "Proportional-Integral", description: "Regelalgorithmus, der in der Regelungstechnik verwendet wird, um die Leistung eines Systems zu steuern"),

  sda: (short: "SDA", long: "Serial Data Line", description: "Datenleitung für die I²C-Kommunikation, über die Daten zwischen Geräten übertragen werden"),

  clk: (short: "CLK", long: "Clock", description: "Systemtakt, der die Geschwindigkeit der Datenverarbeitung und -übertragung in elektronischen Geräten bestimmt"),

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

  pla: (short: "PLA", long: "Polylactic Acid", description: "Biologisch abbaubarer Kunststoff, der häufig im 3D-Druck verwendet wird, da er einfach zu verarbeiten ist und eine gute Oberflächenqualität bietet"),

  fusion360: (short: "Fusion 360", long: "Autodesk Fusion 360", description: "CAD-Software für die 3D-Modellierung, Simulation und Fertigung von Produkten"),

  lcd: (short: "LCD", long: "Liquid Crystal Display", description: "Flüssigkristallbildschirm, eine Art von Display, das Flüssigkristalle verwendet, um Bilder anzuzeigen"),

  hvga: (short: "HVGA", long: "Half Video Graphics Array", description: "Displayauflösung von 320 x 480 Pixeln, die häufig in kleinen Displays verwendet wird"),

  dir: (short: "DIR", long: "Direction", description: "Richtungssignal, das bei bidirektionalen Level Shiftern verwendet wird, um die Richtung der Signalübertragung festzulegen"),

  lipo: (short: "LiPo", long: "Lithium-Polymer-Akku", description: "Wiederaufladbarer Akku, der eine hohe Energiedichte und flexible Formfaktoren bietet, häufig in tragbaren elektronischen Geräten verwendet wird"),

  abs: (short: "ABS", long: "Acrylonitrile Butadiene Styrene", description: "Thermoplastischer Kunststoff, der für seine Festigkeit, Schlagzähigkeit und Hitzebeständigkeit bekannt ist, häufig im 3D-Druck verwendet wird"),

  ui: (short: "UI", long: "User Interface", description: "Benutzeroberfläche, die es Benutzern ermöglicht, mit einem System oder einer Software zu interagieren"),

  ccv: (short: "CC/CV", long: "Constant Current/Constant Voltage", description: "Lademodus für Lithium-Polymer-Akkus, bei dem zuerst ein konstanter Strom und dann eine konstante Spannung bereitgestellt wird, um den Akku sicher und effizient zu laden")


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
  },entry: (entry, index, total) => {
  let pages = entry.pages.join(", ")
  
  block(width: 100%, below: 1.5em, {
    grid(
      columns: (auto, auto),
      column-gutter: 1em,
      align: (left + bottom, right + bottom),
      {
        strong(entry.short)
        if entry.long != none [
          #h(0.2em)#text(fill: luma(0))[– #entry.long]
        ]
      },
      text(size: 0.75em, fill: luma(50), "[" + pages + "]")

    )
    if entry.description != none {
      pad(top: 0.05em,
        text(size: 0.9em, fill: luma(90), entry.description)
      )
    }
  })
}
)

#glossary(title: "Glossar", theme: my-theme, sort: true, show-all: false)

#pagebreak()