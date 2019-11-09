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
    write('Let the game begin !'),nl.
    
print_Win :-
    write('Y   Y    OOOOO    U      U       W         W  II  NN    N'),nl,
    write(' Y Y    O     O   U      U       W         W  II  N N   N'),nl,
    write('  Y    O       O  U      U       W    W    W  II  N  N  N'),nl,
    write('  Y     O     O    U    U         W  W W  W   II  N   N N'),nl,
    write('  Y      OOOOO      UUUU           WW   WW    II  N    NN'),nl,
    write('========================================================='),nl,
    write('=====================HINATA IS SAFE======================'),nl.

print_Lose :-
    write('Y   Y    OOOOO    U      U       L       OOOOO     SSSSS  EEEEE'),nl,
    write(' Y Y    O     O   U      U       L      O     O   S       E'),nl,
    write('  Y    O       O  U      U       L     O       O   S--S   E---E'),nl,
    write('  Y     O     O    U    U        L      O     O        S  E'),nl,
    write('  Y      OOOOO      UUUU         LLLLL   OOOOO    SSSSS   EEEEE'),nl,
    write('==============================================================='),nl,
    write('====================BETTER LUCK NEXT TIME======================'),nl.

print_all :-
    print_Title,
    print_Story,
    print_Win,
    print_Lose.