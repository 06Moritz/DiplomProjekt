#import "../Templates/rahmen.typ": *

#show: rahmen-quer.with(
  dateiname: "Beilage 2",
  name: "Moritz Prodinger",
  gez: "ProM",
  geprueft: "KocM",
  dokumentart: "Schaltplan",
  projekt: "Fahrzeug",
  //beschreibung: "",
  status: "Prototyp",
  datum: "20.03.2026",
  blatt: "1",
  blaetter: "3"
)

#image("/PDF/bahn-sch-test.pdf", width: 100%, height: 100%, fit: "contain")