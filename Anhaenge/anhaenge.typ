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
#image("../PDF/auto/SCH.pdf", width: 100%) // Vektorgrafik
= Fahrzeug Layout TOP
#muchpdf(read("../PDF/auto/lay_top.pdf", encoding: none),
width: 100%) // Rastergrafik
