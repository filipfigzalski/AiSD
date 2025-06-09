#set page(footer: context[
  #grid(
    columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    stroke: none,
    [],
    [#counter(page).display()],
    [#text(8pt, gray)[Opracował: Filip Figzał, 2025 ]],
  )
], numbering: "-1-")
#set par(justify: true)
#set enum(numbering: "1ia.")
#set document(title: "AiSD L02Z08 2025", author: "Filip Figzał")
#set text(lang: "pl")

= Zadanie 8

== Treść

Operacja `swap(i, j)` na permutacjij powoduje przestawienie elementów
znajdujących się na pozycjach $i$ oraz $j$. Koszt takiej operacji określamy na
$abs(i - j)$. Kosztem ciągu operacji `swap` jest suma kosztów poszczególnych
operacji.

Ułóż algorytm, który dla danych $pi$ oraz $sigma$ - permutacji liczb ${1, 2, ..., n}$,
znajdzie ciąg operacji `swap` o najmniejszym koszcie, który przekształca
permutację $pi$ w permutację $sigma$.

== Algorytm

$Tau$

== Dowód poprawności

== Dowód minimalności

== Dowód liniowości
