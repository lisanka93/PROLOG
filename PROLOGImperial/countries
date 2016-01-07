%Country(Country,Capital,Inhabitants_in_millions,Area_in_square_kilometers)
country('Sweden','Stockholm',9.3,449964).
country('Denmark','Copenhagen',5.5,43094).
country('Norway','Oslo',4.8,385199).
country('Finland','Helsinki',5.3,338145).
country('Iceland','Reykjavik',0.32,103125).
country('GreatBritain','London',60.6,244820).
country('Turkey','Ankara',71.5,783562).
country('Russia','Moscow',143.5, 17100000).

%Nordic_country(Country)
nordic_country('Sweden').
nordic_country('Norway').
nordic_country('Denmark').
nordic_country('Finland').
nordic_country('Iceland').

%National_day(Country,date(Day,Month))
national_day('Sweden',date(6,'June')).
national_day('Norge',date(17,'May')).
national_day('Finland',date(6,'December')).
national_day('Turkey',date(29,'October')).
national_day('Denmark',date(5,'June')).
national_day('GreatBritain',date(11,'June')).
national_day('Iceland',date(17,'June')).
national_day('Russia',date(12,'June')).

%Form_of_government(Country,Form)
form_of_government('Sweden',monarchy).
form_of_government('Norway',monarchy).
form_of_government('Finland',republic).
form_of_government('Denmark',monarchy).
form_of_government('GreatBritain',monarchy).
form_of_government('Iceland',republic).
form_of_government('Turkey',republic).
form_of_government('Russia', putin).

%Queen(Country,Name)
queen('Denmark','MargretheII').
queen('GreatBritain','ElisabethII').

%King(Country,Name)
king('Sweden','KarlXVIGustav').
king('Norway','HaraldV').
king('Russia', 'Vladimir').


%Flag(Country,Colour_list)
flag('Sweden',[blue,yellow]).
flag('Norway',[red,blue,white]).
flag('Finland',[blue,white]).
flag('Denmark',[red,white]).
flag('GreatBritain',[blue,white,red]).
flag('Russia',[white,blue,red]).


%Exercises:
%should return a list of countries (or country) with populations larger than 100 million
large_countries(C) :- findall(Country, (country(Country,_,Pop,_), Pop>100),C).

%should return a list of nordic countries with republic governments
republic_governments(C) :- findall(Country, (form_of_government(Country, republic),nordic_country(Country)), C).

%returns list of countries that have national holidays in june
national_days_june(C) :- findall(Country, D^national_day(Country,date(_,'June')), C).

%returns list of monarch(Name,Country) objects
monarchs(Monarchs) :- findall((Name,Country), monarch(Name,Country), Monarchs).

monarch(Name, Country) :- king(Country,Name);
			  queen(Country,Name).

%returns a list of all countries with a given colour in their flag
colour(Country,L) :- flag(Country,L).

colour_in_flag(Colour,Countries) :-  findall(Country, (colour(Country, L), member(Colour,L)), Countries).


%computes inhabitants per square kilometer for all countries in the form of L = [population_density(Sweden,20.66), population_density(Denmark,127.62) etc.
count_pop_density(List) :- findall(population_density(Country,Number), population_density(population_density(Country,Number)), List).

%helper
population_density(population_density(Country,Number)) :- country(Country,_,Mil,Area), Number is Mil*1000000 / Area.


%government_types returns a list of counties segregated by govenemnt type

government_types(Return) :- Return = [monarchy-H1, republic-H2, putin-H3],
			    findall(Country, form_of_government(Country,monarchy), H1),
			    findall(Country, form_of_government(Country,republic), H2),
			    findall(Country, form_of_government(Country,putin), H3).


%national_infos returns lists of countries info segregated by govenment type


national_info(Country,CapitalCity,GovernmentType) :-
	country(Country,CapitalCity,_,_),
        form_of_government(Country,GovernmentType),
	governmenttype(GovernmentType).

governmenttype(putin).
governmenttype(monarchy).
governmenttype(republic).

national_infos(List) :- setof(G, governmenttype(G), Blubb),
			member(G,Blubb),
			findall((Country,CapitalCity,G), national_info(Country,CapitalCity,G), Bag),
			List = G-Bag.

