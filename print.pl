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
    write('Temanmu sudah terlalu banyak. Apakah ingin mengganti teman ?'),nl.
print_Capture :-
    write('Ayo kita cari Hinata dan bawa ia pulang ke Konoha!'), nl.
print_NotCapture :-
    write('Mission ini sangat berbahaya,'),nl,
    write('Aku tidak mau membahayakan kamu dengan melibatkanmu'),nl.
print_Run :-
    write('Kagebunshin no Jutsu!'),nl,
    write('Berhasil kabur...'),nl.
print_CantRun :-
    write('Kagebunshin no Jutsu!'),nl,
    write('..........'),nl,
    write('Sial! Aku tidak bisa kabur!'),nl.

print_FoundEnemy :-
    write('Hati-hati ada musuh didepan!'),nl, nl,
    enemy(Name,_,_,_,_,_,_),
    write(Name), write(' muncul secara tiba tiba'),nl,nl,
    write('Pilih bertarung atau lari ?'),nl.

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
    write('Hancurkan topengku kalah kau bisa!'),nl.
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
    write('w    : Utara'),nl,
    write('a    : Barat'),nl,
    write('s    : Selatan'),nl,
    write('d    : Timur'),nl,
    write('attack  : Attack'),nl,
    write('run  : Kabur'),nl,
    write('capture  : Menambah teman'),nl,
    write('del  : Melepas teman'),nl,
    write('status : Status'),nl,
    write('map  : Perlihatkan peta'),nl,
    write('save : Save'),nl,
    write('load : Load'),nl,
    write('help : Help'),nl,
    write('exit : Keluar Permainan'),nl, nl.

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

enemystatus :-
    enemy(Name, Type, X, Y, HP, NDamage, SDamage),
    skillName(Name, SName),
    write('Name : '), write(Name),nl,
    write('Type : '), write(Type),nl,
    write('Loc  : '), write('('), write(X), write(','), write(Y), write(')'),nl,
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
    write('keluar'),
    write('Fasilitas ini hanya bisa digunakan sekali :('),nl,!.
