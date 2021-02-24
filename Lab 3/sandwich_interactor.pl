/*Define all possible options for each category*/
meals([healthy,vegan,veggie,value,normal]).
breads([wheat,honey_oat,italian,monterey_cheddar,parmesan_oregano,flatbread]).
meats([turkey,ham,beef,tuna,bacon,meatballs,pepperoni]).
salads([ham,italian_BMT,chicken_teriyaki,beef,egg_mayo,roast_beef,veggie,tomato]).
veggie_salads([egg_mayo,veggie,tomato]).
vegan_salads([veggie,tomato]).
healthy_sauces([chiptole,ranch,barbeque]).
sauces([chipotle,honey_mustard,mayonnaise,mustard,ranch,barbeque]).
cheeses([cheddar,parmesan,swiss,american,mozzarella]).
veggies([spinach,lettuce,bell_pepper,cucumber,olive,pickle,onion,tomato]).
sides([chips,cookies]).
drinks([coke,sprite,lemonade,water,fruit_tea]).

/*Create dynamic predicates for user choice*/
:- dynamic meal_choice/1,bread_choice/1,meat_choice/1,salad_choice/1,sauce_choice/1,cheese_choice/1,
    veggie_choice/1,side_choice/1,drink_choice/1.

/*begin_order is the main function to be executed, prompts user for a meal choice,gets the meal choice
 from the dynamic predicates, and decides which prompts to include/exclude.
 
 Rules are as follows: 
 Healthy meals do not have cheese or side options and only offers healthy sause options.
 Vegan meals do not have meat or cheese options and only offers vegan salads.
 Veggie meals do not have meat options and only offers veggie salads.
 Value meals do not have side options.
 Normal meals includes all available options.*/
begin_order:-write('welcome to Sandwich Maker 101'),nl,nl,prompt_meal,get_meal_choice(Meal_Choice),
    ((Meal_Choice==healthy->
    	prompt_bread,prompt_meat,prompt_salad,prompt_hSauce,prompt_veggie,prompt_drink);
    (Meal_Choice==vegan-> /*need to change stuff*/
    	prompt_bread,prompt_veganS,prompt_sauce,prompt_veggie,prompt_side,prompt_drink);
    (Meal_Choice==veggie->
    	prompt_bread,prompt_veggieS,prompt_sauce,prompt_cheese,prompt_veggie,prompt_side,prompt_drink);
    (Meal_Choice==value->
    	prompt_bread,prompt_meat,prompt_salad,prompt_sauce,prompt_cheese,prompt_veggie,prompt_drink);
    (Meal_Choice==normal->
    	prompt_bread,prompt_meat,prompt_salad,prompt_sauce,prompt_cheese,prompt_veggie,prompt_side,prompt_drink)),
    display_order,ins_break,nl,write('Thank you for coming, hope to see you again soon!'),
    clear_dynamics,true.

/*prompt functions will display available options for each section. It will then call assert_nonIter or
 assert_input functions (depending if there can be multiple options or not) to prompt and check the
 user input.*/
prompt_meal:-write('Please choose your meal: '),guide,nl,ins_break,nl,
    get_meals(Meals),display_list(Meals),ins_break,nl,assert_nonIter(meal),nl.
prompt_bread:-write('Please choose your bread: '),guide,nl,ins_break,nl,get_breads(Breads),
    display_list(Breads),ins_break,nl,assert_nonIter(bread),nl.
prompt_meat:-write('Please choose your meat (Enter 0 to conclude meats): '),guide,nl,ins_break,nl,get_meats(Meats),
    display_list(Meats),ins_break,nl,assert_input(meat),nl.
prompt_salad:-write('Please choose your salad (Enter 0 to conclude salads): '),guide,nl,ins_break,nl,get_salads(Salads),
    display_list(Salads),ins_break,nl,assert_input(salad),nl.
prompt_veggieS:-write('Please choose your salad (Enter 0 to conclude salads): '),guide,nl,ins_break,nl,get_veggieS(VeggieS),
    display_list(VeggieS),ins_break,nl,assert_input(veggieS),nl.
prompt_veganS:-write('Please choose your salad (Enter 0 to conclude salads): '),guide,nl,ins_break,nl,get_veganS(VeganS),
    display_list(VeganS),ins_break,nl,assert_input(veganS),nl.
prompt_sauce:-write('Please choose your sauce (Enter 0 to conclude sauces): '),guide,nl,ins_break,nl,get_sauces(Sauces),
    display_list(Sauces),ins_break,nl,assert_input(sauce),nl.
prompt_hSauce:-write('Please choose your sauce (Enter 0 to conclude sauces): '),guide,nl,ins_break,nl,get_hSauces(H_Sauces),
    display_list(H_Sauces),ins_break,nl,assert_input(hSauce),nl.
prompt_cheese:-write('Please choose your cheese (Enter 0 to conclude cheeses): '),guide,nl,ins_break,nl,get_cheeses(Cheeses),
    display_list(Cheeses),ins_break,nl,assert_input(cheese),nl.
prompt_veggie:-write('Please choose your veggie (Enter 0 to conclude veggies): '),guide,nl,ins_break,nl,get_veggies(Veggies),
    display_list(Veggies),ins_break,nl,assert_input(veggie),nl.
prompt_side:-write('Please choose your side (Enter 0 to conclude sides): '),guide,nl,ins_break,nl,get_sides(Sides),
    display_list(Sides),ins_break,nl,assert_input(side),nl.
prompt_drink:-write('Please choose your drink (Enter 0 to conclude drinks): '),guide,nl,ins_break,nl,get_drinks(Drinks),
    display_list(Drinks),ins_break,nl,assert_input(drink).

/*Makes the terminal look cleaner*/
ins_break:-write('-------------------------').

/*Displays elements in a list line by line by recursively removing and printing the first element of
 the given list.*/
display_list(X):- X=[A|B], write(A),nl,display_list(B).
display_list([]).

/*Shortcut to displaying the user's input.*/
display_choice(X):-write('You have chosen: '),write(X).

/*Gets all user inputs from dynamic predicates and display them in a presentable format.
 findall/3 is used to find all elements of a dynamic predicate and store them in list.
 atomic_list_concat is used to make each list look cleaner (gets rid of brackets).*/
display_order:-
    findall(X,meal_choice(X),Meal),
    findall(X,bread_choice(X),Bread),
    findall(X,meat_choice(X),Meat),
    findall(X,salad_choice(X),Salad),
    findall(X,sauce_choice(X),Sauce),
    findall(X,cheese_choice(X),Cheese),
    findall(X,veggie_choice(X),Veggie),
    findall(X,side_choice(X),Side),
    findall(X,drink_choice(X),Drink),
    write('Your order is as follows: '),nl,ins_break,nl,
    atomic_list_concat(Meal,Meals),
    write('Meal: '),write(Meals),nl,
    atomic_list_concat(Bread,Breads),
    write('Bread: '),write(Breads),nl,
    atomic_list_concat(Meat,', ',Meats),
    write('Meat(s): '),write(Meats),nl,
    atomic_list_concat(Salad,', ',Salads),
    write('Salad(s): '),write(Salads),nl,
    atomic_list_concat(Sauce,', ',Sauces),
    write('Sauce(s): '),write(Sauces),nl,
    atomic_list_concat(Cheese,', ',Cheeses),
    write('Cheese(s): '),write(Cheeses),nl,
    atomic_list_concat(Veggie,', ',Veggies),
    write('Veggie(s): '),write(Veggies),nl,
    atomic_list_concat(Side,', ',Sides),
    write('Side(s): '),write(Sides),nl,
    atomic_list_concat(Drink,', ',Drinks),
    write('Drink(s): '),write(Drinks),nl.

/*get all elements in predicate lists instantiated above.*/
get_meals(X):-findall(Y,meals(Y),Z),Z=[X|_].
get_breads(X):-findall(Y,breads(Y),Z),Z=[X|_].
get_meats(X):-findall(Y,meats(Y),Z),Z=[X|_].
get_salads(X):-findall(Y,salads(Y),Z),Z=[X|_].
get_veggieS(X):-findall(Y,veggie_salads(Y),Z),Z=[X|_].
get_veganS(X):-findall(Y,vegan_salads(Y),Z),Z=[X|_].
get_sauces(X):-findall(Y,sauces(Y),Z),Z=[X|_].
get_hSauces(X):-findall(Y,healthy_sauces(Y),Z),Z=[X|_].
get_cheeses(X):-findall(Y,cheeses(Y),Z),Z=[X|_].
get_veggies(X):-findall(Y,veggies(Y),Z),Z=[X|_].
get_sides(X):-findall(Y,sides(Y),Z),Z=[X|_].
get_drinks(X):-findall(Y,drinks(Y),Z),Z=[X|_].

/*Checks if an input matches an element in each list.
 * member/2 checks if X is an element of List.*/
valid_meal(X):- get_meals(List),member(X,List),!.
valid_bread(X):- get_breads(List),member(X,List),!.
valid_meat(X):- get_meats(List),member(X,List),!.
valid_salad(X):- get_salads(List),member(X,List),!.
valid_veggieS(X):- get_veggieS(List),member(X,List),!.
valid_veganS(X):- get_veganS(List),member(X,List),!.
valid_sauce(X):- get_sauces(List),member(X,List),!.
valid_hSauce(X):- get_hSauces(List),member(X,List),!.
valid_cheese(X):- get_cheeses(List),member(X,List),!.
valid_veggie(X):- get_veggies(List),member(X,List),!.
valid_side(X):- get_sides(List),member(X,List),!.
valid_drink(X):- get_drinks(List),member(X,List),!.

/*Guiding message for users, displayed at each prompt.*/
guide:-nl,write('Please enter your choices in lowercase only.').

/*Gets the meal choice of the user from the meal_choice dynamic predicate.*/
get_meal_choice(Meal_Choice):- findall(X,meal_choice(X),Meal),Meal=[Meal_Choice|_].

/*Checks if an user input is valid for fields that only allow one choice (meal and bread type).
 parameter 'Type' indicates which category the function should check for.
 If both the input and type is validated, function will display the user's input and add it to the
 corresponding dynamic list.
 If the input is invalid, function will display an error message and user will be prompted again.
 Once a valid input is processed, function will return true.
 assert/1 adds Input into a dynamic list.*/
assert_nonIter(Type):- read(Input),
    ((Type==meal,valid_meal(Input) -> display_choice(Input),
         nl, assert(meal_choice(Input)));
    (Type==bread,valid_bread(Input) -> display_choice(Input),
         nl, assert(bread_choice(Input)));
    write('Invalid input, please try again (options are case sensitive)'), nl,assert_nonIter(Type));
    nl,true.

/*Checks if an user input is valid for fields that only allow multiple choices 
 (meats, salads, veggies, sauces, cheeses, sides, and drinks).
 parameter 'Type' indicates which category the function should check for.
 If both the input and type is validated, function will display the user's input and add it to the
 corresponding dynamic list.
 If the input is invalid, function will display an error message and user will be prompted again.
 Function will continue prompting the user for an input until a '0' is entered, in which case
 the function will return true.*/
assert_input(Type):- read(Input),
    (not(Input==0)->  
    ((Type==meat,valid_meat(Input) -> display_choice(Input),
         nl, assert(meat_choice(Input)));
    (Type==salad,valid_salad(Input) -> display_choice(Input), 
    	nl, assert(salad_choice(Input)));
    (Type==veggieS,valid_veggieS(Input) -> display_choice(Input), 
    	nl, assert(salad_choice(Input)));
    (Type==veganS,valid_veganS(Input) -> display_choice(Input), 
    	nl, assert(salad_choice(Input)));
    (Type==sauce,valid_sauce(Input) -> display_choice(Input), 
    	nl, assert(sauce_choice(Input)));
    (Type==hSauce,valid_hSauce(Input) -> display_choice(Input), 
    	nl, assert(sauce_choice(Input)));
    (Type==cheese,valid_cheese(Input) -> display_choice(Input), 
    	nl, assert(cheese_choice(Input)));
    (Type==veggie,valid_veggie(Input) -> display_choice(Input), 
    	nl, assert(veggie_choice(Input)));
    (Type==side,valid_side(Input) -> display_choice(Input), 
    	nl, assert(side_choice(Input)));
    (Type==drink,valid_drink(Input) -> display_choice(Input), 
    	nl, assert(drink_choice(Input)));
    nl, write('Invalid input, please try again (options are case sensitive)'), nl),
    assert_input(Type);
    nl,true).

/*Flush out all elements in dynamic predicates so the data will not be carried over to other runs.*/
clear_dynamics:-retractall(meal_choice(_)),retractall(bread_choice(_)),retractall(meat_choice(_)),
    retractall(salad_choice(_)),retractall(sauce_choice(_)),retractall(cheese_choice(_)),
    retractall(veggie_choice(_)),retractall(side_choice(_)),retractall(drink_choice(_)),true.