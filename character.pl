:-dynamic(player/7).
:-dynamic(enemy/7).
:-dynamic(inventory/1).
:-dynamic(currHP/1).

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
type(naruto,wind).
type(sakura, physical).
type(sasuke, lightning).
type(lee, earth).
type(neji, physical).
type(choji, earth).
type(shikamaru, dark).
type(tenten, wind).
type(kiba, wind).
type(shino, dark).
type(gaara, earth).
type(deidara, fire).
type(tobi, dark).
type(sasori, dark).
type(itachi,dark).

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
dmg(itachi, 50).

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
inventory([naruto]).

/* CURRENT HP */
currHP([350]). 

/* TYPE EFFECT */
strong(dark, fire).
strong(fire, wind).
strong(wind, earth).
strong(earth, physical).
strong(physical, lightning).
strong(lightning, dark).

/* INISIALISASI */
init_Player :-
    playerLoc(X,Y),
    hp(naruto, HP),
    dmg(naruto, NDamage),
    skillDmg(naruto, SDamage),
    type(naruto, Type),
    asserta(player(naruto, Type, X, Y, HP, NDamage, SDamage)).

init_Enemy :-
    enemyLoc(X,Y),
    hp(itachi, HP),
    dmg(itachi, NDamage),
    skillDmg(itachi, SDamage),
    type(itachi, Type),
    asserta(enemy(itachi, Type, X, Y, HP, NDamage, SDamage)).

assign_Enemy(X,Y,Name) :-
    hp(Name, HP),
    dmg(Name, NDamage),
    skillDmg(Name, SDamage),
    type(Name, Type),
    asserta(enemy(Name, Type, X, Y, HP, NDamage, SDamage)).

select(Name) :-
    inventory(Friends),
    select_Player(Name,Friends,NewFriends),
    assign_Player(Name),
    retract(inventory(Friends)),
    asserta(inventory(NewFriends)).

assign_Player(Name) :-
    retractall(skillStatusP(_)),
    asserta(skillStatusP(0)),
    inventory(ListName),
    currHP(ListHP),
    checkHP(ListName,ListHP,Name,NewHP),
    select_Player(NewHP,ListHP,NewListHP),
    retract(currHP(ListHP)),
    asserta(currHP(NewListHP)),
    type(Name,NewType),
    dmg(Name,NewNDamage),
    skillDmg(Name,NewSDamage),
    player(NamaOld, Type, X, Y, HP, NDamage, SDamage),
    retract(player(NamaOld, Type, X, Y, HP, NDamage, SDamage)),
    asserta(player(Name, NewType, X, Y, NewHP, NewNDamage, NewSDamage)).

yes:-
    write('Siapa yang ingin kamu ganti?'),nl,
    read(Masukan),nl,
    inventory(ListInventory1),
    currHP(ListHP1),
    checkHP(ListInventory1,ListHP1,Masukan,HP),
    call(select_Player(Masukan,ListInventory1,ListInventory)),
    call(select_Player(HP,ListHP1,ListHP)),
    print(Masukan),
    write(' : Terimakasih teman sudah memberikan petualangan ini! '),nl,
    enemy(Nama,_,_,_,_,_,_),
    select(Nama),
    hp(Nama, HP1),
    NewInventory = [Nama|ListInventory],
    NewHP = [HP1|ListHP],
    retractall(inventory(_)),
    retractall(currHP(_)),
    asserta(inventory(NewInventory)),
    asserta(currHP(NewHP)).

no:-
    player(Nama, _, _, _, _, _, _),
    print_NotCapture,
    print(Nama),
    write(' : Ayo kawan cepat bergegas! Masih banyak musuh yang menanti! '),nl.

capture:-
    inventory(ListInventory),
    isFullInventory(ListInventory),
    print_InventoryFull,!,
    read(Input),call(Input).

capture:-
    currHP(ListHP),
    inventory(ListInventory),
    enemy(Name,_,_,_,_,_,_),
    hp(Name, HP),
    NewInventory = [Name|ListInventory],
    NewHP = [HP|ListHP],
    retract(inventory(ListInventory)),
    retract(currHP(ListHP)),
    asserta(inventory(NewInventory)),
    asserta(currHP(NewHP)).

/* MOVE PLAYER */
move_Player :-
    player(Name, Type, X, Y, HP, NDamage, SDamage),
    playerLoc(NewX, NewY),
    retract(player(Name, Type, X, Y, HP, NDamage, SDamage)),
    asserta(player(Name, Type, NewX, NewY, HP, NDamage, SDamage)).

