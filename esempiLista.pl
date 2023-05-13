find(cons(E,_), E). %Lo cerco nella testa
find(cons(_,T), E) :- find(T, E). %Itero fino ad arrivare alla coda

position(position(E,_), zero, E).
position(cons(_,T), s(N), E) :- position(T, N, E).

concat(nil, L, L).
concat(cons(H, T), L, cons(H, O)) :- concat(T, L, O)