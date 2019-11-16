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

run :- runProbability(),!.
run :- retract,assert(moveStatus(0))


repeat
    
until

/*Normal Attack*/
player_Attack(1) :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    write('aaa'),
    strong(PlayerType,EnemyType),
    NewHP is EnemyHP-NDamage,
    NewHP < 1,
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    /*Apakah mau tambahin ke dalam inventory, jika iya cek inventory dan masukkin ke inventory*/
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
player_Attack(1) :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    write('bbb'),
    strong(PlayerType,EnemyType),
    NewHP is EnemyHP-(NDamage + (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.
player_Attack(1) :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    write('eee'),
    strong(EnemyType,PlayerType),
    NewHP is EnemyHP-(NDamage - (NDamage/2)),
    NewHP < 1,
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
player_Attack(1) :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    write('fff'),
    strong(EnemyType,PlayerType),
    NewHP is EnemyHP-(NDamage - (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.
player_Attack(1) :-
    write('iii'),
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-NDamage,
    write('oooo'),
    NewHP < 1,
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    /*Cek inventory*/
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
player_Attack(1) :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-NDamage,
    write('jjj'),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/*Skill Attack*/
/* Strong TYPE */
player_Attack(2) :-  skillStatusP(1),printSkillUsed,!.
player_Attack(2) :-
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(PlayerType,EnemyType),
    NewHP is EnemyHP-(SDamage + (SDamage/2)),
    write('kkk'),
    NewHP < 1,
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    write('lll'),
    write('mmm'),
    write('nnn '),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
player_Attack(2) :-
    write('ddd'),
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(PlayerType,EnemyType),
    NewHP is EnemyHP-(SDamage + (SDamage/2)),
    retract(skillStatusP(0)),
    asserta(skillStatusP(1)),
    write('lll'),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.
/* WEAK TYPE */
player_Attack(2) :-
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    write('ggg'),
    strong(EnemyType,PlayerType),
    write('hhh'),
    NewHP is EnemyHP-(SDamage - (SDamage/2)),
    NewHP < 1,
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    write('iii'),
    write('mmm'),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
player_Attack(2) :-
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    strong(EnemyType,PlayerType),
    write('hhh'),
    NewHP is EnemyHP-(SDamage - (SDamage/2)),
    retract(skillStatusP(0)),
    asserta(skillStatusP(1)),
    write('nnn'),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.
/* NORMAL TYPE */
player_Attack(2) :-
    write('xxx'),
    skillStatusP(0),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-SDamage,
    NewHP < 1,
    retract(skillStatusP(_)),
    asserta(skillStatusP(0)),
    write('ooo'),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    print_Capture,!.
player_Attack(2) :-
    write('ZZZ');
    skillStatusP(0),
    write('YY');
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-SDamage,
    retract(skillStatusP(0)),
    asserta(skillStatusP(1)),
    write('qqq'),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/* ENEMY */
/*Normal Attack*/
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(EnemyType,PlayerType),
    NewHP is PlayerHP-(NDamage + (NDamage/2)),
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(EnemyType, PlayerType),
    NewHP is PlayerHP-(NDamage + (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(PlayerType,EnemyType),
    NewHP is PlayerHP-(NDamage - (NDamage/2)),
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    strong(PlayerType,EnemyType),
    NewHP is PlayerHP-(NDamage - (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-NDamage,
    NewHP < 1,
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(1) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-NDamage,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.


/*Skill Attack*/
enemy_Attack(2) :-
    skillStatusE(0),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _,_, SDamage),
    strong(EnemyType,PlayerType),
    NewHP is PlayerHP-(SDamage + (SDamage/2)),
    NewHP < 1,
    printKO,
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.
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
enemy_Attack(2) :-
    skillStatusE(0),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _,_, SDamage),
    strong(PlayerType,EnemyType),
    NewHP is PlayerHP-(SDamage - (SDamage/2)),
    NewHP < 1,
    printKO,
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.
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
enemy_Attack(2) :-
    skillStatusE(0),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _,_, SDamage),
    NewHP is PlayerHP-SDamage,
    NewHP < 1,
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    printKO,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),!.
enemy_Attack(2) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    NewHP is PlayerHP-SDamage,
    retract(skillStatusE(0)),
    asserta(skillStatusE(1)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.


/* STRONG TYPE */


/* WEAK TYPE */


/* NORMAL TYPE */



/* Heal */
heal :- playerLoc(X1,Y1),healLoc(X2,Y2),X1\==X2,Y1\==Y2,printCommandInvalid,!.
heal :- healStatus(0),
        player(Name, Type, X, Y, HP, NDamage, SDamage),
        retract(player(Name, Type, X, Y, HP, NDamage, SDamage)),
        asserta(player(Name, Type, X, Y, 100, NDamage, SDamage)),
        print_PlayerStatus,
        retract(healStatus(0)),
        asserta(healStatus(1)).


/* Battle Mechanism */
/*
attack(Allies, Enemy, Kalah).
attack(Allies, Enemy, Menang).
attack(Allies, Enemy, State) :- 
    player(_, PlayerType, _, _, _, _, _, _),
    enemy(_, EnemyType, _, _, EnemyHP, _, _),
    player_Attack(AttType, PlayerType, EnemyType),
    EnemyHP==0,
    attack(Allies, Enemy, StateX),
    State is StateX.
    
attack(Allies, Enemy, State) :-
    player(_, PlayerType, _, _, _, _, _, _),
    enemy(_, EnemyType, _, _, EnemyHP, _, _),
    player_Attack(AttType, PlayerType, EnemyType),
    EnemyHP=\=0,
    enemy_Attack(AttType, EnemyType, PlayerType),
    attack(Allies, Enemy, StateX),
    State is StateX.
battle(Inventory=[], Enemy, Kalah).
battle(Allies, Enemy, State) :-
    select_player,
    attack(Allies, Enemy, Kalah),
    battle(Allies, Enemy, State).
battle(Allies, Enemy, State) :-
    select_player,
    attack(Allies, Enemy, Menang),
    insert(player),
    State is Menang.
*/