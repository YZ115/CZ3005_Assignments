male(jerry).
male(stuart).
male(warren).
male(peter).
female(kather).
female(maryalice).
female(ann)
brother(jerry,stuart).
brother(jerry,kather).
brother(peter, warren).
sister(ann, mayalice).
sister(kather,jerry).
parent_of(warren,jerry).
parent_of(maryalice,jerry).

father(X,Y) :- male(X), parent_of(X,Y).
mother(X,Y) :- female(X), parent_of(X,Y).
son(X,Y) :- male(X), parent_of(Y,X).
daughter(X,Y) :- female(X), parent_of(Y,X).
grandfather(X,Y) :- male(X), parent_of(X,A), parent_of(A,Y).
sibling(X,Y) :- sister(X,Y).
sibling(X,Y) :- sister(Y,X).
sibling(X,Y) :- brother(X,Y).
sibling(X,Y) :- brother(Y,X).
aunt(X,Y) :- female(X), sibling(X,A), parent_of(A,Y).
uncle(X,Y) :- male(X), sibling(X,A), parent_of(A,Y).
cousin(X,Y) :- parent_of(A,X), sibling(A,B), parent_of(B,Y).
spouse(X,Y) :- parent_of(X,A), parent_of(Y,A), X\=Y.
parent(X,Y) :- parent_of(X,A), sibling(A,Y).
parent(X,Y) :- parent_of(X,Y).