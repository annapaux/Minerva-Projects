

% Restaurants and their attributes

pick_restaurant(saigon) :- cuisine(Cuisine), cuisine_type(Cuisine, [vietnamese, vegetarian]), price(Price), price_range(Price, low), distance(Distance), max_distance(Distance,1), rating(Rating), rating_at_least(Rating, 4).

pick_restaurant(fasongsong) :- cuisine(Cuisine), cuisine_type(Cuisine, [korean, vegetarian]), price(Price), price_range(Price, medium), distance(Distance), max_distance(Distance, 1), rating(Rating), rating_at_least(Rating, 4).

pick_restaurant(chori) :- cuisine(Cuisine), cuisine_type(Cuisine, [argentinian]), price(Price), price_range(Price, low), distance(Distance), max_distance(Distance, 5), rating(Rating), rating_at_least(Rating, 3).

pick_restaurant(cafe_ditali) :- cuisine(Cuisine), cuisine_type(Cuisine, [italian, argentinian]), price(Price), price_range(Price, low), distance(Distance), max_distance(Distance, 1), rating(Rating), rating_at_least(Rating, 1).

pick_restaurant(hong_kong_style) :- cuisine(Cuisine), cuisine_type(Cuisine, [chinese]), price(Price), price_range(Price, medium), distance(Distance), max_distance(Distance, 9), rating(Rating), rating_at_least(Rating, 2).

pick_restaurant(cabaña) :- cuisine(Cuisine), cuisine_type(Cuisine, [argentinian]), price(Price), price_range(Price, high), distance(Distance), max_distance(Distance, 2), rating(Rating), rating_at_least(Rating, 4).

pick_restaurant(empanairo) :- cuisine(Cuisine), cuisine_type(Cuisine, [argentinian]), price(Price), price_range(Price, low), distance(Distance), max_distance(Distance, 1), rating(Rating), rating_at_least(Rating, 3).

pick_restaurant(artemisia) :- cuisine(Cuisine), cuisine_type(Cuisine, [european, vegan]), price(Price), price_range(Price, medium), distance(Distance), max_distance(Distance, 6), rating(Rating), rating_at_least(Rating, 3).

pick_restaurant(mcdonalds) :- cuisine(Cuisine), cuisine_type(Cuisine, [fastfood]), price(Price), price_range(Price, low), distance(Distance), max_distance(Distance, 1), rating(Rating), rating_at_least(Rating, 1).

pick_restaurant(biwon) :- cuisine(Cuisine), cuisine_type(Cuisine, [korean]), price(Price), price_range(Price, medium), distance(Distance), max_distance(Distance, 2), rating(Rating), rating_at_least(Rating, 2).

pick_restaurant(burger_king) :- cuisine(Cuisine), cuisine_type(Cuisine, [fastfood]), price(Price), price_range(Price, low), distance(Distance), max_distance(Distance, 3), rating(Rating), rating_at_least(Rating, 1).

pick_restaurant(la_parolaccia_trattoria) :- cuisine(Cuisine), cuisine_type(Cuisine, [italian]), price(Price), price_range(Price, high), distance(Distance), max_distance(Distance, 2), rating(Rating), rating_at_least(Rating, 3).

pick_restaurant(baifu) :- cuisine(Cuisine), cuisine_type(Cuisine, [chinese]), price(Price), price_range(Price, medium), distance(Distance), max_distance(Distance, 6), rating(Rating), rating_at_least(Rating, 1).

pick_restaurant(loving_hut) :- cuisine(Cuisine), cuisine_type(Cuisine, [vegan]), price(Price), price_range(Price, medium), distance(Distance), max_distance(Distance, 5), rating(Rating), rating_at_least(Rating, 3).


% Rules

cuisine_type([Xh|Xt], Y) :- member(Xh,Y); cuisine_type(Xt, Y).
price_range(X, Y) :- X == Y.
max_distance(X, Y) :- Y =< X.
rating_at_least(X, Y) :- X =< Y.

