-dynamic(player/6).

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

/* SKILL DAMAGE*/
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

/* INVENTORI */
init_Inventory([]).

/* Inisialisasi */
init_Player :-
    playerLoc(X,Y),
    hp(naruto, HP),
    dmg(naruto, Damage),
    skillDmg(naruto, SkillDamage),
    init_Inventory(Inventory),
    asserta(player(X, Y, HP, Damage, SkillDamage, Inventory)).

print_stats :-
    player(X, Y, HP, Damage, SkillDamage, Inventory),
    write(X),
    write(Y),
    write(HP),
    write(Damage),
    write(SkillDamage),
    write(Inventory).
