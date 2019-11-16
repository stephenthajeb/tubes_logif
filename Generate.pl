/* Sebagai Database Enemy apa saja yang sudah dilawan */
:-dynamic(enemy_appear/1).
/* Sebagai Database Enemy apa saja yang sudah dialokasikan pada peta atau lokasi */
:-dynamic(enemyName/1).
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
enemyName([naruto]).
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

checkKoordinat(X,Y,Name,[],[],[]):- 
    !,
    fail.

checkKoordinat(X,Y,Name,ListX,ListY,ListEnemy):-
    ListX=[HeadX|TailX],
    ListY=[HeadY|TailY],
    ListEnemy=[HeadEnemy|TailEnemy],
    X==HeadX,
    Y==HeadY,
    Name = HeadEnemy,
    !.

checkKoordinat(X,Y,Name,ListX,ListY,ListEnemy):-
    ListX=[HeadX|TailX],
    ListY=[HeadY|TailY],
    ListEnemy=[HeadEnemy|TailEnemy],
    checkKoordinat(X,Y,Name,TailX,TailY,TailEnemy).

checkHP([],[],_,_):-
    !,
    fail.
checkHP([Name|_],[NewHP|_],Name,NewHP):-
    !.
checkHP(ListName,ListHP,Name,NewHP):-
    ListName=[HeadName|TailName],
    ListHP=[HeadHP|TailHP],
    checkHP(TailName,TailHP,Name,NewHP).

takeEnemy(X,Y,Enemy,[],[],[]):- !, fail.
    
takeEnemy(X,Y,H,[X|TailX],[Y|TailY],[H|T]):- !.

takeEnemy(X,Y,Enemy,[HeadX|TailX],[HeadY|TailY],[H|T]):- takeEnemy(X,Y,Enemy,TailX,TailY,T).

isEnemyAppear:- 
    playerLoc(X,Y),  
    enemyLocX(X1), 
    enemyLocY(Y1), 
    enemyName(List_Of_Enemy), 
    enemy_appear(List_Of_Enemy_Appear),
    !, 
    checkKoordinat(1,1,X1,Y1), 
    takeEnemy(1,1,Enemy,X1,Y1,List_Of_Enemy),
    check(List_Of_Enemy_Appear,Enemy).

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
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    generate_Random_Location(X,Y),
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldY,Y),
    check(OldX,X),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    !.

generate_Normal_Enemy:-
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    generate_Random_Location(X,Y),
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldY,Y),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    !.

/*Jika ternyata didapat Y sama*/
generate_Normal_Enemy:- 
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    generate_Random_Location(X,Y),
    check_Normal_Enemy(List_Of_Enemy,Name_Enemy),
    check(OldX,X),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
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
    Count==4,
    Number_Akatsuki==0,
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    X2 is X1 - 5,
    Y2 is Y1 - 5,
    abs(X2,NewX),
    abs(Y2,NewY),
    (X1>5;X1==5),
    (Y1<5;Y1==5),
    !,
    repeat,
    random(1,NewX+1,X),
    random(NewY,11,Y), 
    \+(checkKoordinat(X,Y,OldX,OldY)),
    !,
    check_Akatsuki_Enemy(List_Of_Enemy,Name_Enemy),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki1 is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki1)).

/* Bila posisi player saat mengalahkan musuk ke-3 berada pada kuadran 2 */    
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear),
    nbElmtList(List_Of_Enemy_Appear,Count),
    nbAkatsuki(Number_Akatsuki),
    Count==4,
    Number_Akatsuki==0,
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    X2 is X1 - 5,
    Y2 is Y1 - 5,
    abs(X2,NewX),
    abs(Y2,NewY),
    (X1<5;X1==5),
    (Y1<5;Y1==5),
    !,
    repeat,
    random(NewX,11,X),
    random(NewY,11,Y), 
    \+(checkKoordinat(X,Y,OldX,OldY)),
    !,
    check_Akatsuki_Enemy(List_Of_Enemy,Name_Enemy),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki1 is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki1)).

/* Bila posisi player saat mengalahkan musuk ke-3 berada pada kuadran 3 */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear),
    nbElmtList(List_Of_Enemy_Appear,Count),
    nbAkatsuki(Number_Akatsuki),
    Count==4,
    Number_Akatsuki==0,
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    X2 is X1 - 5,
    Y2 is Y1 - 5,
    abs(X2,NewX),
    abs(Y2,NewY),
    (X1<5;X1==5),
    (Y1>5;Y1==5),
    !,
    repeat,
    random(NewX,11,X),
    random(1,NewY+1,Y),
    \+(checkKoordinat(X,Y,OldX,OldY)),
    !,  
    check_Akatsuki_Enemy(List_Of_Enemy,Name_Enemy),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki1 is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki1)).

/* Bila posisi player saat mengalahkan musuk ke-3 berada pada kuadran 4 */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear),
    nbElmtList(List_Of_Enemy_Appear,Count),
    nbAkatsuki(Number_Akatsuki),
    Count==4,
    Number_Akatsuki==0,
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    X2 is X1 - 5,
    Y2 is Y1 - 5,
    abs(X2,NewX),
    abs(Y2,NewY),
    (X1>5;X1==5),
    (Y1>5;Y1==5),
    !,
    repeat,
    random(1,NewX+1,X),
    random(1,NewY+1,Y),
    \+(checkKoordinat(X,Y,OldX,OldY)),
    !,
    check_Akatsuki_Enemy(List_Of_Enemy,Name_Enemy),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[Y|OldY],
    NewEnemyLocX=[X|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki1 is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki1)).

/* Kemuculan Akatsuki kedua */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear), 
    nbElmtList(List_Of_Enemy_Appear,Count),
    (Count>8;Count==8),
    nbAkatsuki(X),
    X==1, 
    akatsuki_Appear(Akatsuki_Appear),
    Akatsuki_Appear==1,
    random(1,10,Y),
    twoAkatsuki(Y1),
    retract(twoAkatsuki(Y1)),
    Y2 is Y1+Y,
    asserta(twoAkatsuki(Y2)),
    (Y2>80 ; Y2==80),
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(PX,PY),
    check_Akatsuki_Enemy(List_Of_Enemy,Name_Enemy),
    !,
    repeat,
    generate_Random_Location(LocX,LocY),
    \+(checkKoordinat(LocX,LocY,OldX,OldY)),
    LocX\==PX,
    LocY\==PY,
    !,
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[LocY|OldY],
    NewEnemyLocX=[LocX|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki1 is Number_Akatsuki+1,
    asserta(nbAkatsuki(Number_Akatsuki1)).

/* Kemunculan Akatsuki Ketiga */
generate_Akatsuki_Enemy:-
    enemy_appear(List_Of_Enemy_Appear), 
    nbElmtList(List_Of_Enemy_Appear,Count),
    (Count>11;Count==11),
    nbAkatsuki(X),
    X==2,
    akatsuki_Appear(Akatsuki_Appear),
    Akatsuki_Appear==2, 
    enemyName(List_Of_Enemy),
    enemyLocY(OldY),
    enemyLocX(OldX),
    playerLoc(X1,Y1),
    check_Akatsuki_Enemy(List_Of_Enemy,Name_Enemy),
    !,
    repeat,
    generate_Random_Location(LocX,LocY),
    \+(checkKoordinat(LocX,LocY,OldX,OldY)),
    LocX\==X1,
    LocY\==Y1,
    !,
    write(' Akatsuki ketiga sudah ditemukan! pada koordinat '),
    write('('),
    print(LocX),
    write(',Y)'),
    NewListOfEnemy=[Name_Enemy|List_Of_Enemy],
    NewEnemyLocY=[LocY|OldY],
    NewEnemyLocX=[LocX|OldX],
    retract(enemyName(List_Of_Enemy)),
    asserta(enemyName(NewListOfEnemy)),
    retract(enemyLocY(OldY)),
    asserta(enemyLocY(NewEnemyLocY)),
    retract(enemyLocX(OldX)),
    asserta(enemyLocX(NewEnemyLocX)),
    retract(nbAkatsuki(Number_Akatsuki)),
    Number_Akatsuki1 is Number_Akatsuki+1,
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
    enemyName(List_Of_Enemy),
    nbElmtList(List_Of_Enemy,Count),
    Count==11,
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
    (Count==4; Count==8; Count==11; Count==14),
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
