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
#set document(title: "AiSD L02Z06 2025", author: "Filip Figzał")
#set text(lang: "pl")

#import "@preview/cetz:0.3.4"

= Zadanie 6

== Treść

Ułóż algorytm, który dla danego $n$-wierzchołkowego drzewa i liczby $k$,
pokoloruje jak najwięcej wierzchołków tak, by na każdej ścieżce prostej było nie
więcej niż $k$ pokolorowanych wierzchołków.

== Algorytm

Będziemy iteracyjnie kolorować warstwy liści w drzewie.

+ Zainicjuj zbiór pokolorowanych wierzchołków $C := emptyset$.

+ Zainicjuj roboczą kopię drzewa $T' := T$.

+ Wykonaj $floor(k/2)$ razy:

  + Jeśli $T'$ jest pusty, zakończ pętlę.

  + Znajdź zbiór $L$ wszystkich liści w aktualnym drzewie $T'$.

  + Dodaj wszystkie wierzchołki z $L$ do zbioru $C$.

  + Zaktualizuj $T'$ poprzez usunięcie z niego wszystkich wierzchołków ze zbioru $L$.

+ Jeśli $k$ jest nieparzyste i graf $T'$ wciąż zawiera jakieś wierzchołki:

  + Wybierz dowolny wierzchołek $v$ należący do $T'$.

  + Dodaj $v$ do zbioru $C$.

+ Zwróć zbiór $C$.

== Dowód poprawności

Musimy pokazać, że na dowolnej ścieżce w oryginalnym drzewie $T$ znajduje się co
najwyżej $k$ pokolorowanych wierzchołków.

Rozważmy dowolną ścieżkę $P$ w drzewie $T$. Ścieżka ta może wejść do pewnej
warstwy i ją opuścić co najwyżej raz. Oznacza to, że $P$ może zawierać co
najwyżej dwa wierzchołki z dowolnej warstwy.

+ *$k$ jest parzyste*:

  Algorytm wykonuję pętlę $floor(k/2) = k/2$ razy. Oznacza to, że koloruje
  dokładnie $k/2$ najbardziej zewnętrznych liści. Każda z tych warstw może dodać
  do naszej ścieżki co najwyżej $2$ pokolorowane wierzchołki. W najgorszym
  przypadki ścieżka przejdzie przez każdą warstwę $2$ razy. Całkowita liczba
  wierzchołków na ścieżce nie przekroczy więc $k$.

+ *$k$ jest nieparzyste*:

  Algorytm wykonuje pętlę $floor(k/2) = (k - 1)/2$ razy. Koloruje więc $(k - 1)/2$
  warstw. Te warstwy mogą dać co najwyżej $k - 1$ pokolorowanych wierzchołków na
  dowolnej ścieżce, więc po pokolorowaniu jednego dodatkowego wierzchołka, żadna
  ścieżka nie będzie miała więcej niż $k$ pokolorowanych wierzchołków.

== Złożoność

Na początek musimy znaleźć wszystkie liście, musimy przejść po każdym
wierzchołku zatem zajmie to $O(n)$. Podczas usuwania wierzchołków w aktualnym
$L$ możemy tworzyć kolejne $L'$, które będzie zawierało liście które się
utworzą. Takich operacji znowu wykonamy $O(n)$. Wszystkie inne operacje powinny
nas kosztować stały czas.

Wykonanie: $O(n)$; Złożoność pamięciowa: $O(n)$.

== Maksymalność

Dowód przeprowadzimy za pomocą argumentu wymiany. Pokażemy, że dowolne optymalne
rozwiązanie $C_"OPT"$ można krok po kroku przekształcić w rozwiązanie
wygenerowane przez nasz algorytm, $C_"ALG"$, nie zmniejszając przy tym liczby
pokolorowanych wierzchołków.

Załóżmy, że $k >= 2$, ponieważ dla $k = 0, 1$ możemy pokolorować $T$ w trywialny
sposób.

Niech $C_"OPT"$ będzie optymalnym kolorowaniem. Chcemy pokolorować wszystkie
liście $L_0$ w drzewie $T$. Jeśli $L_0 subset.eq C_"OPT"$ (wszystkie liście są
pokolorowane), to $C_"OPT"$ zgadza się z $C_"ALG"$ na pierwszej warstwie i
możemy kontynuować rekurencyjnie dla drzewa $T - L_0$ i parametru $k - 2$.

Załóżmy, więc że istnieje liść $v in L_0$, który nie jest pokolorowany w
rozwiązaniu optymalnym, czyli $v in.not C_"OPT"$. Pokażemy, że możemy
zmodyfikować $C_"OPT"$ tak, aby zawierało $v$, nie tracąc na optymalności.

Rozważmy nowe kolorowanie $C_"test" = C_"OPT" union {v}$.

+ *Kolorowanie $C_"test"$ jest poprawne*:

  Jeśli $C_"test"$ jest poprawne, to znaleźliśmy rozwiązanie lepsze od
  optymalnego, ponieważ $abs(C_"test") = abs(C_"OPT") + 1$. To jest sprzeczność z
  założeniem, że $C_"OPT"$ jest optymalne. Ten przypadek nie może więc zajść.
  #sym.arrow.zigzag

+ *Kolorowanie $C_"test"$ jest niepoprawne*:

  Skoro $C_"test"$ jest niepoprawne, to musi istnieć co najmniej jedna ścieżka, na
  której znajduje się $k + 1$ pokolorowanych wierzchołków. Nazwijmy zbiór takich
  "zepsutych" ścieżek $cal(P)_"zepsute"$.

  Każda ścieżka $P in cal(P)_"zespute"$ musi spełniać dwa warunki

  + $v in P$, ponieważ bez $v$ kolorowanie było poprawne.
  + $abs(P inter C_"OPT") = k$, czyli przed pokolorowaniem $v$, ścieżka miała $k$
    pokolorowanych wierzchołków.

  / Lemat 1: _Istnieje pokolorowany wierzchołek $w$ wspólny dla wszystkich zepsutych ścieżek._

    Niech $P_1, P_2 in cal(P)_"zepsute"$ będą dwiema różnymi zepsutymi ścieżkami.
    Jako że obie zaczynają się w liściu $v$, muszą posiadać pewną część wspólną.
    Niech $z$ będzie wierzchołkiem, w którym te ścieżki się rozchodzą.

    #figure(
      cetz.canvas(
        {
          import cetz.draw: *
          import cetz.decorations: *

          set-style(fill: white)

          wave(line((0, 0), (angle: 135deg, radius: 2)), amplitude: -0.2, segments: 3)
          wave(line((0, 0), (angle: 45deg, radius: 2)), amplitude: 0.2, segments: 3)

          line((0, 0), (angle: -90deg, radius: 2), name: "comb")
          circle((0, 0), radius: 0.3, name: "z")

          circle("comb.end", radius: 0.3, name: "v")

          brace((-0.6, -2.2), (-1.7, 1.3), amplitude: 0.3, name: "b1")
          brace((1.7, 1.3), (0.6, -2.2), amplitude: 0.3, name: "b2")
          brace((-1.4, 1.7), (1.4, 1.7), amplitude: 0.3, name: "b3")

          content("z.center", $z$)
          content("v.center", $v$)
          content("b1.content", $P_1$)
          content("b2.content", $P_2$)
          content("b3.content", $S$)
        },
      ),
      caption: [Poglądowy rysunek opisanej sytuacji],
    )

    Załóżmy, dla dowodu nie wprost, że na wspólnej części ścieżki od $v$ do $z$ nie
    ma żadnego wierzchołka z $C_"OPT"$. Oznacza to, że wszystkie $k$ pokolorowane
    wierzchołki z $P_1 inter C_"OPT"$ leżą na gałęzi za $z$, a wszystkie $k$
    pokolorowane wierzchołki z $P_2 inter C_"OPT"$ leżą na swojej gałęzi za $z$.

    Rozważmy teraz ścieżkę $S$ łączącą końcowe wierzchołki $P_1$ i $P_2$. Ścieżka ta
    przechodzi przez $z$. Liczba pokolorowanych wierzchołków na $S$ wynosi:
    $
      abs(S inter C_"OPT") =
      abs((P_1 without P_2) inter C_"OPT") + abs((P_2 without P_1) inter C_"OPT") =
      k + k =
      2k
    $
    Jeśli $k >= 1$, to $2k > k$, co oznacza, że oryginalne kolorowanie $C_"OPT"$
    było niepoprawne. To jest sprzeczność.
    #sym.arrow.zigzag

    Zatem na wspólnym odcinku każdej pary zepsutych ścieżek musi znajdować się co
    najmniej jeden pokolorowany wierzchołek. To implikuje, że istnieje wierzchołek
    $w in C_"OPT"$, który leży na każdej ścieżce ze zbioru $cal(P)_"zepsute"$.
    #sym.square

  Skoro udowodniliśmy istnienie takiego wspólnego wierzchołka $w$, wybierzmy go
  tak, aby był jak najbliżej liścia $v$ na ścieżce.

  Zdefiniujmy nowe kolorowanie:
  $
    C'_"OPT" = (C_"OPT" without {w}) union {v}
  $
  Zauważmy, że $abs(C'_"OPT") = abs(C_"OPT")$, więc jeśli jest ono poprawne, to
  jest również optymalne.

  / Dowód poprawności $C'_"OPT"$:\
    Niech $S$ będzie dowolną ścieżką w $T$.

    + *$w in.not S$*:\
      Liczba pokolorowanych wierzchołków na $S$ mogła się co najwyżej zwiększyć o $1$ (jeśli $v in S$).
      Jeśli by to spowodowało "zepsucie" ścieżki $S$, oznaczałoby to, że $abs(S inter C_"OPT")$ =
      k i $v in S$. Ale wtedy $S$ należałoby do $cal(P)_"zepsute"$. Z naszego lematu
      wiemy jednak, że każda ścieżka z $cal(P)_"zepsute"$ musi zawierać $w$. To jest
      sprzeczność z założeniem $w in.not S$. Zatem ten przypadek jest bezpieczny.

    + *$w in S$*:\
      Liczba pokolorowanych wierzchołków na $S$ w $C'_"OPT"$ wynosi
      $abs(S inter C_"OPT") - 1$ (jeśli $v in.not S$) lub $abs(S inter C_"OPT")$
      (jeśli $v in S$). W obu sytuacjach liczba ta nie przekracza $k$, ponieważ
      $S inter C_"OPT" <= k$. Ten przypadek również jest bezpieczny.

  Pokazaliśmy, że możemy zamienić $w$ na $v$, otrzymując nowe, poprawne i wciąż
  optymalne kolorowanie $C'_"OPT"$, które zawiera liść $v$.

Możemy powtarzać ten proces dla każdego liścia z $L_0$, który nie należy do $C_"OPT"$.
Po skończonej liczbie kroków przekształcimy $C_"OPT"$ w inne optymalne
rozwiązanie $C^*_"OPT"$, które zawiera wszystkie liście z $L_0$.

Możemy zastosować to samo rozumowanie do podproblemu ($T - L_0$, $k - 2$).
Indukcyjnie dochodzimy do wniosku, że istnieje rozwiązanie optymalne, które ma
dokładnie taką samą konstrukcję jak $C_"ALG"$. Zatem $abs(C_"ALG") = abs(C_"OPT")$.

#align(right)[#sym.square.filled]
