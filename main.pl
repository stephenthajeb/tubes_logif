:- include('print.pl').
:- include('map.pl').

help :-
    write('Command-command yang tersedia'),nl,
    write('Masukkin nomor command untuk menggunakan command'),nl,
    write('[ 1]Mulai Permainan'),nl,
    write('[ 2]Barat'),nl,
    write('[ 3]Timur'),nl,
    write('[ 4]Utara'),nl,
    write('[ 5]Selatan'),nl,
    write('[ 6]Tunjukkin arah mata angin dong'),nl,
    write('[ 7]Attack'),nl,
    write('[ 8]Kabur'),nl,
    write('[ 9]Menambah anggota mission'),nl,
    write('[10]Melepas anggota mission'),nl,
    write('[11]Status'),nl,
    write('[12]Perlihatkan peta'),nl,
    write('[13]Keluar Permainan'),nl.

startProgram :- print_Title,print_Story,help,
                repeat,
                read(X),inputCmd(X),
                X == 1.

/*Aksi terhadap input help*/
inputCmd(X) :- X=1,init,map,!.
inputCmd(X) :- X=2,west,!.
inputCmd(X) :- X=3,east,!.
inputCmd(X) :- X=4,north,!.
inputCmd(X) :- X=5,south,!.
inputCmd(X) :- X=6,printArah,!.
inputCmd(X) :- X=12,map,!.