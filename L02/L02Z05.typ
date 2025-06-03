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

= Zadanie 5

== Treść

Ułóż algorytm, który dla danego grafu $G = (V, E)$ oraz liczby naturalnej $k$
znajdzie możliwie największy podzbiór $V' subset.eq V$, taki że dla każdego
wierzchołka $v in V'$ zachodzi:
$
  abs({u in V' : {v, u} in E})     &>= k "oraz" \
  abs({u in V' : {v, u} in.not E}) &>= k
$

=== Wyjaśnienie

Celem jest znalezienie największego (w sensie liczby wierzchołków) podzbioru
$V'$ grafu $G$, takiego że każdy wierzchołek $v$ w tym podzbiorze $V'$ ma:
+ Co najmniej $k$ *sąsiadów* należących do $V'$.
+ Co najmniej $k$ *nie-sąsiadów* należących do $V'$ (czyli wierzchołków z
  $V' without v$ z którymi $v$ nie tworzy krawędzi w $G$).

== Algorytm

Niech $V_"cur"$ oznacza zbiór aktualnie rozważanych (jeszcze nieusuniętych
wierzchołków). Początkowo $V_"cur" = V$. Dla każdego wierzchołka $v in V_"cur"$ będziemy
śledzić jego stopień $d_"cur" (v)$ (liczbę sąsiadów w $V_"cur"$).

+ Utwórz kubełki `KUB[i]` dla $i$ od $0$ do $abs(V) - 1$. Dla każdego wierzchołka $v in V$ oblicz
  jego początkowy stopień $d(v)$ w grafie $G$ i umieść $v$ w kubełku `KUB[d(v)]`.

+ Utwórz pustą kolejkę `Q`. Dla każdego wierzchołka $v in V_"cur"$:
  + Jeśli $d_"cur" (v) < k$ (za mało sąsiadów w $V_"cur"$), dodaj $v$ do `Q`.
  + Jeśli $abs(V_"cur") - 1 - d_"cur" (v) < k$ (za mało nie-sąsiadów w $V_"cur"$),
    dodaj $v$ do `Q` (jeśli nie został już dodany).
  Oznacz wierzchołki dodane do `Q` jako "do usunięcia", aby uniknąć duplikatów.

+ Dopóki kolejka `Q` nie jest pusta:
  + Wyjmij wierzchołek $v$ z `Q`. Oznacz $v$ jako "usunięty" i usuń go z $V_"cur"$ (zmniejszając
    tym samym $abs(V_"cur")$).

  + Dla każdego sąsiada $u$ wierzchołka $v$ (takiego, który jest w $V_"cur"$ i nie
    jest "usunięty" ani "do usunięcia"):
    + Przenieś $u$ z `KUB[`$d_"cur" (u)$`]` do `KUB[`$d_"cur" (u) - 1$`]`. Zaktualizuj $d_"cur" (u) arrow.l d_"cur" (u) - 1$.
    + Jeśli $d_"cur" (u) < k$ (teraz $u$ ma za mało sąsiadów), dodaj $u$ do `Q` i
      oznacz jako "do usunięcia".

  + Po usunięciu $v$ i zaktualizowaniu wszystkich sąsiadów, rozmiar $V_"cur"$ zmalał.
    Może to spowodować, że niektóre wierzchołki mają teraz za mało nie-sąsiadów.

    Dla każdego wierzchołka $w$ znajdującego się w kubełku `KUB[`$abs(V_"cur") - k$`]`:
    - jeśli $w$ jest w $V_"cur"$ i nie jest "do usunięcia", dodaj $w$ do `Q` i oznacz
      jako "do usunięcia". (Warunek $abs(V_"cur") - 1 - d_"cur" (w) < k$ będzie
      automatycznie spełniony dla $d_"cur" (w) = abs(V_"cur") - k$).

+ Zbiór $V'$ to wszystkie wierzchołki, które nie zostały oznaczone jako "usunięte"
  (czyli pozostałe $V_"cur"$).

#pagebreak()

== Analiza złożoności

+ *Inicjalizacja kubełków* #h(1fr) $O(V + E)$

  Obliczenie stopni wszystkich wierzchołków i umieszczenie ich w kubełkach.

+ *Inicjalizacja kolejki* #h(1fr) $O(V)$

  Przejrzenie wszystkich $abs(V)$ wierzchołków i ewentualne dodanie ich do
  kolejki.

+ *Pętla główna*

  Pętla wykonuje się co najwyżej $abs(V)$ razy, ponieważ każdy wierzchołek może
  być dodany do kolejki i usunięty co najwyżej raz.

  + *Wyjęcie z kolejki, oznaczenie* #h(1fr) $O(V)$

    Obie operacje wykonują się w czasie $O(1)$.

  + *Aktualizacja sąsiadów*

    Gdy wierzchołek $v$ jest usuwany, przeglądamy jego sąsiadów. Każda krawędź
    ${v, u}$ jest brana pod uwagę co najwyżej dwa razy w całym algorytmie (raz gdy $v$ jest
    usuwane i raz gdy $u$ jest usuwany).

    Każdy wierzchołek jest dodawany do kolejki co najwyżej raz.

    / Sumaryczne koszty:
    - Aktualizacja stopni i przenoszenie między kubełkami #h(1fr) $O(E)$
    - Dodawanie sąsiadów do kolejki #h(1fr) $O(V)$

  + *Sprawdzenie warunku nie-sąsiadów* #h(1fr) $O(V)$

    Każdy wierzchołek może zostać dodany do kolejki co najwyżej raz oraz sprawdzamy
    tylko jeden kubełek.

Całkowita złożoność czasowa algorytmu wynosi $O(V + E)$.

Złożoność pamięciowa to $O(V + E)$ na przechowanie grafu, kubełków i kolejki.

== Dowód poprawności

Dowód opiera się na niezmienniku pętli. Niech $V_"cur"$ oznacza zbiór
wierzchołków nieusuniętych.

#rect[
Na początku każdej iteracji głównej pętli, każdy wierzchołek $w in V_"cur"$,
który nie znajduje się w kolejce `Q`, spełnia oba warunki zadania względem
aktualnego zbioru $V_"cur"$:

+ Liczba sąsiadów $w in V_"cur"$ (oznaczane jako $d_"cur" (w)$) jest $>= k$.

+ Liczba nie-sąsiadów $w$ w $V_"cur"$ (to jest $abs(V_"cur") - 1 - d_"cur" (w)$)
  jest $>= k$.
]

=== Inicjalizacja

Przed pierwszą iteracją pętli (po inicjalizacji kolejki:
- Wszystkie wierzchołki $v in V$ (bo $V_"cur" = V$ na tym etapie) zostały
  sprawdzone.
- Te, które nie spełniały warunku liczby sąsiadów lub nie-sąsiadów, zostały dodane
  do kolejki `Q`.

  Zatem każdy wierzchołek $w in V_"cur"$ niebędący w `Q` musi spełniać oba
  warunki.

=== Utrzymanie

Załóżmy, że niezmiennik jest prawdziwy na początku iteracji. Wierzchołek $v$ jest
wyjmowany z `Q` i usuwany z $V_"cur"$.

+ *Usunięcie*

  $v$ nie jest już w $V_"cur"$, więc nie musi spełniać niezmiennika. Rozmiar $V_"cur"$ maleje
  o $1$.

+ *Aktualizacja sąsiadów*

  Dla każdego sąsiada $u$ wierzchołka $v$ (który jest w $V_"cur"$):
  + Jego stopień $d_"cur" (u)$ maleje o $1$.

  + Jeśli nowy $d_"cur" (u)$ spadnie poniżej $k$, $u$ jest dodawany do `Q`.

+ *Sprawdzenie nie-sąsiadów*

  Liczba nie-sąsiadów wynosi teraz $abs(V_"cur")_"nowy" - 1 - d_"cur" (w)$. Jeśli
  ta wartość jest mniejsza od $k$, $w$ jest dodawany do `Q`. Algorytm identyfikuje
  takie wierzchołki dla których liczba nie-sąsiadów to $k - 1$ (poprzez odwołanie
  do odpowiedniego kubełka).

Po tych operacjach każdy wierzchołek $w in V_"cur"$, który nie jest w `Q`, musi
mieć $d_"cur" (w) >= k$ (bo inaczej zostałby dodany w poprzedniej iteracji lub w
kroku ii.) oraz $abs(V_"cur") - 1 - d_"cur" >= k$ (bo inaczej zostałby dodany w
poprzedniej iteracji lub w kroku iii.).

=== Terminacja

Pętla kończy się, gdy kolejka `Q` jest pusta. Zgodnie z niezmiennikiem, w tym
momencie każdy wierzchołek $w$ w ostatecznym zbiorze $V_"cur"$ (czyli $V'$) nie
jest w `Q` i nie jest usunięty. Dlatego każdy $w in V'$ spełnia oba warunki:

+ $d_V' (w) >= k$
+ $abs(V') - 1 - d_V' (w) >= k$

Jest to dokładnie definicja wymaganego podzbioru.

== Maksymalność

Algorytm usuwa wierzchołki iteracyjnie. Wierzchołek jest usuwany tylko wtedy,
gdy narusza co najmniej jeden z warunków w kontekście aktualnie nieusuniętych
wierzchołków.

Jeśli wierzchołek $v$ został usunięty, oznacza to, że nie mógłby być częścią
żadnego poprawnego rozwiązania $V_"opt"$ będącego podzbiorem aktualnego $V_"cur"$
(w momencie przed usunięciem $v$), ponieważ $v$ naruszałby warunki w $V_"opt"$
(gdyż $V_"opt" subset.eq V_"cur"$ i warunki są monotoniczne w sensie, że
usunięcie innych wierzchołków nie poprawi sytuacji $v$). Każdy wierzchołek,
który mógłby należeć do jakiegokolwiek rozwiązania, nie zostanie usunięty. Zatem
znaleziony zbiór $V'$ jest największym możliwym podzbiorem.

