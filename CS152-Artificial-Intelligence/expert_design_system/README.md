# Expert Design System

Simply run the jupyter notebook for best user experience.

The following expert system lets users specify food preferences, such as cuisine, price and proximity, and gives a recommendation of restaurants that fulfill the preferences. The knowledge base
contains restaurants and their attributes, as well as the rules that determine for example that a
price can be either equal to or lower than the user specified. The user is asked for input one by
one, and dynamically checks whether there are restaurants fulfilling the requirements. Given the
user choices, it uses Prolog (PySwip library) to query the knowledge base and return the restaurants.
