#import "config.typ": *
#import "@preview/glossy:0.9.0": init-glossary

#show: init-glossary.with(eintraege)

#show: apply_styles
#show: start_layout

#include "Allgemein/deckblatt.typ"
#include "Allgemein/eidesstattliche-erklaerung.typ"
#include "Allgemein/vorwort.typ"
#include "Allgemein/danksagung.typ"
#include "Allgemein/abstract-de.typ"
#include "Allgemein/abstract-en.typ"



#include "Verzeichnisse/inhaltsverzeichnis.typ"

#show: page_layout.with(
  projekt: projekt,
  schuljahr: schuljahr,
  schule: schule
)

// Alle
#aktueller_autor.update(author1 + ", " + author2 + ",\n" + author3 + ", " + klasse)

#include "Alle/einleitung.typ"
#include "Alle/organisation.typ"

#pagebreak()
#include "technische Beschreibungen/tec-main.typ"

// Bahn - Auto - Controller - Ladestation
#pagebreak()
#include "Bahn/main-bahn.typ"
#pagebreak()
#include "Auto/main-auto.typ"
#pagebreak()
#include "Controller/main-controller.typ"
#pagebreak()
#include "Ladestation/main-ladestation.typ"

//App
#pagebreak()
#aktueller_autor.update(author3)
#include "UI/main-ui.typ"


// Alle
#pagebreak()
#aktueller_autor.update(author1 + ", " + author2 + ",\n" + author3 + ", " + klasse)

//#include "Alle/begleitprotokolle.typ"

#include "Verzeichnisse/glossar.typ"

#include "Verzeichnisse/abbildungsverzeichnis.typ"
#include "Verzeichnisse/literaturverzeichnis.typ"



#include "Anhaenge/anhaenge.typ"

<ende_arbeit>





