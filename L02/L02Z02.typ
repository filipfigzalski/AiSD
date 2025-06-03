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

= Zadanie 2

== Treść

Danych jest $n$ odcinków $I_j = angle.l p_j, k_j angle.r$, leżących na osi OX,
$j = 1, ..., n$ . Ułóż algorytm znajdujący zbiór $S subset.eq {I_1, ..., I_n}$,
nieprzecinających się odcinków, o największej mocy.

== Algorytm

Niech $I = {I_1, ..., I_n}$ będzie zbiorem danych odcinków.

+ Sortujemy odcinki z $I$ niemalejąco według ich końców $k_j$. Niech posortowana
  lista odcinków to $I' = I'_1, ..., I'_n$.

+ Inicjalizujemy pusty zbiór wynikowy $S = emptyset$.

+ Jeśli posortowana lista $I'$ nie jest pusta:

  + Dodajemy pierwszy odcinek do $S$, $S = {I'_1}$

  + Zapamiętujemy czas zakończenia ostatniego dodanego odcinka:\
    $#raw("ostatni_koniec") = k'_1$, gdzie $k'_1$ to koniec odcinka $I'_1$.

  + Dla każdego kolejnego odcinka $I_j$ (gdzie $j = 2, ..., n$):
    - Jeśli początek odcinka $I'_j$ jest nie mniejszy niż `ostatni_koniec` (tzn.
      $p'_j >= #raw("ostatni_koniec")$):

      $S = S union {I'_j}$

      $#raw("ostatni_koniec") = k'_j$

+ Zwróć $S$.

== Dowód

Niech $"ALG" = a_1, ..., a_m$ będzie zbiorem odcinków wybranym przez nasz
algorytm, posortowanym zgodnie z kolejnością wyboru (a więc również według
niemalejących końców $k_a_j$). Niech $"OPT" = o_1, ..., o_k$ będzie dowolnym
optymalnym zbiorem nieprzecinających się odcinków, o największej mocy $k$,
również posortowanym według niemalejących końców $k_o_j$.

Chcemy pokazać, że $m = k$.

Rozpatrzmy następujące przypadki dotyczące relacji między końcami odcinków $a_i$
oraz $o_i$:

+ *$k_o_i < k_a_i$*:

  Ten przypadek prowadzi do sprzeczności. Gdyby $k_o_i < k_a_i$, to algorytm,
  wybierając odcinek o najwcześniejszym końcu spośród dostępnych (a $o_i$ był
  dostępny i $p_o_i >= k_a_(i-1)$), wybrałby $o_i$ lub inny odcinek kończący się
  nie później niż $o_i$, a nie $a_i$, który kończy się później. Zatem ten
  przypadek jest niemożliwy. Musi być $k_a_i <= k_o_i$. #sym.arrow.zigzag

+ *$k_o_i = k_a_i$*:

  Jeśli $a_i != o_i$ (bo to pierwszy różniący się element), ale $k_a_i = k_o_i$,
  możemy skonstruować nowe rozwiązanie $"OPT"' = {o_1, ..., o_(i-1), a_i, o_(i+1), ..., o_k}$.
  Rozwiązanie $"OPT"'$ jest poprawne:

  - $a_i$ nie koliduje z $o_(i-1)$ (ponieważ $a_(i-1)=o_(i-1)$ i z definicji
    algorytmu $p_a_i >= k_a_(i-1)$).

  - $a_i$ nie koliduje z $o_(i+1)$ (ponieważ $p_o_(i+1) > k_o_i$, a
    $k_o_i = k_a_i$, więc $p_o_(i+1) >= k_(a_i)$). Liczba odcinków w
    $"OPT"'$ jest taka sama jak w $"OPT"$ (czyli $k$), więc $"OPT"'$ jest również
    optymalne. Co więcej, $"OPT"'$ zgadza się z $"ALG"$
    na co najmniej $i$ pierwszych pozycjach. W tej sytuacji wybór $a_i$ przez
    algorytm jest co najmniej tak dobry jak wybór $o_i$.

+ *$k_o_i > k_a_i$*:

  Podobnie jak w przypadku $3$, skonstruujmy $"OPT"' = (o_1, ..., o_(i-1), a_i,
  o_(i+1), ..., o_k)$. Rozwiązanie $"OPT"'$ jest poprawne:

  - $a_i$ nie koliduje z $o_(i-1)$.

    - $p_(o_(i+1)) \ge k_(o_i)$. Ponieważ $k_(o_i) > k_(a_i)$, to tym bardziej
      $p_(o_(i+1)) > k_(a_i)$ (a więc $p_(o_(i+1)) \ge k_(a_i)$). Zatem $a_i$
      nie koliduje z $o_(i+1)$.

    Liczba odcinków w $"OPT"'$ wynosi $k$, więc $"OPT"'$ jest optymalne. $"OPT"'$
    zgadza się z $"ALG"$ na co najmniej $i$ pierwszych pozycjach. Wybór $a_i$
    (który kończy się wcześniej) jest co najmniej tak samo dobry (a potencjalnie
    lepszy, bo zostawia więcej miejsca) jak wybór $o_i$.

W każdym możliwym przypadku, możemy zmodyfikować $"OPT"$ tak, aby zgadzało się z
$"ALG"$ na $i$-tej pozycji, nie tracąc optymalności ani poprawności. Powtarzając
ten argument dla kolejnych pozycji $j > i$, na których $"ALG"$ i (zmodyfikowane)
$"OPT"$ mogłyby się różnić, możemy krok po kroku przekształcić całe $"OPT"$ w $"ALG"$,
nie zmniejszając liczby odcinków. Oznacza to, że liczba odcinków w $"ALG"$ jest
co najmniej tak duża jak w $"OPT"$, czyli $m >= k$. Ponieważ z definicji $"OPT"$ jest
rozwiązaniem optymalnym, $m <= k$. Łącząc te dwie nierówności, dochodzimy do
wniosku, że $m = k$. Zatem algorytm jest poprawny i zawsze znajduje rozwiązanie
o największej mocy
