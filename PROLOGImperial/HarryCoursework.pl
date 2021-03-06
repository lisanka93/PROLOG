% the students in Hogwarts
student(hp, 'Harry James Potter', gryffindor).
student(hg, 'Hermione Jean Granger', gryffindor).
student(rw, 'Ronald Weasley', gryffindor).
student(ll, 'Luna Lovegood', ravenclaw).
student(cc, 'Cho Chang', ravenclaw).
student(tb, 'Terry Boot', ravenclaw).
student(ha, 'Hannah Abbott', hufflepuff).
student(cd, 'Cedric Diggory', hufflepuff).
student(nt, 'Nymphadora Tonks',hufflepuff).
student(dm, 'Draco Malfoy', slytherin).
student(gg, 'Gregory Goyle', slytherin).
student(vc, 'Vincent Crabbe', slytherin).
%myself
student(lc, 'Lisa Chalaguine', ravenclaw).


%3 - 
enrolled(SID, SCN) :- setof(X, enrolled_opt(SID, X), EnrolledBag), 
		      setof(Y, compCourse(SID,Y), CompBag),
		      append(EnrolledBag, CompBag, AllCourses), member(SCN, AllCourses).

compCourse(SID, SCN) :- student(SID, _ ,_), compCourse(SCN, _, _).

%4
teaches(TN, SCN) :- teacher(TID,TN), compCourse(SCN,_,TID); teacher(TID,TN), optCourse(SCN, _, TID).

%5
taughtBy(SN, TN) :- student(SID, SN, _), enrolled(SID, SCN), teaches(TN,SCN).

%6
takesOption(SN, CN) :- student(SID, SN, _), optCourse(SCN, CN, _), enrolled_opt(SID,SCN).

%7
takesAllOptions(SN, OptCourses) :- setof(CN, takesOption(SN,CN), OptCourses).

%8
translate([],[]).
translate([Head|Tail],[Head1|Tail1]) :- student(Head, Head1,_), translate(Tail,Tail1).

studentsInHouse(House, Students) :- setof(SID, SN^student(SID, SN, House), Students1),
				    translate(Students1,Students).

%9

course(SCN, CN) :- compCourse(SCN, CN ,_); optCourse(SCN, CN,_). 

studentsOnCourse(SCN, CN, StudentsByHouse) :- 
course(SCN, CN), StudentsByHouse = [gryffindor-H1, hufflepuff-H2, ravenclaw-H3, slytherin-H4],  

findall(SN, (student(SID, SN, gryffindor), enrolled(SID, SCN)), H1),  
findall(SN, (student(SID, SN, hufflepuff), enrolled(SID, SCN)), H2),
findall(SN, (student(SID, SN, ravenclaw), enrolled(SID, SCN)), H3),
findall(SN, (student(SID, SN, slytherin), enrolled(SID, SCN)), H4).

%10
sharedCourse(SN1, SN2, CN) :- (takesOption(SN1,CN), takesOption(SN2,CN)), (SN1 \= SN2).

%11
sameOptions(SN1,SN2,Courses) :- (length(Courses, 3)), setof(CN, sharedCourse(SN1, SN2, CN),Courses).



%enrolled harry
enrolled_opt(hp, creatures).
enrolled_opt(hp, div).
enrolled_opt(hp, quid).
%enrolles hermoine
enrolled_opt(hg, app).
enrolled_opt(hg, div).
enrolled_opt(hg, creatures).
enrolled_opt(hg, muggle).
enrolled_opt(hg, arith).
enrolled_opt(hg, runes).
%enrolled ron
enrolled_opt(rw, creatures).
enrolled_opt(rw, app).
enrolled_opt(rw, div).
%enrolled luna
enrolled_opt(ll, creatures).
enrolled_opt(ll, div).
enrolled_opt(ll, runes).
%enrolled cho
enrolled_opt(cc, quid).
enrolled_opt(cc, arith).
enrolled_opt(cc, choir).
%enrolled terry
enrolled_opt(tb, choir).
enrolled_opt(tb, creatures).
enrolled_opt(tb, muggle).
%enrolled hannah
enrolled_opt(ha, div).
enrolled_opt(ha, runes).
enrolled_opt(ha, creatures).
%enrolled cedric
enrolled_opt(cd, quid).
enrolled_opt(cd, app).
enrolled_opt(cd, creatures).
%enrolled tonks
enrolled_opt(nt, app).
enrolled_opt(nt, div).
enrolled_opt(nt, runes).
%enrolled draco
enrolled_opt(dm, creatures).
enrolled_opt(dm, quid).
enrolled_opt(dm, app).
%enrolled goyle
enrolled_opt(gg, app).
enrolled_opt(gg, div).
enrolled_opt(gg, creatures).
%enrolled crabbe
enrolled_opt(vc, app).
enrolled_opt(vc, creatures).
enrolled_opt(vc, div).
%enrolled me
enrolled_opt(lc, creatures).
enrolled_opt(lc, quid).
enrolled_opt(lc, arith).



% the teachers in Hogwarts
teacher(ad, 'Albus Percival Wulfric Brian Dumbledore').
teacher(ff, 'Filius Flitwick').
teacher(rh, 'Rubeus Hagrid').
teacher(gl, 'Gilderoy Lockhart').
teacher(rl, 'Remus John Lupin').
teacher(mm, 'Minerva McGonagall').
teacher(qq, 'Quirinus Quirrell').
teacher(ss, 'Severus Snape').
teacher(ps, 'Pomona Sprout').
teacher(st, 'Sibyll Patricia Trelawney').
teacher(mh, 'Madam Hooch').
teacher(as, 'Aurora Sinistra').
teacher(cub, 'Cuthbert Binns').
teacher(bb, 'Bathsheba Babbling').
teacher(sv, 'Septima Vector').
teacher(chb, 'Charity Burbage').
teacher(wt, 'Wilkie Twycross').

% compulsory courses for the MSc in Magic
compCourse(astro, 'Astronomy', as).
compCourse(charms, 'Charms', ff).
compCourse(defence, 'Defence against the Dark Arts', qq).
compCourse(fly, 'Flying', mh).
compCourse(herb, 'Herbology', ps).
compCourse(history, 'History of Magic', cub).
compCourse(potions, 'Potions', ss).
compCourse(trans, 'Transfiguration', mm).



% optional courses for the MSc in Magic
optCourse(runes, 'Study of Ancient Runes', bb).
optCourse(arith, 'Arithmancy', sv).
optCourse(muggle, 'Muggle Studies', chb).
optCourse(creatures, 'Care of Magical Creatures', rh).
optCourse(div, 'Divination', st).
optCourse(app, 'Apparition', wt).
optCourse(choir, 'Frog Choir', ff).
optCourse(quid, 'Quidditch', mh).


