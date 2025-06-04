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

= Zadanie 8

== Treść

Operacja `swap(i, j)` na permutacjij powoduje przestawienie elementów
znajdujących się na pozycjach $i$ oraz $j$. Koszt takiej operacji określamy na
$abs(i - j)$. Kosztem ciągu operacji `swap` jest suma kosztów poszczególnych
operacji.

== Algorytm

+ Dla każdego:
  + Jeżeli
