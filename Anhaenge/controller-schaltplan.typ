#import "../Templates/rahmen.typ": *

#show: rahmen-quer.with(
  dateiname: "Beilage 3",
  name: "Magdalena Reitsamer",
  gez: "ReiM",
  geprueft: "ProM",
  dokumentart: "Schaltplan",
  projekt: "Controller",
  //beschreibung: "",
  status: "Prototyp",
  datum: "20.03.2026",
  blatt: "1",
  blaetter: "3"
)

= Controller Schaltplan
#image("/PDF/bahn-sch-test.pdf", width: 100%, height: 100%, fit: "contain")