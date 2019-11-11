/* Include */
-include('character.pl').

/* Battle Mechanism */
/* attack(AttType, PlayerType, EnemyType)
    AttType == 1 : Normal
    AttType == 2 : Skill */
/* PLAYER */
/* NORMAL TYPE */
player_Attack(1, PlayerType, EnemyType) :-
    player(_, PlayerType, _, _, _, NDamage, _, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    PlayerType==EnemyType,
    NewHP is EnemyHP-NDamage,
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)).

player_Attack(2, PlayerType, EnemyType) :-
    player(_, PlayerType, _, _, _, _, SDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    PlayerType==EnemyType,
    NewHP is EnemyHP-SDamage,
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)).
/* STRONG TYPE */
player_Attack(1, PlayerType, EnemyType) :-
    strong(PlayerType, EnemyType),
    player(_, PlayerType, _, _, _, NDamage, _, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(NDamage + (2*NDamage)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)).

player_Attack(2, PlayerType, EnemyType) :-
    strong(PlayerType, EnemyType),
    player(_, PlayerType, _, _, _, _, SDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(SDamage + (2*SDamage)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)).
/* WEAK TYPE */
player_Attack(1, PlayerType, EnemyType) :-
    weak(PlayerType, EnemyType),
    player(_, PlayerType, _, _, _, NDamage, _, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(NDamage + (NDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)).

player_Attack(2, PlayerType, EnemyType) :-
    weak(PlayerType, EnemyType),
    player(_, PlayerType, _, _, _, _, SDamage, _),
    enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage),
    NewHP is EnemyHP-(SDamage + (SDamage/2)),
    retract(enemy(EnemyName, EnemyType, EnemyX, EnemyY, EnemyHP, EnemyNDamage, EnemySDamage)),
    asserta(enemy(EnemyName, EnemyType, EnemyX, EnemyY, NewHP, EnemyNDamage, EnemySDamage)).

/* ENEMY */
/* NORMAL TYPE */
enemy_Attack(1, EnemyType, PlayerType) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    EnemyType==PlayerType,
    NewHP is PlayerHP-NDamage,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage, PlayerInventory)).

enemy_Attack(2, EnemyType, PlayerType) :-
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    EnemyType==PlayerType,
    NewHP is PlayerHP-SDamage,
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage, PlayerInventory)).
/* STRONG TYPE */
enemy_Attack(1, EnemyType, PlayerType) :-
    strong(EnemyType, PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-(NDamage + (2*NDamage)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage, PlayerInventory)).

enemy_Attack(2, EnemyType, PlayerType) :-
    strong(EnemyType, PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    NewHP is PlayerHP-(SDamage + (2*SDamage)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage, PlayerInventory)).
/* WEAK TYPE */
enemy_Attack(1, EnemyType, PlayerType) :-
    weak(EnemyType, PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory),
    enemy(_, EnemyType, _, _, _, NDamage, _),
    NewHP is PlayerHP-(NDamage + (NDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage, PlayerInventory)).

enemy_Attack(2, EnemyType, PlayerType) :-
    weak(EnemyType, PlayerType),
    player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory),
    enemy(_, EnemyType, _, _, _, _, SDamage),
    NewHP is PlayerHP-(SDamage + (SDamage/2)),
    retract(player(PlayerName, PlayerType, PlayerX, PlayerY, PlayerHP, PlayerNDamage, PlayerSDamage, PlayerInventory)),
    asserta(player(PlayerName, PlayerType, PlayerX, PlayerY, NewHP, PlayerNDamage, PlayerSDamage, PlayerInventory)).

battle :- 
    
