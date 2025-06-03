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

= Zadanie 1

== Treść

Przeprowadź dowód poprawności algorytmu Kruskala, który przyrównuje ciąg
krawędzi drzewa wybranych przez algorytm Kruskala z ciągiem krawędzi minimalnego
drzewa spinającego (otrzymanego przez jakiś algorytm optymalny). W dowodzie nie
powołuj się na własności typu _cut property_ czy _cycle property_.

=== Algorytm Kruskala

Niech $G = (V, E)$ będzie grafem spójnym, ważonym, gdzie wagi krawędzi są
nieujemne, opisane funkcją $c : E -> RR_0^+$. Algorytm Kruskala znajduje
minimalne drzewo rozpinając (MST) dla $G$ w następujący sposób:

+ Zainicjalizuj zbiór krawędzi MST jako pusty: $T = emptyset$.

+ Utwórz listę wszystkich krawędzi $E'$ z grafu $G$.

+ Posortuj krawędzie na liście $E'$ w kolejności niemalejącej według ich wag
  $c(e)$. Niech posortowana lista krawędzi to $(e_1, e_2, ..., e_m)$, gdzie
  $m = abs(E)$.

+ Dla każdej krawędzi $e_i$ z posortowanej listy (od $i = 1$ do $m$):
  - Jeśli dodanie krawędzi $e_i$ do zbioru $T$ nie tworzy cyklu w grafie
    $(V, T union {e_i})$, dodaj krawędź $e_i$ do $T$.

+ Zbiór $T$ zawiera krawędzie minimalnego drzewa rozpinającego grafu $G$.

== Dowód

Niech $T$ będzie drzewem wynikowym algorytmu Kruskala dla grafu $G$, a $M$ niech
będzie minimalnym drzewem rozpinającym grafu $G$ o największej liczbie wspólnych
krawędzi z $T$.

Załóżmy nie wprost, że $T != M$. Rozpatrzmy $e_i = (v, u)$ ($1 <= i <= m$)
będące najlżejszą krawędzią taką że $e_i in E_T and e_i in.not E_M$. Wtedy w
$M$ istnieje inna ścieżka $S$ z $v$ do $u$, taka że $abs(S) > 1$. Zatem w $S$ istnieje
$e_j$ ($1 <= j <= m$), takie że $e_j in E_M and e_j in.not E_T$ (w przeciwnym
przypadku istniałby cykl w $T$).

Rozpatrzmy przypadki:

+ *$c(e_i) < c(e_j)$*:

  Wtedy usuwamy $e_j$ z $M$ i dodajemy $e_i$. W ten sposób uzyskujemy drzewo
  rozpinające o wadze mniejszej niż $M$, zatem $M$ nie jest MST. #sym.arrow.zigzag

+ *$c(e_i) = c(e_j)$*:

  Wtedy usuwamy $e_j$ z $M$ i dodajemy $e_i$ uzyskując
  $M' = (V, (E_M without {e_j}) union {e_j})$, zatem zarówno $M$ jest MST jak i
  $M'$.

+ *$c(e_i) > c(e_j)$*:

  Wtedy $e_j$ było rozpatrywane przed $e_i$ i nie zostało dodane do $T$. Czyli
  $e_j$ tworzyło cykl w $T$. Oznacza to, że istnieje jakieś $e_k$
  ($k < j$ i $c(e_k) <= c(e_j) < c(e_i)$), takie że $e_k in T and e_k in.not M$.
  Mamy sprzeczność z założeniem wyboru $e_i$, bo założyliśmy, że $e_i$ jest
  najlżejszą dostępną krawędzią. #sym.arrow.zigzag

Co dowodzi poprawności algorytmu Kruskala.

