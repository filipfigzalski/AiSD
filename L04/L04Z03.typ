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
#set document(title: "AiSD L04Z03 2025", author: "Filip Figzał")
#set text(lang: "pl")

= Zadanie 3

_Superciągiem_ ciągów $X$ i $Y$ nazywamy każdy taki ciąg $Z$, że zarówno $X$ jak
i $Y$ są podciągami ciągu $Z$.

Ułóż algorytm, który dla danych ciągów $X$ i $Y$ znajduje ich najkrótszy
superciąg.

(ang. _Shortest Common Supersequence_, SCS)

== Algorytm

Problem można rozwiązać przy użyciu programowania dynamicznego. Niech $X = x_1 x_2 ... x_n$
oraz $Y = y_1 y_2 ... y_m$ będą ciągami wejściowymi o długościach odpowiednio
$n = abs(X)$ i $m = abs(Y)$.

=== Obliczanie długości SCS

Definiujemy tablicę $"dp"[i, j]$ jako długość najkrótszego wspólnego superciągu
dla prefiksów $X[1..i]$ oraz $Y[1..j]$. Wartości w tablicy obliczamy zgodnie z
następującą rekurencją, zakłądając indeksowanie od $1$:
$
  "dp"[i, j] = cases(
    j & "dla" i = 0,
    i & "dla" j = 0,
    "dp"[i-1, j-1] + 1 & "jeśli" x_i = y_j,
    min("dp"[i-1, j], "dp"[i, j-1]) + 1 & "jeśli" x_i != x_j,

  )
$

Ostateczna długość najkróteszego superciągu dla całych ciągów $X$ i $Y$ znajduje
się w komórce $"dp"[n, m]$.

=== Odtworzenie superciągu

Aby odtworzyć sam superciąg (a nie tylko jego długość), należy prześledzić
ścieżkę w tablicy $"dp"$ od komórki $(n, m)$ do $(0, 0)$. Zaczynając od
$i = n$, $j = m$, wykonujemy następujące kroki, dopóki $i > 0$ lub $j > 0$.

+ Jeśli *$x_i = y_j$*: dodajemy $x_i$ na początek wyniku i przechodzimy do komórki
  $(i-1, j-1)$.

+ Jeśli *$x_i != y_j$*:

  + Jeśli *$"dp"[i-1, j] <= "dp"[i, j-1]$*: dodajemy $X_i$ na początek wyniku i
    przechodzimy do komórki $(i-1, j)$.

  + Jeśli *$"dp"[i-1, j] > "dp"[i, j-1]$*: dodajemy $Y_j$ na początek wyniku i
    przechodzimy do komórki $(i, j-1)$.

+ Jeśli *$i = 0$*: dodajemy pozostały prefiks $Y[1..j]$ na początek wyniku i
  kończymy.

+ Jeśli *$j = 0$*: dodajemy pozostały prefiks $X[1..i]$ na początek wyniku i
  kończymy.

#pagebreak()

== Dowód poprawności

W każdej komórce $"dp"[i, j]$ przechowujemy długość najkrótszego wspólnego
superciągu dla prefiksów $X[1..i]$ i $Y[1..j]$. Poprawność algorytmu wynika z
zasady optymalności.

+ *Przypadki bazowe*:

  + *$"dp"[i, 0] = i$*:\
    Najkrótszy superciąg dla $X[1..i]$ i pustego ciągu to sam $X[1..i]$, który ma
    długość $i$.
  + *$"dp"[0, j] = j$*:\
    Analogicznie dla $Y[1..j]$ i pustego ciągu.

+ *Krok rekurencyjny*:\
  Rozważmy problem dla $"dp"[i, j]$.

  + Jeśli *$x_i = y_j$*:\
    Ostatni znak obu prefiksów jest taki sam. Możemy go użyć jako ostatniego znaku
    wspólnego superciągu. Pozostała część superciągu musi być najkrótszym
    superciągiem dla prefiksów $X[1..i-1]$ i $Y[1..j-1]$. Jego długość to
    $"dp"[i-1, j-1]$. Zatem całkowita długość wynosi $"dp"[i-1, j-1] + 1$.

  + Jeśli *$x_i != y_j$*:\
    Ostatnio znak superciągu musi być albo $x_i$, albo $y_j$.

    + Jeśli wybierzemy $x_i$, musimy znaleźć SCS dla $X[1..i-1]$ i $Y[1..j]$, a
      następnie dołączyć $x_i$. Długość wyniesie $"dp"[i-1, j] + 1$.

    + Jeśli wybierzemy $y_j$, musimy znaleźć SCS dla $X[1..1]$ i $Y[1..j-1]$, a
      następnie dołączyć $y_j$. Długość wyniesie $"dp"[i, j-1] + 1$.

    Wybieramy opcję, kóra dalej krótszy wynik, stąd $min("dp"[i-1, j], "dp"[i, j-1]) + 1$.

Ponieważ w każdym kroku podejmujemy optymalną lokalnie decyzję, która prowadzi
do globalnego optimum, algorytm jest poprawny.

== Analiza złożoności

Niech $n = abs(X)$ oraz $m = abs(Y)$.

- *Złożoność czasowa:* Algorytm wypełnia tablicę o wymiarach $(n+1) times (m+1)$.
  Obliczenie wartości każdej komórki zajmuje stały czas $O(1)$. Odtworzenie ciągu
  trwa $O(n+m)$, ponieważ przechodzimy od $(n,m)$ do $(0,0)$. Zatem całkowita
  złożoność czasowa wynosi $O(n dot m)$.

- *Złożoność pamięciowa:* Wymagane jest przechowywanie całej tablicy $"dp"$, co
  zajmuje $O(n dot m)$ pamięci.
