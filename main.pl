:- include('print.pl').
:- include('map.pl').

/*Untuk menunjukkan apakah pemain pernah menekan command [1]*/
:-dynamic(startStatus/1). 

start :- asserta(startStatus(0)),print_Title,print_Story,help,
                repeat,
                    printInputCommand,
                    read(X),inputCmd(X),
                X = 1.
help :- print_Help.


/*Aksi terhadap command*/
inputCmd(X) :- X=1,init,map,retract(startStatus(0)),asserta(startStatus(1)),gameOnGoing.
inputCmd(X) :- X>0,X<17,X\==6,X\==12,X\==14,X\==15,X\==16,startStatus(0),write('command ini hanya bisa dipakai setelah permainan dimulai'),nl,!.
inputCmd(X) :- X=2,west,!.
inputCmd(X) :- X=3,east,!.
inputCmd(X) :- X=4,north,!.
inputCmd(X) :- X=5,south,!.
inputCmd(X) :- X=6,printArah,!.
inputCmd(X) :- X=12,map,!.
inputCmd(X) :- X=15,help,!.
inputCmd(X) :- X=16,
               write('Yahhh, Hinatanya g jadi diselamatin dong'),nl,
               halt,!.
/*Ini masih aneh*/
inputCmd(X) :- X\==2,X\==3,X\==4,X\==5,printInvalid,!.
/* inputCmd(X) :- Sisany */

gameOnGoing :-  repeat,
                    printInputCommand,                
                    read(X),X\==1,inputCmd(X),
                X=16. 
                /*Tambahin syarat jika kalah gama assert startStatus(0)*/
