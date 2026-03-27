#import "../config.typ": *

= Anhang

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
#set heading(outlined: true, numbering: none, bookmarked: false)
#set page(margin: 0cm, header: none, footer: none)

= Hauptmodul // Beilage 1
#include "bahn-schaltplan-p1.typ"
#include "bahn-schaltplan-p2.typ"
#include "bahn-layout-top.typ"
#include "bahn-layout-bottom.typ"

= Fahrzeug // Beilage 2
#include "auto-schaltplan.typ"
#include "auto-layout-top.typ"
#include "auto-layout-bottom.typ"

= Controller // Beilage 3
#include "controller-schaltplan.typ"
#include "controller-layout-top.typ"
#include "controller-layout-bottom.typ"
  
= Ladestation // Beilage 4
#include "ladestation-schaltplan.typ"
#include "ladestation-layout-top.typ"
#include "ladestation-layout-bottom.typ"

= Joystick // Beilage 5
#include "joystick-schaltplan.typ"
#include "joystick-layout-top.typ"
#include "joystick-layout-bottom.typ"

= Wellenaufhängung // Beilage 6
#include "wellenaufhaengung1.typ"
#include "wellenaufhaengung2.typ"