/* Attack Mechanism */
/* attack(AttType, PlayerType, EnemyType)
    AttType == 1 : Normal
    AttType == 2 : Skill */
/* PLAYER */

:- dynamic(attackStatus/1).
:- dynamic(healStatus/1).
:- dynamic(skillStatusP/1).
:- dynamic(skillStatusE/1).
:- dynamic(captureStatus/1).
:- dynamic(moveStatus/1).


/*Normal Attack*/
/* STRONG TYPE */
normal :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(PlayerType,EnemyType),
    NewHP1 is EnemyHP-NDamage,
    (NewHP1 < 0.00; NewHP1==0.00),
    NewHP is 0,
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
normal :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(PlayerType,EnemyType),
    NewHP is EnemyHP-(NDamage + (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/* WEAK TYPE */
normal :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(EnemyType,PlayerType),
    NewHP1 is EnemyHP-(NDamage - (NDamage/2)),
    (NewHP1 < 0.00; NewHP1==0.00),
    NewHP is 0,
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
normal :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(EnemyType,PlayerType),
    NewHP is EnemyHP-(NDamage - (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/* NORMAL TYPE */
normal :-
    player(_, _, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP1 is EnemyHP-NDamage,
    NewHP1 < 1,
    NewHP is 0,
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
normal :-
    player(_, _, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-NDamage,
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/*Skill Attack*/
skill :-  skillStatusP(1),printSkillUsed,!.
/* Strong TYPE */
skill :-
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(PlayerType,EnemyType),
    NewHP1 is EnemyHP-(SDamage + (SDamage/2)),
    (NewHP1 < 0.00; NewHP1==0.00),
    NewHP is 0,
    retract(skillStatusP(_)),
    asserta(skillStatusP(0)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
skill :-
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(PlayerType,EnemyType),
    NewHP is EnemyHP-(SDamage + (SDamage/2)),
    retract(skillStatusP(0)),
    asserta(skillStatusP(1)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.
/* WEAK TYPE */
skill :-
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(EnemyType,PlayerType),
    NewHP1 is EnemyHP-(SDamage - (SDamage/2)),
    (NewHP1 < 0.00; NewHP1==0.00),
    NewHP is 0,
    retract(skillStatusP(_)),
    asserta(skillStatusP(0)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
skill :-
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(EnemyType,PlayerType),
    NewHP is EnemyHP-(SDamage - (SDamage/2)),
    retract(skillStatusP(0)),
    asserta(skillStatusP(1)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.
/* NORMAL TYPE */
skill :-
    skillStatusP(0),
    player(_, _, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP1 is EnemyHP-SDamage,
    NewHP1 < 1,
    NewHP is 0,
    retract(skillStatusP(_)),
    asserta(skillStatusP(0)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
skill :-
    skillStatusP(0),
    player(_, _, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-SDamage,
    retract(skillStatusP(0)),
    asserta(skillStatusP(1)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/* ENEMY */
/*Normal Attack*/
/* STRONG TYPE */
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(EnemyType,PlayerType),
    NewHP1 is PlayerHP-(NDamage + (NDamage/2)),
    (NewHP1 < 0.00; NewHP1==0.00),
    NewHP is 0,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(EnemyType, PlayerType),
    NewHP is PlayerHP-(NDamage + (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

/* WEAK TYPE */
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(PlayerType,EnemyType),
    NewHP1 is PlayerHP-(NDamage - (NDamage/2)),
    (NewHP1 < 0.00; NewHP1==0.00),
    NewHP is 0,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(PlayerType,EnemyType),
    NewHP is PlayerHP-(NDamage - (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

/* NORMAL TYPE */
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, _, _, _, _, NDamage, _),
    NewHP1 is PlayerHP-NDamage,
    NewHP1 < 1,
    NewHP is 0,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, _, _, _, _, NDamage, _),
    NewHP is PlayerHP-NDamage,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.


/*Skill Attack*/
/* STRONG TYPE */
enemy_Attack(2) :-
    skillStatusE(0),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _,_, SDamage),
    strong(EnemyType,PlayerType),
    NewHP1 is PlayerHP-(SDamage + (SDamage/2)),
    (NewHP1 < 0.00; NewHP1==0.00),
    NewHP is 0,
    printKO,
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(2) :-
    skillStatusE(0),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    strong(EnemyType, PlayerType),
    NewHP is PlayerHP-(SDamage + (SDamage/2)),
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

/* WEAK TYPE */
enemy_Attack(2) :-
    skillStatusE(0),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _,_, SDamage),
    strong(PlayerType,EnemyType),
    NewHP1 is PlayerHP-(SDamage - (SDamage/2)),
    (NewHP1 < 0.00; NewHP1==0.00),
    NewHP is 0,
    printKO,
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(2) :-
    skillStatusE(0),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    strong(PlayerType,EnemyType),
    NewHP is PlayerHP-(SDamage - (SDamage/2)),
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

/* NORMAL TYPE */
enemy_Attack(2) :-
    skillStatusE(0),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, _, _, _, _,_, SDamage),
    NewHP1 is PlayerHP-SDamage,
    NewHP1 < 1,
    NewHP is 0,
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(2) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, _, _, _, _, _, SDamage),
    NewHP is PlayerHP-SDamage,
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2):-
    skillStatusE(1),
    enemy_Attack(1).


/* Heal */
heal :- playerLoc(X1,Y1),healLoc(X2,Y2),X1\==X2,Y1\==Y2,printCommandInvalid,!.
heal :- healStatus(0),
        player(Name, Type, X, Y, HP, NDamage, SDamage),
        hp(Name,NewHP),
        retract(player(Name, Type, X, Y, HP, NDamage, SDamage)),
        asserta(player(Name, Type, X, Y, NewHP, NDamage, SDamage)),
        status,
        inventory(ListFriends),
        healAll(ListFriends,ListHP),
        retract(currHP(_)),
        asserta(currHP(ListHP)),
        retract(healStatus(0)),
        asserta(healStatus(1)).

healAll([],[]):-!.
healAll(ListFriends,NewListHP):-
    ListFriends=[HeadF|TailF],
    hp(HeadF,NewHP),
    HeadNew is NewHP,
    healAll(TailF,NewListHP1),
    NewListHP=[HeadNew|NewListHP1].

/* Battle Mechanism */
attackCondition(0):- !.
attackCondition(_):-
    random(1,3,X),
    call(enemy_Attack(X)).

attack_(PHP, _, kalah):- PHP<1,!.
attack_(PHP, EHP, menang):- EHP<1,
                            currHP(ListHP),
                            insert(ListHP,PHP,NewHP),
                            retractall(currHP(_)),
                            asserta(currHP(NewHP)),
                            !.
attack_(_, _, State) :- 
    write('Silahkan Masukkan "normal" atau "skill" untuk menyerang lawan! '),nl,
    write('input: '),nl,
    repeat,
        read(Input),
        print_InvalidAttack(Input),
    (Input==normal;(Input==skill,skillStatusP(0))),
    call(Input),
    !,
    enemy(_, _, _, _, EHP, _, _),
    write('--------------------- BATTLE STATUS ---------------------'),nl,
    enemystatus,nl,
    attackCondition(EHP),
    player(_, _, _, _, PHP, _, _),
    playerstatus,nl,
    attack_(PHP,EHP,State).

attackBattle:-
    enemy(_, _, _, _, EnemyHP, _, _),
    player(Name, _, _, _, PlayerHP, _, _),
    attack_(PlayerHP, EnemyHP, Status),
    Status==menang,
    inventory(ListOfInventory),
    retractall(inventory(_)),
    insert(ListOfInventory,Name,NewInventory),
    asserta(inventory(NewInventory)),
    write('Apakah anda ingin menambahkan allies ?  (capture/no) '),nl,
    repeat,
        read(Input),
        print_InvalidCapture1(Input),
    (Input==capture;Input==no),
    call(Input),
    !,
    enemy(EnemyName, _, _, _, _, _, _),
    cekAkatsuki,
    retractall(enemy(_, _, _, _, _, _, _)),
    enemy_appear(List),
    retractall(enemy_appear(List)),
    asserta(enemy_appear([EnemyName|List])),
    !.

attackBattle:-
    enemy(_, _, _, _, EnemyHP, _, _),
    player(_, _, _, _, PlayerHP, _, _),
    attack_(PlayerHP, EnemyHP, Status),
    Status==kalah,
    inventory(ListOfInventory),
    battle(ListOfInventory).

battle([]):- !.

battle(_) :-
    write('Silahkan pilih Allies ! '),nl,
    inventory(ListOfInventory),
    print_Inventory(ListOfInventory),nl,
    write('Allies: '),
    repeat,
        read(Name),
        print_InvalidYes(Name,ListOfInventory),
    checkList(ListOfInventory,Name),
    select(Name),
    !,
    write('--------------------- BATTLE STATUS ---------------------'),nl,nl,
    enemystatus,nl,nl,
    playerstatus,nl,
    attackBattle.

attack:-
    print_BattleTitle,
    inventory(ListInventory),nl,
    battle(ListInventory).
