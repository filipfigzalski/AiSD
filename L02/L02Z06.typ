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

= Zadanie 6

== Treść

Ułóż algorytm, który dla danego $n$-wierzchołkowego drzewa i liczby $k$,
pokoloruje jak najwięcej wierzchołków tak, by na każdej ścieżce prostej było nie
więcej niż $k$ pokolorowanych wierzchołków.

== Algorytm

+ Dla każdej wartości $i$ od $0$ do $floor(k/2)$:

  + Krok warunkowy

--

+ Dla $i = 0, ..., floor(k/2)$:

  + Jeśli istnieje wierzchołek o stopniu $1$, to go pokoloruj.

  + W przeciwnym przypadku, usuń/odetnij pokolorowane wierzchołki.

+ Jeśli $k$ jest nieparzyste i istnieje niepokolorowany wierzchołek, to pomaluj go
  lub jeśli jest ich kilka, to dowolny z nich.

== Dowód poprawności

Dowód poprzez indukcję po $k$:

/ Podstawa: \
  Dla $k = 1$, kolorujemy dowolny wierzchołek.

/ Krok indukcyjny: \
  Pokażemy dla $k + 1$. Rozpatrzmy przypadki:
  + $k$ jest *parzyste*:

    Wtedy pomalujemy $k/2$ warst i będzie to malowanie, gdzie na każdej ścieżce
    znajduje się maksymalnie $k$ pokolorowanych wierzchołków. Zatem malując
    dodatkowo jeszcze jeden wierzchołek otzrymamy dobre kolorowanie, ponieważ
    ścieżka przechodzi tylko raz przez każdy wierzchołek.

  + $k$ jest *nieparzyste*:

    Wtedy dla $k + 1$ mamy pomalowaną o jedną więcej warstwę względem $k - 1$. Każda
    ścieżka może przejść przez daną warstwę maks $2$ razy. Skoro dla $k - 1$, to dla $k - 1$ z
    założenia maksimum pokolorowanych wierzchołków na ścieżce to $k - 1$, to dla $k + 1$ ten
    maks to $k - 1 + 2 = k + 1$.
    #align(right)[#sym.qed]

== Maksymalność

// $V_"kol"$ - zbiór wierzchołków pomalowanych

Niech zbiór wierzchołków $P$ to wynik zwrócony przez nasz algorytm i niech $"OPT"$
będzie dowolnym poprawnym pokolorowaniem wierzchołków, który jest maksymalny w
pod względem swojego rozmiaru.

Załóżmy nie wprost, że $abs("OPT") > abs(P)$. W $P$ mamy pomalowane $k/2$ warstw,
a w $"OPT"$ mamy więcej wierzchołków pokolorowanych.

Niech $v$ to wierzchołek z najniższej możliwej nie w pełni pokolorowanej w $"OPT"$
warstwie, a $w$ to pierwszy pokolorowany wierzchołek na ścieżce z $v$ do
dowolnego liścia.

(Możemy wziąć dowolny liść ponieważ w OPTcie każda ścieżka ma conajmniej k - 1
pokolorowanych wierzchołków.)

to pierwszy pokolorowany wierzchołek z dowolnej wyższej warstwy. Możemy
zauważyć, że na ścieżce z $v$ do $w$ nie ma więcej pomalowanych wierzchołków.
*Trzeba to udowodnić.*

Weźmy dowolną ścieżkę $S$ z $"OPT"$.

Rozważmy teraz wszystkie przypadki biorąc pod uwagę to czy dany wierzchołek leży
na ścieżce $S$:

+ *$v in S and w in S$* (oba są na ścieżce $S$):

  Liczba pomalowanych wierzchołków na ścieżce $S$ zostanie zachowana.

+ *$v in.not S and w in.not S$* (oba są poza ścieżką $S$):

  Podobnie jak w przypadku powyżej, liczba pomalowanych wierzchołków na ścieżce
  $S$ zostanie zachowana.

+ *$v in.not S and w in S$*:

  Liczba pomalowanych wierzchołków na ścieżce $S$ się zmniejszy o $1$.

+ *$v in S and w in.not S$*:

  Zauważmy, że jeżeli ścieżka zawiera mniej niż $k$ pokolorowanych wierzchołków,
  to możemy bezpiecznie na niej pokolorować jeszcze jeden wierzchołek. Załóżmy
  więc, że tak nie jest, czyli $S$ posiada dokładnie $k$ pokolorowanych
  wierzchołków.

  Niech $l$ będzie liczbą pokolorowanych wierzchołków na dowolnej ścieżce.

  Niech $x, y$ to początek i koniec ścieżki $S$.

  Niech $S'$ to maksymalna ścieżka zawierająca $v$ i $w$ (czyli $v$ i $w$ nie
  muszą być końcami tejże ścieżki).
