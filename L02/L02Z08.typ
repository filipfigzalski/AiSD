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

+ Oblicz `VAL[i]` - pozycję $i$-tej wartości w docelowej permutacji

+ Dla każdego:

  + If $#raw("VAL[i]") < i$ (wartość "chce iść w lewo")

    + $x = #raw("VAL[i]")$

    + $"STOS" := #raw("[]")$

    + Do

      - `STOS.PUSH(x)`
      - `x = VAL[x]`
      while $x < i$

    + `PREV = i`

    + While `STOS`

      + `CUR = STOS.POP`

      + `swap(PREV, CUR)`

      + `PREV = CUR`

== Dowód poprawności

Dowód poprawności odbędzie się przy użyciu niezmiennika:

#align(
  center,
)[
  #rect[
    Po każdej iteracji, żaden element o $i < i_"cur"$ "nie chce" iść w lewo.
  ]
]

== Dowód minimalności

/ Obserwacja 1:\
  Nie ma znaczenia w ilu `swap`'ach element dojdze na swoje miejsce, jeżelii
  zawsze się przemieszcza w swoim kierunku.
  $
    abs(i - k_1) + ... + abs(k_n - j) = abs(i - j)
  $

/ Obserwacja 2:\
  Nasz algorytm, jeśli przesuwa element w lewo, to element podczas swapowania od
  końca, wyląduje na swoim miejscu i nie będzie już przesuwany. Jeśli jest
  przesuwany w prawo, to nie dalej niż na swoją docelową pozycję.

Jeśli połączymy te dwie obserwacje, to widzimy, że pełny koszt to suma
odległości od docelowego miejsca dla każdego elementu.

== Dowód liniowości

+ Jeżeli w danej iteracji głównej pętli weszliśmy do IFa, to na aktualny element
  na pewno wyląduje na swoim miejscu.

+ Każdy `swap` wewnątrz ifa (gdzie pierwszy w kolejności wykonania _może_ a nie
  musi) prowadzi element na dokładnie swoje miejsce.

+ Z dwóch poprzednich punktów wynika, że jeżeli wykonujemy $k$ operacji `swap`
  wewnątrz IFa, to przynajmniej $k$ elementów trafi na swoje miejsce.

+ Każdy element może trafić na swoje miejsce tylko raz.

+ Z dwóch poprzedznich wynika, że algorytm wykona $O(n)$ swapów.

+ Żeby wygenerować jednego `swap`a, nasz algorytm wykona $O(n)$ operacji.

+ Zatem algorytm działa w czasie liniowy.

