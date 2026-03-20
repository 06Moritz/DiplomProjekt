#import "../config.typ": *

= Anlagen 

#show outline.entry: it => link(
  it.element.location(),
  it.indented(it.prefix(),
  it.body())
)
//#show outline.entry.where(level: 1): set block(above: 1.5em) // nur bei Unteteilung in Blöcke

#outline(
  title: none,
  indent: 1cm,
  target: heading.where().after(<anhang_start>),  
)

<anhang_start>
#show heading: none
#set heading(numbering: none)
#set page(margin: 0cm, header: none, footer: none)

= Hauptmodul Schaltplan
#v(4.5cm)
#figure(
rotate(90deg,muchpdf(read("../PDF/auto/SCH.pdf", encoding: none),width: 140%)) )
 // Vektorgrafik
= Hauptmodul Layout TOP
#muchpdf(read("../PDF/Haupt/kocmTop.pdf", encoding: none),
width: 100%) // Rastergrafik
= Fahrzeug Layout BOT
#muchpdf(read("../PDF/Haupt/kocmBot.pdf", encoding: none),
width: 100%) // Rastergrafik

// 2 Arten zum Einfügen von PDFs:
= Hauptmodul Schaltplan
#v(4.5cm)
#figure(
rotate(90deg,muchpdf(read("../PDF/auto/SCH.pdf", encoding: none),width: 140%)) )
 // Vektorgrafik
= Fahrzeug Layout TOP
#muchpdf(read("../PDF/auto/PromTop.pdf", encoding: none),
width: 100%) // Rastergrafik
= Fahrzeug Layout BOT
#muchpdf(read("../PDF/auto/PromBot.pdf", encoding: none),
width: 100%) // Rastergrafik

// 2 Arten zum Einfügen von PDFs:
= Controller Schaltplan
#v(4.5cm)
#figure(
rotate(90deg,muchpdf(read("../PDF/auto/SCH.pdf", encoding: none),width: 140%)) )
 // Vektorgrafik
= Controller Layout TOP
#muchpdf(read("../PDF/Controller/ReimTop.pdf", encoding: none),
width: 100%) // Rastergrafik
= Controller Layout BOT
#muchpdf(read("../PDF/Controller/ReimBot.pdf", encoding: none),
width: 100%) // Rastergrafik
