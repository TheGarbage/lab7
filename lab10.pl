% search (Elem , List )
search(X, cons(X, _)).
search(X, cons(_, Xs)) :- search(X, Xs).

% search2 (Elem , List )
% looks for two consecutive occurrences of Elem
search2(X, cons(X, cons(X, _))).
search2(X, cons(_, Xs)) :- search2(X, Xs).

% search_two (Elem , List )
% looks for two occurrences of Elem with any element in between
search_two(X, cons(X, cons(_, cons(X, _)))).
search_two(X, cons(_, Xs)) :- search_two(X, Xs).

% search_anytwo (Elem , List )
% looks for any Elem that occurs two times , anywhere
search_anytwo(X, cons(X, Xs)) :- search(X, Xs).
search_anytwo(X, cons(_, Xs)) :- search_anytwo(X, Xs).

% size (List , Size )
% Size will contain the number of elements in List, 
	%written using notation zero , s( zero ), s(s( zero ))..
size(nil, zero).
size(cons(_, Xs), s(N)) :- size(Xs, N).

% sum_list (List , Sum )
sum(X, zero, X).
sum(X, s(Y), s(Z)) :- sum(X, Y, Z).
sum_list(nil, zero).
sum_list(cons(X, Xs), O) :- sum(S, X, O), sum_list(Xs, S).

% count (List , Element , NOccurrences )
% it uses count (List , Element , NOccurrencesSoFar , NOccurrences )
count(List, E, N) :- count(List, E, zero, N).
count(nil, E, N, N).
count(cons(E, L), E, N, M) :- count(L, E, s(N), M).
count(cons(E, L), E2, N, M) :- E \= E2, count(L, E, N, M).

% max(List , Max )
% Max is the biggest element in List
% Suppose the list has at least one element
greater(s(N), zero).
greater(s(N), s(M)) :- greater(N, M).
max(cons(X, Xs), Max) :- max(Xs, X, Max).
max(nil, Max, Max).
max(cons(X, Xs), MaxTemp, Max) :- greater(X, MaxTemp), max(Xs, X, Max).
max(cons(X, Xs), MaxTemp, Max) :- max(Xs, MaxTemp, Max).

% min - max (List ,Min , Max )
% Min is the smallest element in List
% Max is the biggest element in List
% Suppose the list has at least one element
max-min(cons(X, Xs), Min, Max) :- max-min(Xs, X, Min, X, Max).
max-min(nil, Min, Min, Max, Max).
max-min(cons(X, Xs), MinTemp, Min, MaxTemp, Max) :- greater(X, MaxTemp), max-min(Xs, MinTemp, Min, X, Max).
max-min(cons(X, Xs), MinTemp, Min, MaxTemp, Max) :- greater(MinTemp, X), max-min(Xs, X, Min, MaxTemp, Max).
max-min(cons(X, Xs), MinTemp, Min, MaxTemp, Max) :- greater(MaxTemp, X), greater(X, MinTemp), max-min(Xs, MinTemp, Min, MaxTemp, Max).

% same (List1 , List2 )
% are the two lists exactly the same ?
same(nil, nil).
same(cons(X, Xs), cons(X, Xs)) :- same(Xs, Xs).

% all_bigger (List1 , List2 )
% all elements in List1 are bigger than those in List2 , 1 by 1
all_bigger(nil, nil).
all_bigger(cons(X, Xs), cons(Y, Ys)) :- greater(X, Y), same(Xs, Ys).

% sublist (List1 , List2 )
% List1 should contain elements all also in List2
sublist(N, nil).
sublist(cons(X, Xs), M) :- sublist(Xs, M).
sublist(cons(X, Xs), cons(X, Xs)) :- sublist(Xs, Xs).

% seq(N,E, List ) -> List is [E,E ,... ,E] with size N
% example : seq (s(s(s( zero ))), a, cons (a, cons (a, cons (a,nil )))).
seq(zero , _ , nil).
seq(s(N) , E, cons(E, T)) :- seq(N, E, T).

% seqR (N, List )
seqR(zero, nil).
seqR(s(N), cons(N, Ns)) :- seqR(N, Ns).

% seqR2 (N, List ) -> is [0 ,1 ,... ,N -1]
seqR2(N, List) :- seqR2(s(zero), N, List).
seqR2(s(N), s(N), cons(N, nil)).
seqR2(s(N), s(X), cons(N, Ns)) :- seqR2(s(s(N)), s(X), Ns).

%Last -> return the last element of a list
last(cons(N, nil), N).
last(cons(X, Xs), N) :- last(Xs, N).
%last(cons(s(zero), cons(zero, nil)), zero).
%last(cons(s(zero), cons(s(zero), nil)), N).

%map(_+N) -> return a new list in wich every item is summed with N
map_sumN(nil, N, nil).
map_sumN(cons(X, Xs), N, cons(Y, Ys)) :- sum(X, N, Y), map_sumN(Xs, N, Ys).
%map_sumN(cons(zero, nil), s(zero), cons(s(zero), nil)).
%map_sumN(cons(s(zero), cons(zero, nil)), s(zero), cons(s(s(zero)), cons(s(zero), nil))).
%map_sumN(cons(s(zero), cons(zero, cons(s(s(zero)), nil))), s(s(s(zero))), Q).

%filter(_>N) -> return a new list with only the items greater than N
filter_greaterThanN(nil, N, nil).
filter_greaterThanN(cons(X, Xs), N, Ys) :- greater(N, X), filter_greaterThanN(Xs, N, Ys).
filter_greaterThanN(cons(N, Xs), N, Ys) :- filter_greaterThanN(Xs, N, Ys).
filter_greaterThanN(cons(X, Xs), N, cons(X, Ys)) :- greater(X, N), filter_greaterThanN(Xs, N, Ys).
%filter_greaterThanN(cons(zero, nil), zero, nil).
%filter_greaterThanN(cons(s(zero), cons(s(s(zero)), nil)), s(zero), cons(s(s(zero)), nil)).
%filter_greaterThanN(cons(s(s(s(zero))),cons(s(zero),cons(s(s(zero)),nil))), s(zero), Q).

%count(_>N) -> return the number of items in the list greater than N
count_greaterThanN(List, N, C) :- count_greaterThanN(List, N, zero, C).
count_greaterThanN(nil, N, C, C).
count_greaterThanN(cons(X, Xs), N, CTemp, C) :- greater(X, N), count_greaterThanN(Xs, N, s(CTemp), C).
count_greaterThanN(cons(N, Xs), N, CTemp, C) :- count_greaterThanN(Xs, N, CTemp, C).
count_greaterThanN(cons(X, Xs), N, CTemp, C) :- greater(N, X), count_greaterThanN(Xs, N, CTemp, C).
%count_greaterThanN(cons(zero, nil), zero, zero).
%count_greaterThanN(cons(s(zero), cons(s(s(zero)), nil)), s(zero), s(zero)).
%count_greaterThanN(cons(s(s(s(zero))),cons(s(zero),cons(s(s(zero)),nil))), s(zero), Q).

%dropRight(N) -> return a new list with all the elements of the list except the last N elements
dropRight(nil, zero, nil).
dropRight(cons(X, Xs), N, cons(X, Ys)) :- dropRight(Xs, N, Ys).
dropRight(cons(X, Xs), s(N), nil) :- dropRight(Xs, N, nil).
%dropRight(cons(zero, nil), s(zero), nil).
%dropRight(cons(s(zero), cons(s(zero), cons(zero, nil))), s(s(zero)), cons(s(zero), nil)).
%dropRight(cons(s(zero), cons(s(zero), cons(zero, cons(zero, nil)))), s(zero), Q).

%reverse_ -> return the reverse of the list
reverse_(List, ListReverse) :- reverse_(List, nil, ListReverse).
reverse_(nil, ListReverse, ListReverse).
reverse_(cons(X, Xs), ListReverseTemp, ListReverse) :- reverse_(Xs, cons(X, ListReverseTemp), ListReverse).
%reverse_(cons(s(zero), cons(zero, nil)), cons(zero, cons(s(zero), nil))).
%reverse_(cons(zero, nil), cons(zero, nil)).
%reverse_(cons(s(zero), cons(s(zero), cons(zero, cons(zero, nil)))), s(zero), Q).
