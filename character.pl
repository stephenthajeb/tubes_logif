:-dynamic(player/7).
:-dynamic(enemy/7).

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
type(itachi, fire).

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
inventory([naruto, sasuke, sakura]).

strong(dark, fire).
strong(fire, wind).
strong(wind, earth).
strong(earth, physical).
strong(physical, lightning).
strong(lightning, dark).

/*
weak(wind, dark).
weak(forest, wind).
weak(dark, forest).
*/

/* Inisialisasi */
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

move_Player :-
    player(Name, Type, X, Y, HP, NDamage, SDamage),
    playerLoc(NewX, NewY),
    retract(player(Name, Type, X, Y, HP, NDamage, SDamage)),
    asserta(player(Name, Type, NewX, NewY, HP, NDamage, SDamage)),
    print_PlayerStatus.