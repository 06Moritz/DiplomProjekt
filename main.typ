#import "config.typ": *

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

// Bahn - Auto - Controller
#pagebreak()
#aktueller_autor.update(author1) // Melanie

// Bahn
#include "Bahn/main-bahn.typ"

// Auto
#pagebreak()
#aktueller_autor.update(author2) // Moritz

#include "Auto/main-auto.typ"

// Controller
#pagebreak()
#aktueller_autor.update(author3) // Magdalena


// Alle
#pagebreak()
#aktueller_autor.update(author1 + ", " + author2 + ",\n" + author3 + ", " + klasse)

//#include "Alle/begleitprotokolle.typ"
#include "Verzeichnisse/abkuerzungsverzeichnis.typ"

#include "Verzeichnisse/glossar.typ"

#include "Verzeichnisse/abbildungsverzeichnis.typ"
#include "Verzeichnisse/literaturverzeichnis.typ"

<ende_arbeit>