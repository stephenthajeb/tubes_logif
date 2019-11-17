 
print_Title :-
    nl,
    write('========================================================='),nl,
    write('NN    N      AA      RRRRR    U      U  TTTTTTT  OOOOO'),nl,
    write('N N   N     A  A     R    R   U      U     T    O     O'),nl,
    write('N  N  N    A----A    R---R    U      U     T   O       O'),nl,
    write('N   N N   A      A   R    R    U    U      T    O     O'),nl,
    write('N    NN  A        A  R     R    UUUU       T     OOOOO'),nl,
    write('========================================================='),nl,
    write('==================HINATA THE LOST GIRL==================='),nl.

print_Story :-
    write('100 tahun lalu di Desa Konoha, terjadi penyerangan yang dilakukan'),nl,
    write('oleh Clan Akatsuki. Penyerangan tersebut menghancurkan Desa Konoha'),nl,
    write('dan seisinya. Beberapa penduduk dapat kabur ke hutan, tapi tidak sedikit'),nl,
    write('mereka yang terbunuh. Naruto yang saat itu masih kecil, berhasil lari ke hutan'),nl,
    write('sendirian. Ia terpisah dari keluarga dan teman-temannya. Tetapi salah satu'),nl,
    write('temannya, yaitu Hinata, berhasil tertangkap oleh Clan Akatsuki.'),nl,
    nl,
    write('Beberapa tahun berlalu, Naruto sudah menjadi ninja yang hebat. Ia bertekad'),nl,
    write('untuk membawa pulang Hinata dari tangan Clan Akatsuki. Di tengah perjalanan'),nl,
    write('Naruto bertemu dengan teman lamanya. Ia mengajak teman-temannya untuk menyelamatkan'),nl,
    write('Hinata, namun mereka malah menantang Naruto bertarung.'),nl,
    nl,
    write('Mengapa teman-teman Naruto malah mengajak ia bertarung ?'),nl,
    write('Berhasilkah Naruto menaklukan Akatsuki dan membawa Hinata pulang ?'),nl,
    nl,
    write('Let the game begin !'),nl, nl.
    
print_Win :-
    write('Y   Y    OOOOO    U      U       W         W  II  NN    N'),nl,
    write(' Y Y    O     O   U      U       W         W  II  N N   N'),nl,
    write('  Y    O       O  U      U       W    W    W  II  N  N  N'),nl,
    write('  Y     O     O    U    U         W  W W  W   II  N   N N'),nl,
    write('  Y      OOOOO      UUUU           WW   WW    II  N    NN'),nl,
    write('========================================================='),nl,
    write('=====================HINATA IS SAFE======================'),nl,
    write('Selamat kau berhasil menyelamatkan Hinata dan membawanya pulang.'),nl,
    write('Tetaplah berlatih untuk menjadi ninja yang hebat dan jangan lupakan'),nl,
    write('teman-temanmu!'),nl.

print_Lose :-
    write('Y   Y    OOOOO    U      U       L       OOOOO     SSSSS  EEEEE'),nl,
    write(' Y Y    O     O   U      U       L      O     O   S       E'),nl,
    write('  Y    O       O  U      U       L     O       O   S--S   E---E'),nl,
    write('  Y     O     O    U    U        L      O     O        S  E'),nl,
    write('  Y      OOOOO      UUUU         LLLLL   OOOOO    SSSSS   EEEEE'),nl,
    write('==============================================================='),nl,
    write('====================BETTER LUCK NEXT TIME======================'),nl,
    write('Sayang sekali misimu telah gagal, namun tekad dalam dirimu akan tetap'),nl,
    write('ada dan terus ada sampai Hinata kembali pulang.'),nl.

/* Interactive Command */

print_InventoryFull :-
    write('Temanmu sudah terlalu banyak. Apakah ingin mengganti teman ? (yes/no)'),nl.
print_Capture :-
    write('Ayo kita cari Hinata dan bawa ia pulang ke Konoha!'), nl.
print_NotCapture :-
    write('Misi ini sangat berbahaya,'),nl,
    write('Aku tidak mau membahayakanmu...'),nl.
print_Run :-
    nl,
    write('Kagebunshin no Jutsu!'),nl,nl,
    write('Berhasil kabur...'),nl.
print_CantRun :-
    nl,
    write('Kagebunshin no Jutsu!'),nl,nl,
    write('. . . . . . .'),nl,nl,
    write('Sial! Aku tidak bisa kabur!'),nl.

print_FoundEnemy :-
    write('Hati-hati ada musuh didepan!'),nl, nl,
    enemy(Name,_,_,_,_,_,_),
    write(Name), write(' muncul secara tiba tiba'),nl.

print_Fight(sakura) :-
    write('Haii. Jangan nangis ya kalau kalah...'),nl.
print_Fight(sasuke) :-
    write('Hahahaha, teman lama. Sudah sekuat apa kau sekarang?'),nl.
print_Fight(lee) :-
    write('Akan aku buktikan hasil latihanku dengan Guru Guy!'),nl.
print_Fight(neji) :-
    write('Hinata.... Lawan aku dulu sebelum kau selamatkan Hinata'),nl.
print_Fight(choji) :-
    write('Nyam nyam nyam... Lewati aku kalau bisa'),nl.
print_Fight(shikamaru) :-
    write('Coba hindari bayanganku kalau bisa!'),nl.
print_Fight(tenten) :-
    write('Guru Guy tidak pernah salah melatih muridnya!'),nl.
print_Fight(kiba) :-
    write('Akamaruu! Seraaaaang!'),nl.
print_Fight(shino) :-
    write('Gooooo Parasitee....!'),nl.
print_Fight(gaara) :-
    write('Masih berani bertarung diatas pasir, huh?!'),nl.
print_Fight(deidara) :-
    write('Ledakan adalah nama tengahku. HAHAHAHAHA'),nl.
print_Fight(tobi) :-
    write('Hancurkan topengku kalau kau bisa!'),nl.
print_Fight(sasori) :-
    write('Jangan pernah remehkan bonekaku. Hahahahaha....'),nl.
print_Fight(itachi) :-
    write('Well well well. Semua pasukanku sudah berhasil kau taklukkan.'),nl,
    write('Tetapi Hinata tetap akan jadi milik Akatsuki!'),nl.

print_BattleTitle :-
    write('=================================================='),nl,
    write('================== BATTLE BEGIN =================='),nl,
    write('=================================================='),nl.

/* Help */

print_Help :-
    write('----------------HELP----------------'),nl,
    write('Ketik command yang tersedia dan akhiri dengan tanda titik (.)'),nl,
    write('w        : Utara'),nl,
    write('a        : Barat'),nl,
    write('s        : Selatan'),nl,
    write('d        : Timur'),nl,
    write('load     : Load game'), nl,
    write('save     : Save game'), nl,
    write('battle   : Masuk '),nl,
    write('run      : Kabur'),nl,
    write('normal   : Menyerang musuh dengan normal attack'),nl,
    write('skill    : Menyerang musuh dengan skill attack'),nl,
    write('capture  : Menambah teman'),nl,
    write('swap     : Mengganti teman'),nl,
    write('status   : Status'),nl,
    write('map      : Perlihatkan peta'),nl,
    write('help     : Help'),nl,
    write('exit     : Keluar Permainan'),nl, nl.

status :-
    inventory(Inventory),
    player(Name, Type, X, Y, HP, NDamage, SDamage),
    skillName(Name, SName),
    write('Name : '), write(Name),nl,
    write('Type : '), write(Type),nl,
    write('Loc  : '), write('('), write(X), write(','), write(Y), write(')'),nl,
    write('HP   : '), write(HP),nl,
    write('Dmg  : '), write(NDamage),nl,
    write('Skill: '), write(SName), write(' / '), write(SDamage),nl,
    write('Allies: '),write(Inventory),nl.

playerstatus :-
    player(Name, Type, _, _, HP, NDamage, SDamage),
    skillName(Name, SName),
    write('===== PLAYER ====='),nl,
    write('Name : '), write(Name),nl,
    write('Type : '), write(Type),nl,
    write('HP   : '), write(HP),nl,
    write('Dmg  : '), write(NDamage),nl,
    write('Skill: '), write(SName), write(' / '), write(SDamage),nl.

enemystatus :-
    enemy(Name, Type, _, _, HP, NDamage, SDamage),
    skillName(Name, SName),
    write('===== ENEMY ====='),nl,
    write('Name : '), write(Name),nl,
    write('Type : '), write(Type),nl,
    write('HP   : '), write(HP),nl,
    write('Dmg  : '), write(NDamage),nl,
    write('Skill: '), write(SName), write(' / '), write(SDamage),nl.

printCommandInvalid :- write('Command tidak valid'),nl.

printInvalidMove :- write('Invalid Move !! Kamu tidak boleh melewat border cuy'),nl.

print_Heal :-
    healStatus(0),
    write('Akhirnya sampai di Medical Center'),nl,
    write('Mau heal teman-teman ? Jika mau ketik "heal."'),nl,!.
print_Heal :-
    healStatus(1),
    write('Keluar !!!!'),nl,
    write('Fasilitas ini hanya bisa digunakan sekali :('),nl,!.

printSkillUsed :- write('Skill hanya bisa digunakan sekali cuy dalam battle ini'),nl.

printKO :- player(PlayerName, _,_,_,_,_,_),
           write(PlayerName),
           write(' is defeated '),nl,
           write('Aku terlalu lemah untuk menyelamatkan Hinata'),nl,
           write('Silahkan assign new player dari inventory'),nl.

print_Inventory([]):- !.
print_Inventory([H|T]):-
    write('- '),
    print(H),nl,
    print_Inventory(T).
print_Invalid:-
    write(' Masukan tidak Valid, Silahkan masukkan kembali '),nl.

print_Invalid_Collision(Input):-
    \+(Input==run),\+(Input==attack),
    print_Invalid,!.

print_Invalid_Collision(_).

print_InvalidYes(Input,ListInventory):-
    check(ListInventory,Input),
    print_Invalid,
    !.

print_InvalidYes(_,_).

print_InvalidCapture(Input):-
    \+(Input==yes),\+(Input==no),
    print_Invalid,
    !.

print_InvalidCapture(_).

print_InvalidCapture1(Input):-
    \+(Input==capture),\+(Input==no),
    print_Invalid,
    !.
print_InvalidCapture1(_).

print_InvalidAttack(Input):-
    \+(Input==normal),\+(Input==skill),
    print_Invalid,
    !.
print_InvalidAttack(_).

print_InvalidCommand(Input):-
    \+(Input==w),\+(Input==a),\+(Input==s),\+(Input==d),\+(Input==status),\+(Input==map),\+(Input==help),\+(Input==exit),
    print_Invalid,
    !.
print_InvalidCommand(_).