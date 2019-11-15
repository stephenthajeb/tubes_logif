/* Attack Mechanism */
/* attack(AttType, PlayerType, EnemyType)
    AttType == 1 : Normal
    AttType == 2 : Skill */
/* PLAYER */

/* Strong TYPE */
player_Attack(1, PlayerType, EnemyType) :-
    strong(PlayerType,EnemyType),
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(NDamage + (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

player_Attack(2, PlayerType, EnemyType) :-
    strong(PlayerType,EnemyType),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(SDamage + (SDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/* WEAK TYPE */
player_Attack(1, PlayerType, EnemyType) :-
    strong(EnemyType,PlayerType),
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(NDamage - (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

player_Attack(2, PlayerType, EnemyType) :-
    strong(EnemyType,PlayerType),
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(SDamage - (SDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

/* NORMAL TYPE */
player_Attack(1, PlayerType, EnemyType) :-
    player(_, PlayerType, _, _, _, NDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    PlayerType==EnemyType,
    NewHP is EnemyHP-NDamage,
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.

player_Attack(2, PlayerType, EnemyType) :-
    player(_, PlayerType, _, _, _, _, SDamage),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    PlayerType==EnemyType,
    NewHP is EnemyHP-SDamage,
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)),!.


/* ENEMY */
/* STRONG TYPE */
enemy_Attack(1, EnemyType, PlayerType) :-
    strong(EnemyType, PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-(NDamage + (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)).

enemy_Attack(2, EnemyType, PlayerType) :-
    strong(EnemyType, PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    NewHP is PlayerHP-(SDamage + (SDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)).

/* NORMAL TYPE */
enemy_Attack(1, EnemyType, PlayerType) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    EnemyType==PlayerType,
    NewHP is PlayerHP-NDamage,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2, EnemyType, PlayerType) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    EnemyType==PlayerType,
    NewHP is PlayerHP-SDamage,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

/* WEAK TYPE */
enemy_Attack(1, EnemyType, PlayerType) :-
    strong(PlayerType,EnemyType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-(NDamage - (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

enemy_Attack(2, EnemyType, PlayerType) :-
    strong(PlayerType,EnemyType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    NewHP is PlayerHP-(SDamage - (SDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage)),!.

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