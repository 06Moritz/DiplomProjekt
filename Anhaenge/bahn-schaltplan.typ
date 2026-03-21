#import "../Templates/rahmen.typ": *

#show: rahmen-quer.with(
  //dateiname: "Beilage X",
  name: "Melanie Koch",
  gez: "KocM",
  geprueft: "KocM",
  dokumentart: "Schaltplan",
  projekt: "Bahn",
  //beschreibung: "",
  status: "Prototyp",
  datum: "20.03.2026"
)

= Bahn Schaltplan
#image("/PDF/bahn-sch-test.pdf", width: 100%, height: 100%, fit: "contain")