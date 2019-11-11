/*Generate random position for enemy */
 :-dynamic(enemy_appear/1).
 
name(gaara,1). 
name(sakura,2).
name(sasuke,3).
name(lee,4).
name(neji,5).
name(choji,6).
name(shikamaru,7).
name(tenten,8).
name(kiba,9).
name(shino,10).
name(deidara,11).
name(itachi,12).
name(tobi,13).
name(sasori,14).

/*Generate posisi*/
generate_Random_Location(OldX,OldY):-
    random(1,11,X),
    random(1,11,Y),
    retract(enemyLoc(OldX,OldY)),
    asserta(enemyLoc(X,Y)).

/*Generate karakter sesuai posisi*/
generate_Random_Normal_Enemy(Name_Enemy):-
    random(1,11,Number),
    name(Name_Enemy,Number).

/*Generate karakter sesuai posisi*/
generate_Random_Akatsuki_Enemy(Name_Enemy):-
    random(11,15,Number),
    name(Name_Enemy,Number).

/*untuk muncul hanya di 1 titik*/
enemy_appear([]).

/*Mengecek ada komponen Y atau g*/
check([],Y):-!.
check(List,Y):- 
    List=[Head|Tail], 
    !, 
    check(Tail,Y), 
    Head\==Y.     

/**/
check_Normal_Enemy(List,Name_Enemy):-
    repeat,
    generate_Random_Normal_Enemy(Name_Enemy),
    check(List,Name_Enemy),
    !.


check_Akatsuki_Enemy(List,Name_Enemy):-
    repeat,
    generate_Random_Akatsuki_Enemy(Name_Enemy),
    check(List,Name_Enemy),
    !.

generate_Normal_Enemy:-
    enemyLoc(OldX,OldY),
    enemy_appear(List_Of_Enemy),
    generate_Random_Location(OldX,OldY),
    check_Enemy(List_Of_Enemy,Name_Enemy),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    retract(enemy_appear(List_Of_Enemy)),
    asserta(enemy_appear(NewListOfEnemy)),
    !.

generate_Akatsuki_Enemy:-
    enemyLoc(OldX,OldY),
    enemy_appear(List_Of_Enemy),
    generate_Random_Location(OldX,OldY),
    check_Enemy(List_Of_Enemy,Name_Enemy),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    retract(enemy_appear(List_Of_Enemy)),
    asserta(enemy_appear(NewListOfEnemy)),
    !.

/* check Is Inventory Full?, Bila Full jangan tambahkan Inventory! */
nbElmtList([],0) :- !.
nbElmtList(List,count) :- List=[H|T],nbElmtList(T,count1),count is count+count1.

isFullInventory(ListOfInventory):-nbElmtList(ListOfInventory,count),count==6.

akatsukiProbability(5000).
/* Probabilitas kemunculan Akatsuki, Jika true maka Enemy akatsuki akan di generate  */
probabilityAkatsuki:-
    random(0,10,Elem1),
    random(0,10,Elem2),
    random(0,10,Elem3),
    random(0,10,Elem4),
    ElemX is Elem1*1000+Elem2*100+Elem3*10+Elem4,
    akatsukiProbability(X),
    ElemX>X.
