%-----------------------------------------------------------------------
% MAIN FACTS (FAMILY MIMBERS)
%-----------------------------------------------------------------------
% specific share -- فرض
husband(0).
wife(0).
mother(0).
father(0).
grandfather(0).
grandmother(0).
daughters(0).
daughters_of_son(0).
sisters(0).
sisters_from_father(0).
mothers_children(0).

% innervation -- تعصيب
sons(0).
sons_of_son(0).
% father
brothers(0).
brothers_from_father(0).
sons_of_brother(0).
sons_of_brother_from_father(0).
paternal_uncle(0).
sons_of_paternal_uncle(0).
mo3ta9(0).

%-----------------------------------------------------------------------
% LIST FAMILY
%-----------------------------------------------------------------------
print_husband :-
	husband(X),
	X > 0,
	write('- Husband'), nl.
	
print_wife :-
	wife(X),
	X > 0,
	write('- '), write(X), write(' wife/s'), nl.

print_mother :-
	mother(X),
	X > 0,
	write('- Mother'), nl.

print_father :-
	father(X),
	X > 0,
	write('- Father'), nl.
	
print_grandfather :-
	grandfather(X),
	X > 0,
	write('- '), write(X), write(' grandfather/s'), nl.
	
print_grandmother :-
	grandmother(X),
	X > 0,
	write('- '), write(X), write(' grandmother/s'), nl.
	
print_daughters :-
	daughters(X),
	X > 0,
	write('- '), write(X), write(' daughters/s'), nl.
	
print_daughters_of_son :-
	daughters_of_son(X),
	X > 0,
	write('- '), write(X), write(' daughter/s of son'), nl.
	
print_sisters_from_father :-
	sisters_from_father(X),
	X > 0,
	write('- '), write(X), write(' sister/s from father'), nl.
	
print_mothers_children :-
	mothers_children(X),
	X > 0,
	write('- '), write(X), write(' mother children'), nl.

% --- ---
print_sons :-
	sons(X),
	X > 0,
	write('- '), write(X), write(' son/s'), nl.

print_sons_of_son :-
	sons_of_son(X),
	X > 0,
	write('- '), write(X), write(' son/s of son'), nl.

print_brothers :-
	brothers(X),
	X > 0,
	write('- '), write(X), write(' brother/s'), nl.
	
print_brothers_from_father :-
	brothers_from_father(X),
	X > 0,
	write('- '), write(X), write(' brother/s from father'), nl.
	
print_sons_of_brother :-
	sons_of_brother(X),
	X > 0,
	write('- '), write(X), write(' son/s of brother'), nl.
	
print_sons_of_brother_from_father :-
	sons_of_brother_from_father(X),
	X > 0,
	write('- '), write(X), write(' son/s of brother from father'), nl.

print_paternal_uncle :-
	paternal_uncle(X),
	X > 0,
	write('- '), write(X), write(' paternal uncle/s'), nl.

print_sons_of_paternal_uncle :-
	sons_of_paternal_uncle(X),
	X > 0,
	write('- '), write(X), write(' son/s of paternal uncle'), nl.

print_mo3ta9 :-
	mo3ta9(X),
	X > 0,
	write('- '), write(X), write(' mo3ta9'), nl.		

list_family :-
	print_husband;
	print_wife;
	print_mother;
	print_father;
	print_grandfather;
	print_grandmother;
	print_daughters;
	print_daughters_of_son;
	print_sisters_from_father;
	print_mothers_children;
	% --- ---
	print_sons;
	print_sons_of_son;
	print_brothers;
	print_brothers_from_father;
	print_sons_of_brother;
	print_sons_of_brother_from_father;
	print_paternal_uncle;
	print_sons_of_paternal_uncle;
	print_mo3ta9.


%-----------------------------------------------------------------------
% MAIN RULES
%-----------------------------------------------------------------------
inheritance_branch_exist :- /* وجود فرع وارث */
	sons(A),
	sons_of_son(B),
	daughters(C),
	daughters_of_son(D),
	A+B+C+D > 0.

no_inheritance_branch :-
	sons(A),
	sons_of_son(B),
	daughters(C),
	daughters_of_son(D),
	A+B+C+D =:= 0.

male_inheritor_branch_exist :-
	sons(A),
	sons_of_son(B),
	A+B > 0.

no_male_inheritor_branch :-
	sons(A),
	sons_of_son(B),
	A+B =:= 0.

brothers_or_sisters_exist :-
	brothers(A),
	sisters(B),
	A+B > 0.
	
no_brothers_or_sisters :-
	brothers(A),
	sisters(B),
	A+B > 0.

omars_condition :-
	husband(A),
	wife(B),
	father(C),
	mother(D),
	A+B+C+D > 3.

%-----------------------------------------------------------------------
% SHARES (died_and_left)
%-----------------------------------------------------------------------

%-------------------------------------------------
% الإرث بالفرض
%-------------------------------------------------

%------------------------
% --- --- Husband --- ---
%------------------------
half_for_husband(L) :-
	husband(X),
	X > 0,
	no_inheritance_branch,
	Share is L / 2,
	write('Husband will have the half of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

quarter_for_husband(L) :-
	husband(X),
	X > 0,
	inheritance_branch_exist,
	Share is L / 4,
	write('Husband will have the quarter of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

%---------------------
% --- --- Wife --- --- 
%---------------------
quarter_for_wife(L) :-
	wife(X),
	X > 0,
	no_inheritance_branch,
	Share is L / 4,
	write('Wife/s will have the quarter of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

eighth_for_wife(L) :-
	wife(X),
	X > 0,
	inheritance_branch_exist,
	Share is L / 8,
	write('Wife will have the eighth of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

%-----------------------
% --- --- Mother --- --- 
%-----------------------
thrid_for_mother(L) :-
	mother(X),
	X > 0,
	no_inheritance_branch,
	no_brothers_or_sisters,
	\+ (omars_condition),
	Share is L / 3,
	write('Mother will have the third of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.
	
sixth_for_mother(L) :-
	mother(X),
	X > 0,
	sons(A),
	sons_of_son(B),
	daughters(C),
	daughters_of_son(D),
	brothers(E),
	sisters(F),
	A+B+C+D+E+F > 0,
	Share is L / 6,
	write('Mother will have the sixth of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.
	
thrid_of_the_rest_for_mother :-
	mother(X),
	X > 0,
	no_inheritance_branch,
	no_brothers_or_sisters,
	omars_condition,
	write('Mother will have the third of the rest.').

%-----------------------
% --- --- Father --- --- 
%-----------------------
sixth_for_father(L) :-
	father(X),
	X > 0,
	inheritor_branch_exist,
	Share is L / 6,
	write('Father will have the sixth of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

%----------------------------	
% --- --- Grandfather --- --- 
%----------------------------

nothing_for_grandfather :-
	grandfather(X),
	X > 0,
	father(0),
	write('Grandfather/s will have nothing, because father exist.').

sixth_for_grandfather(L) :-
	grandfather(X),
	X > 0,
	no_male_inheritor_branch,
	father(0),
	Share is L / 6,
	write('Grandfather/s will have the sixth of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

%----------------------------
% --- --- Grandmother --- --- 
%----------------------------
nothing_for_grandmother :-
	grandmother(X),
	X > 0,
	mother(A),
	A > 0,
	write('Grandmother/s will have nothing, because mother is exist.').

sixth_for_grandmother(L) :-
	grandmother(X),
	X > 0,
	mother(A),
	A =:= 0,
	Share is L / 6,
	write('Grandmother/s will have the sixth of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

%-------------------------
% --- --- Daugters --- ---
%-------------------------
half_for_daughter(L) :-
	daughters(X),
	X =:= 1,
	sons(0),
	Share is L / 2,
	write('Daughter will have the half of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

two_thirds_for_daughters(L) :-
	daughters(X),
	X > 1,
	sons(0),
	Share is L * 2 / 3,
	write('Daughters will split the two thirds of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

%---------------------------------
% --- --- Daughters of son --- ---
%---------------------------------

nothing_for_daughters_of_son_because_sons :-
	daughters_of_son(X),
	X > 0,
	sons(A),
	A > 0,
	write('Daughter/s of son will have nothing, because son exist.').

nothing_for_daughters_of_son_because_daughters :-
	daughters_of_son(X),
	X > 0,
	sons(A),
	A =:= 0,
	daughters(B),
	B >= 2,
	write('Daughter/s of son will have nothing, because more than one daughter exist.').
	
half_for_daughters_of_son(L) :-
	daughters_of_son(1),
	sons(0),
	daughters(0),
	Share is L / 2,
	write('Daughter/s of son will have the half of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

two_thirds_for_daughters_of_son(L) :-
	daughters(X),
	X >= 2,
	sons(0),
	daughters(0),
	Share is L * 2 / 3,
	write('Daughters will split the two thirds of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

sixth_for_daughters_of_son(L) :-
	daughters_of_son(X),
	X > 0,
	sons(0),
	daughters(1),
	Share is L / 6,
	write('Daughter/s of son will have the sixth of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

%------------------------
% --- --- Sisters --- ---
%------------------------
nothing_for_sisters :-
	sisters(X),
	X > 0,
	sons(A),
	sons_of_son(B),
	daughters(C),
	father(D),
	grandfather(E),
	brothers(F),
	A+B+C+D+E+F > 0,
	write('Sister/s will have nothing.').

half_for_sister(L) :-
	sisters(X),
	X > 0,
	X < 2,
	no_inheritance_branch,
	father(A),
	grandfather(B),
	brothers(C),
	A+B+C =:= 0,
	Share is L / 2,
	write('Sister will have the half of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

two_thirds_for_sisters(L) :-
	sisters(X),
	X >= 2,
	no_inheritance_branch,
	father(A),
	grandfather(B),
	brothers(C),
	A+B+C =:= 0,
	Share is L * 2 / 3,
	write('Sisters will split the two thirds of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

nothing_for_sisters_from_father_because_male :-
	sisters_from_father(X),
	X > 0,
	sons(A),
	sons_of_son(B),
	daughters(C),
	father(D),
	grandfather(E),
	brothers(F),
	A+B+C+D+E+F > 0,
	write('Sister/s from father will have nothing.').

nothing_for_sisters_from_father_because_sisters :-
	sisters_from_father(X),
	X > 0,
	sons(A),
	sons_of_son(B),
	daughters(C),
	father(D),
	grandfather(E),
	brothers(F),
	A+B+C+D+E+F =:= 0,
	sisters(G),
	G >= 2,
	write('Sister/s from father will have nothing.').
	
half_for_sister_from_father(L) :-
	sisters_from_father(X),
	X > 0,
	X < 2,
	sons(A),
	sons_of_son(B),
	daughters(C),
	father(D),
	grandfather(E),
	brothers(F),
	sisters(G),
	A+B+C+D+E+F+G =:= 0,
	Share is L / 2,
	write('Sister from father will have the half of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

two_thirds_for_sisters_from_father(L) :-
	sisters_from_father(X),
	X >= 2,
	sons(A),
	sons_of_son(B),
	daughters(C),
	father(D),
	grandfather(E),
	brothers(F),
	sisters(G),
	A+B+C+D+E+F+G =:= 0,
	Share is L * 2 / 3,
	write('Sister/s from father will split the two thirds of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

sixth_for_sisters_from_father(L) :-
	sisters_from_father(X),
	X > 0,
	X < 2,
	sons(A),
	sons_of_son(B),
	daughters(C),
	father(D),
	grandfather(E),
	brothers(F),
	sisters(G),
	A+B+C+D+E+F =:= 0,
	G = 1,
	Share is L /6,
	write('Sister/s from father will have the sixth of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.

%---------------------------------
% --- --- Mothers children --- ---
%---------------------------------
nothing_for_mothers_children :-
	mothers_children(X),
	X > 0,
	sons(A),
	daughters(B),
	sons_of_son(C),
	daughters_of_son(D),
	father(E),
	grandfather(F),
	A+B+C+D+E+F > 0,
	write('Mothers children will have nothing.').
	

sixth_for_mothers_children(L) :-
	mothers_children(X),
	X = 1,
	no_inheritance_branch,
	father(A),
	grandfather(B),
	A+B =:= 0,
	Share is L /6,
	write('Mother s children will have the sixth of the legacy: '), format("~2f", [Share]), write(' ponds.'), nl.
	
third_for_mother_children(L) :-
	mothers_children(X),
	X >= 2,
	no_inheritance_branch,
	father(A),
	grandfather(B),
	A+B =:= 0,
	Share is L /3,
	write('Mother s children will split equaly the third of the legacy: '), format("~2f", [Share]), 
	write(' ponds. No difference between male and female.'), nl.	

%-------------------------------------------------
% بالتعصيب الإرث
%-------------------------------------------------

the_rest_for_sons :-
	sons(X),
	X > 0,
	daughters(0),
	write('The rest of the legacy for sons.').

the_rest_for_sons_and_daughters :-
	sons(X),
	daughters(Y),
	X > 0,
	Y > 0,
	write('The rest of the legacy for sons and daughters, the male share like two females.').

the_rest_for_sons_of_son :-
	sons_of_son(X),
	X > 0,
	sons(0),
	daughters(0),
	daughters_of_son(0),
	write('The rest of the legacy for sons of son.').

the_rest_for_sons_and_daughters_of_son :-
	sons_of_son(X),
	daughters_of_son(Y),
	X > 0,
	Y > 0,
	sons(0),
	daughters(0),
	write('The rest of the legacy for sons and daughters of son, the male share like two females.').

the_rest_for_father :-
	father(X),
	X > 0,
	sons(0),
	sons_of_son(0),
	write('The rest of the legacy for the father.').

the_rest_for_grandfather :-
	grandfather(X),
	X > 0,
	sons(0),
	sons_of_son(0),
	father(0),
	write('The rest of the legacy for the grandfather.').

the_rest_for_brothers :-
	brothers(X),
	X > 0,
	sons(0),
	sons_of_son(0),
	daughters_of_son(0),
	father(0),
	grandfather(0),
	write('The rest of the legacy for the brothers.').

the_rest_for_brothers_and_sisters :-
	brothers(X),
	sisters(Y),
	X > 0,
	Y > 0,
	sons(0),
	sons_of_son(0),
	daughters_of_son(0),
	father(0),
	grandfather(0),
	write('The rest of the legacy for the brothers.').

the_rest_for_brothers_from_father :-
	brothers_from_father(X),
	X > 0,
	sons(0),
	sons_of_son(0),
	daughters_of_son(0),
	father(0),
	grandfather(0),
	brothers(0),
	sisters_from_father(0),
	write('The rest of the legacy for the brothers from father.').
	
the_rest_for_brothers_and_sisters_from_father :-
	brothers_from_father(X),
	sisters_from_father(Y),
	X > 0,
	Y > 0,
	sons(0),
	sons_of_son(0),
	daughters_of_son(0),
	father(0),
	grandfather(0),
	brothers(0),
	write('The rest of the legacy for the brothers and sisters from father, the male share like two females.').

the_rest_for_paternal_uncle :-
	paternal_uncle(X),
	X > 0,
	sons(0),
	sons_of_son(0),
	daughters_of_son(0),
	father(0),
	grandfather(0),
	brothers(0),
	brothers_from_father(0),
	write('The rest of the legacy for the paternal uncle.').

the_rest_for_sons_of_paternal_uncle :-
	sons_of_paternal_uncle(X),
	X > 0,
	sons(0),
	sons_of_son(0),
	daughters_of_son(0),
	father(0),
	grandfather(0),
	brothers(0),
	brothers_from_father(0),
	paternal_uncle(0),
	write('The rest of the legacy for the sons of paternal uncle.').

the_rest_for_mo3ta9 :-
	mo3ta9(X),
	X > 0,
	sons(0),
	sons_of_son(0),
	daughters_of_son(0),
	father(0),
	grandfather(0),
	brothers(0),
	brothers_from_father(0),
	paternal_uncle(0),
	sons_of_paternal_uncle(0),
	write('The rest of the legacy for the mo3ta9.').	


died_and_left(Legacy) :-
	half_for_husband(Legacy);
	quarter_for_husband(Legacy);
	quarter_for_wife(Legacy);
	eighth_for_wife(Legacy);
	thrid_for_mother(Legacy);
	sixth_for_mother(Legacy);
	thrid_of_the_rest_for_mother;
	sixth_for_father(Legacy);
	nothing_for_grandfather;
	sixth_for_grandfather(Legacy);
	nothing_for_grandmother;
	sixth_for_grandmother(Legacy);
	half_for_daughter(Legacy);
	two_thirds_for_daughters(Legacy);
	nothing_for_daughters_of_son_because_sons;
	nothing_for_daughters_of_son_because_daughters;
	half_for_daughters_of_son(Legacy);
	two_thirds_for_daughters_of_son(Legacy);
	sixth_for_daughters_of_son(Legacy);
	nothing_for_sisters;
	half_for_sister(Legacy);
	two_thirds_for_sisters(Legacy);
	nothing_for_sisters_from_father_because_male;
	nothing_for_sisters_from_father_because_sisters;
	half_for_sister_from_father(Legacy);
	two_thirds_for_sisters_from_father(Legacy);
	sixth_for_sisters_from_father(Legacy);
	nothing_for_mothers_children;
	sixth_for_mothers_children(Legacy);
	third_for_mother_children(Legacy);
	% --- ---
	the_rest_for_sons;
	the_rest_for_sons_and_daughters;
	the_rest_for_sons_of_son;
	the_rest_for_sons_and_daughters_of_son;
	the_rest_for_father;
	the_rest_for_grandfather;
	the_rest_for_brothers;
	the_rest_for_brothers_and_sisters;
	the_rest_for_brothers_from_father;
	the_rest_for_brothers_and_sisters_from_father;
	the_rest_for_paternal_uncle;
	the_rest_for_sons_of_paternal_uncle;
	the_rest_for_mo3ta9.
	
	
	