-dynamic(player/8).
-dynamic(enemy/7).

/* HP */
hp(naruto, 350).
hp(sakura, 300).
hp(sasuke, 350).
hp(lee, 320).
hp(neji, 300).
hp(choji, 350).
hp(shikamaru, 300).
hp(tenten, 350).
hp(kiba, 300).
hp(shino, 320).
hp(gaara, 330).
hp(deidara, 400).
hp(tobi, 380).
hp(sasori, 400).
hp(itachi, 500).

/* TYPE */
type(naruto, wind).
type(sakura, forest).
type(sasuke, dark).
type(lee, forest).
type(neji, wind).
type(choji, forest).
type(shikamaru, dark).
type(tenten, wind).
type(kiba, wind).
type(shino, dark).
type(gaara, forest).
type(deidara, dark).
type(tobi, dark).
type(sasori, dark).
type(itachi, dark).

/* NORMAL DAMAGE */
dmg(naruto, 30).
dmg(sakura, 25).
dmg(sasuke, 35).
dmg(lee, 28).
dmg(neji, 32).
dmg(choji, 25).
dmg(shikamaru, 30).
dmg(tenten, 32).
dmg(kiba, 30).
dmg(shino, 30).
dmg(gaara, 35).
dmg(deidara, 45).
dmg(tobi, 35).
dmg(sasori, 40).
dmg(itachi, 500).

/* SKILL DAMAGE */
skillDmg(naruto, 190).
skillDmg(sakura, 150).
skillDmg(sasuke, 190).
skillDmg(lee, 150).
skillDmg(neji, 180).
skillDmg(choji, 150).
skillDmg(shikamaru, 180).
skillDmg(tenten, 170).
skillDmg(kiba, 170).
skillDmg(shino, 160).
skillDmg(gaara, 200).
skillDmg(deidara, 250).
skillDmg(tobi, 200).
skillDmg(sasori, 250).
skillDmg(itachi, 280).

/* SKILL NAME */
skillName(naruto, 'Rasengan').
skillName(sakura, 'Cherry Blossom Impact').
skillName(sasuke, 'Chidori').
skillName(lee, 'Leaf Flash Kick').
skillName(neji, 'Eight Trigrams Palms').
skillName(choji, 'Baika no Jutsu').
skillName(shikamaru, 'Shadow Possession').
skillName(tenten, 'Twin Rising Dragons').
skillName(kiba, 'Fang Wolf Fang').
skillName(shino, 'Parasitic Bugs').
skillName(gaara, 'Desert Prison').
skillName(deidara, 'Creative Destruction').
skillName(tobi, 'Kamui').
skillName(sasori, 'Puppet Technique').
skillName(itachi, 'Amaterasu').

/* INVENTORI */
init_Inventory([]).

playerLoc(10,10).
enemyLoc(1,1).

strong(wind, forest).
strong(forest, dark).
strong(dark, wind).

weak(wind, dark).
weak(forest, wind).
weak(dark, forest).

/* Inisialisasi */
init_Player :-
    playerLoc(X,Y),
    hp(naruto, HP),
    dmg(naruto, NDamage),
    skillDmg(naruto, SDamage),
    type(naruto, Type),
    init_Inventory(Inventory),
    asserta(player(naruto, Type, X, Y, HP, NDamage, SDamage, Inventory)).

init_Enemy :-
    enemyLoc(X,Y),
    hp(itachi, HP),
    dmg(itachi, NDamage),
    skillDmg(itachi, SDamage),
    type(itachi, Type),
    asserta(enemy(itachi, Type, X, Y, HP, NDamage, SDamage)).

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


/* Check Status */
print_Status :-
    player(Name, Type, X, Y, HP, NDamage, SDamage, Inventory),
    skillName(Name, SName),
    write('Name : '), write(Name),nl,
    write('Type : '), write(Type),nl,
    write('Loc  : '), write('('), write(X), write(','), write(Y), write(')'),nl,
    write('HP   : '), write(HP),nl,
    write('Dmg  : '), write(NDamage),nl,
    write('Skill: '), write(SName), write(' / '), write(SDamage),nl,
    write('Allies: '),write(Inventory),nl.
print_Status2 :-
    enemy(Name, Type, X, Y, HP, NDamage, SDamage),
    skillName(Name, SName),
    write('Name : '), write(Name),nl,
    write('Type : '), write(Type),nl,
    write('Loc  : '), write('('), write(X), write(','), write(Y), write(')'),nl,
    write('HP   : '), write(HP),nl,
    write('Dmg  : '), write(NDamage),nl,
    write('Skill: '), write(SName), write(' / '), write(SDamage),nl.

start :- 
    init_Player,
    init_Enemy,
    print_Status,
    print_Status2.