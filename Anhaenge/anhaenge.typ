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

// 2 Arten zum Einfügen von PDFs:
= Fahrzeug Schaltplan
#v(4.5cm)
#figure(
rotate(90deg,muchpdf(read("../PDF/auto/SCH.pdf", encoding: none),width: 140%)) )

= Fahrzeug Layout TOP
#muchpdf(read("../PDF/auto/lay_top.pdf", encoding: none),
width: 100%)

//#pagebreak()
// derzeit nur Testbilder drinnen - erst richtig exportieren - bzw. schön anordnen
#include "bahn-schaltplan.typ"
#include "bahn-layout-top.typ"
#include "bahn-layout-bottom.typ"

//#include "auto-layout-top.typ"