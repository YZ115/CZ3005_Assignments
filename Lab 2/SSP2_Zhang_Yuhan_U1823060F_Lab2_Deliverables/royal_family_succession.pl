queen(elizabeth).
prince(charles).
prince(andrew).
prince(edward).
princess(ann).

offspring_of(charles,elizabeth).
offspring_of(andrew,elizabeth).
offspring_of(edward,elizabeth).
offspring_of(ann,elizabeth).

older_than(charles,ann).
older_than(ann,andrew).
older_than(andrew,edward).

is_older(X,Y) :- older_than(X,Y);(older_than(X,_),older_than(_,Y)).

/*Old Succession order*/
/*Gender has higher priority than age for order of succession, thus Princes have priority over princesses.*/
/*precedes function makes sure that the princes have higher priority before checking age.*/

precedes_old(X,Y) :- prince(X),prince(Y),is_older(X,Y);
    prince(X),princess(Y);
    princess(X),princess(Y),is_older(X,Y).

insert_old(A, [B|C], [B|D]):- (precedes_old(B, A)), !, insert_old(A, C, D).
insert_old(A, C, [A|C]).

succession_order_old([A|B], Sorted_List):- succession_order_old(B, Partial_order), 
    insert_old(A, Partial_order, Sorted_List).
succession_order_old([], []).

succession_list_old(Queen, Succession_line):- 
    findall(Y, offspring_of(Y, Queen),Offspring_list), 
    succession_order_old(Offspring_list, Succession_line).

/*New succession order*/
/*Gender is does not affect priority of succession, thus age is the only determining factor.*/
/*precedes function now only takes age into account.*/

precedes_new(X,Y) :- prince(X),prince(Y),is_older(X,Y);
    prince(X),princess(Y),is_older(X,Y);
    princess(X),prince(Y),is_older(X,Y);
    princess(X),princess(Y),is_older(X,Y).

insert_new(A, [B|C], [B|D]):- (precedes_new(B, A)), !, insert_new(A, C, D).
insert_new(A, C, [A|C]).

succession_order_new([A|B], Sorted_List):- succession_order_new(B, Partial_order), 
    insert_new(A, Partial_order, Sorted_List).
succession_order_new([], []).

succession_list_new(Queen, Succession_line):- 
    findall(Y, offspring_of(Y, Queen),Offspring_list), 
    succession_order_new(Offspring_list, Succession_line).