/* Sebagai Database Enemy apa saja yang sudah dilawan */
:-dynamic(enemy_appear/1).
/* Sebagai Database Enemy apa saja yang sudah dialokasikan pada peta atau lokasi */
:-dynamic(enemy/1).
/* Sebagai Database lokasi Enemy pada sumbu X */
:-dynamic(enemyLocX/1).
/* Sebagai Database lokasi Enemy pada sumbu Y */
:-dynamic(enemyLocY/1).
/* untuk jumlah step minimal agar akatsuki bisa muncul */
:-dynamic(twoAkatsuki/1). 
/* Menghitung kemunculan Banyaknya Akatsuki */
:-dynamic(nbAkatsuki/1).
/* Menghitung berapa banyak Akatsuki yang sudah dikalahkan */
:-dynamic(akatsuki_Appear/1).

/* Init Database */
enemy_appear([naruto]).
enemy([naruto]).
enemyLocX([1]).
enemyLocY([1]).
/* Fakta untuk generate random Character */
names(gaara,1).
names(sakura,2).
names(sasuke,3).
names(lee,4).
names(neji,5).
names(choji,6).
names(shikamaru,7).
names(tenten,8).
names(kiba,9).
names(shino,10).
names(deidara,11).
names(tobi,12).
names(sasori,13).
names(itachi,14).
/* Init Probabilitas kemunculan Akatsuki kedua */
twoAkatsuki(30).
/* Init jumlah Akatsuki yang sudah muncul */
nbAkatsuki(0).
/* Init jumlah Akatsuki yang sudah dikalahkan */
akatsuki_Appear(0).
/* Probabilitas kabur saat berhadapan dengan Normal Enemy */
normalProbability(70).
/* Probabilitas kabur saat berhadapan dengan Akatsuki */
akatsukiProbability(20).

/*Generate nilai lokasi X dan Y secara acak*/
generate_Random_Location(X,Y):-
    random(1,11,X),
    random(1,11,Y).
/*Generate Nama Enemy secara acak */
generate_Random_Normal_Enemy(Name_Enemy):-
    random(1,11,Number),
    names(Name_Enemy,Number).

generate_Random_Akatsuki_Enemy(Name_Enemy):-
    random(11,14,Number),
    names(Name_Enemy,Number).

/* Skema pengecekan apakah terdapat nilai Y pada List, Jika tidak ada akan menghasilkan true*/
check([],Y):-!.
check(List,Y):- 
    List=[Head|Tail], 
    !, 
    check(Tail,Y), 
    Head\==Y.     

checkList([],Y):- !,fail.
checkList(List,Y):-
    List=[Head|Tail], 
    Head==Y,
    !.
checkList(List,Y):-
    List=[Head|Tail],
    Head\==Y,
    checkList(Tail,Y).

checkKoordinat(X,Y,[],[]):- 
    !,
    fail.

checkKoordinat(X,Y,ListX,ListY):-
    ListX=[HeadX|TailX],
    ListY=[HeadY|TailY],
    X==HeadX,
    Y==HeadY,
    !.

checkKoordinat(X,Y,ListX,ListY):-
    ListX=[HeadX|TailX],
    ListY=[HeadY|TailY],
    checkKoordinat(X,Y,TailX,TailY).
    
/* Check apakah Nama Normal Enemy sudah ada pada enemy_appear*/
check_Normal_Enemy(List,Name_Enemy):-
    repeat,
    generate_Random_Normal_Enemy(Name_Enemy),
    check(List,Name_Enemy),
    !.

/* Check apakah Nama Akatsuki sudah ada pada enemy_appear*/
check_Akatsuki_Enemy(List,Name_Enemy):-
    repeat,
    generate_Random_Akatsuki_Enemy(Name_Enemy),
    check(List,Name_Enemy),
    !.

/* Menghasilkan tambahan Nama Enemy serta lokasinya tetapi hanya sebanyak satu buah */
/*Jika ternyata didapat X sama*/
generate_Normal_Enemy:-
    enemy(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    generate_Random_Location(X,Y),
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldY,Y),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemy(List_Of_Enemy)),
    asserta(enemy(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    !.

/*Jika ternyata didapat Y sama*/
generate_Normal_Enemy:- 
    enemy(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    generate_Random_Location(X,Y),
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldX,X),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemy(List_Of_Enemy)),
    asserta(enemy(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    !.

/* Kemunculan Akatsuki pertama */

/* Bila posisi player saat mengalahkan musuk ke-3 berada pada kuadran 1 */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear),
    nbElmtList(List_Of_Enemy_Appear,Count),
    nbAkatsuki(Number_Akatsuki),
    Count==3,
    Number_Akatsuki==0,
    enemy(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    X1 is X1 - 5,
    Y1 is Y1 - 5,
    abs(X1,NewX),
    abs(Y1,NewY),
    (X>NewX; X==NewX),
    (Y>NewY; Y==NewY), 
    !,
    generate_Random_Location(X,Y),
    (X>NewX; X==NewX),
    (Y>NewY; Y==NewY),  
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldX,X),
    check(OldY,Y),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemy(List_Of_Enemy)),
    asserta(enemy(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki)).

/* Bila posisi                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       player saat mengalahkan musuk ke-3 berada pada kuadran 2 */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear),
    nbElmtList(List_Of_Enemy_Appear,Count),
    nbAkatsuki(Number_Akatsuki),
    Count==3,
    Number_Akatsuki==0,
    enemy(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    X1 is X1 - 5,
    Y1 is Y1 - 5,
    abs(X1,NewX),
    abs(Y1,NewY),
    (X<NewX; X==NewX),
    (Y>NewY; Y==NewY),
    !,
    generate_Random_Location(X,Y),
    (X<NewX; X==NewX),
    (Y>NewY; Y==NewY), 
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldX,X),
    check(OldY,Y),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemy(List_Of_Enemy)),
    asserta(enemy(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki)).

/* Bila posisi player saat mengalahkan musuk ke-3 berada pada kuadran 3 */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear),
    nbElmtList(List_Of_Enemy_Appear,Count),
    nbAkatsuki(Number_Akatsuki),
    Count==3,
    Number_Akatsuki==0,
    enemy(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    X1 is X1 - 5,
    Y1 is Y1 - 5,
    abs(X1,NewX),
    abs(Y1,NewY),
    (X>NewX; X==NewX),
    (Y<NewY; Y==NewY),  
    !,
    generate_Random_Location(X,Y),
    (X>NewX; X==NewX),
    (Y<NewY; Y==NewY),  
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldX,X),
    check(OldY,Y),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemy(List_Of_Enemy)),
    asserta(enemy(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki)).

/* Bila posisi player saat mengalahkan musuk ke-3 berada pada kuadran 4 */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear),
    nbElmtList(List_Of_Enemy_Appear,Count),
    nbAkatsuki(Number_Akatsuki),
    Count==3,
    Number_Akatsuki==0,
    enemy(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    X1 is X1 - 5,
    Y1 is Y1 - 5,
    abs(X1,NewX),
    abs(Y1,NewY),
    (X<NewX; X==NewX),
    (Y<NewY; Y==NewY),
    !,
    generate_Random_Location(X,Y),
    (X<NewX; X==NewX),
    (Y<NewY; Y==NewY),  
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldX,X),
    check(OldY,Y),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemy(List_Of_Enemy)),
    asserta(enemy(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki)).

/* Kemuculan Akatsuki kedua */
generate_Akatsuki_Enemy:- 
    enemy_appear(List_Of_Enemy_Appear), 
    nbElmtList(List_Of_Enemy_Appear,Count),
    (Count>7;Count==7),
    nbAkatsuki(X),
    X==1, 
    akatsuki_Appear(Akatsuki_Appear),
    Akatsuki_Appear==1,
    random(1,10,Y),
    twoAkatsuki(Y1),
    retract(twoAkatsuki(Y1)),
    Y1 is Y1+Y,
    asserta(twoAkatsuki(Y1)),
    (Y1>80 ; Y1==80),
    enemy(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    check_Akatsuki_Enemy(List_Of_Enemy,Name_Enemy),
    !,
    generate_Random_Location(LocX,LocY),
    check(OldX,LocX),
    check(OldY,LocY),
    X\==X1,
    Y\==Y1,
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemy(List_Of_Enemy)),
    asserta(enemy(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki)).

/* Kemunculan Akatsuki Ketiga */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear), 
    nbElmtList(List_Of_Enemy_Appear,Count),
    (Count>10;Count==10),
    nbAkatsuki(X),
    X==2,
    akatsuki_Appear(Akatsuki_Appear),
    Akatsuki_Appear==2, 
    enemy(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    check_Akatsuki_Enemy(List_Of_Enemy,Name_Enemy),
    !,
    generate_Random_Location(LocX,LocY),
    check(OldX,LocX),
    check(OldY,LocY),
    X\==X1,
    Y\==Y1,
    write(" Akatsuki ketiga sudah ditemukan! pada koordinat "),
    write(X1),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemy(List_Of_Enemy)),
    asserta(enemy(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki)).

concat([],[],[]):- !.
concat([],List2,List2):- !.
concat(List1,List2,List):-
    List1=[H1|T1],
    concat(T1,List2,List3),
    List=[H1|List3].
    
select_Player(Select,[Select],[]):- !.
select_Player(Select,PlayerInventory,NewInventory):-
    PlayerInventory=[Head|Tail],
    Head==Select,
    !,
    NewInventory=Tail.
select_Player(Select,PlayerInventory,NewInventory):-
    PlayerInventory=[Head|Tail],
    Head\==Select,
    !,
    select_Player(Select,Tail,NewInventory1),
    NewInventory=[Head|NewInventory1]. 

/* Bila ingin mengisi enemy, enemyLocX, enemyLocY secara penuh untuk alokasi enemy awal bisa langsung menggunakan rules ini */
enemyGenerator:-
    repeat,
    generate_Normal_Enemy,
    enemy(List_Of_Enemy),
    nbElmtList(List_Of_Enemy,Count),
    Count==10,
    !.

/* untuk menghitung berapa banyak elemen pada List */
nbElmtList([],0):- !.
nbElmtList(List,Count):-
    List=[H|T],
    nbElmtList(T,Count1),
    Count is Count1+1.

/* check Is Inventory Full?, Bila Full jangan tambahkan Inventory! */
isFullInventory(ListOfInventory):-
    nbElmtList(ListOfInventory,Count),
    Count==6,
    !.

/* skema pengecekan untuk mengetahui apakah tiga Akatsuki sudah dihabisi untuk kemunculan hitachi */
isHitachiAppear:-
    enemy_appear(List_Of_Enemy),
    nbElmtList(List_Of_Enemy,Count),
    Count==14,
    !.

/* skema pengecekan apakah player sudah menang (bisa melawan seluruh enemy) */
winCondition:-    
    enemy_appear(List_Of_Enemy),
    nbElmtList(List_Of_Enemy,Count),
    Count==15,
    !.
    
/* untuk mengecek apakah Akatsuki sudah bisa muncul/dialokasikan pada enemy, enemyLocX, dan enemyLocY */
isAkatsukiAppear:-
    enemy_appear(List_Of_Enemy),
    nbElmtList(List_Of_Enemy,Count),
    (Count==3; Count==7; Count==10; Count==14),
    !.

/* rules mutlak untuk efisiensi rules generate Akatsuki awal */
abs(X, NewX) :- 
    X <  0 , 
    NewX is X+10, 
    !.

abs(X, X) :- X > 0.

/* Probabilitas run ketika enemy muncul, jika true maka player bisa kabur */
runAwayNormalEnemyProbability:-
    random(0,101,Probability),
    normalProbability(X),
    !,
    (Probability<X;Probability==X).

runAwayAkatsukiProbability:-
    random(0,101,Probability),
    akatsukiProbability(X),
    !,
    (Probability<X;Probability==X).