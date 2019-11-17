## TUGAS BESAR LOGIKA KOMPUTASIONAL (IF2121) ##

====== NARUTO SHIPPUDEN : HINATA THE LOST GIRL =====

Kelompok 1 / K03 :
1. Abdul Aziz Alghifari				10118021
2. Daffa Pratama Putra 				13518033
3. Muchammad Ibnu Sidqi 			13518072
4. M. Mirza Fathan Al Arsyad		13518111
5. Stephen Thajeb	 				13518150

    Game ini merupakan permainan mini adventure yang dibuat berbasis bahasa ProLog.
Permainan ini secara garis besar mirip dengan game Pokemon/Tokemon yang diberikan
sebagai contoh tugas besar. Kami mengubah alur cerita dan tokoh-tokoh didalamnya
sekreatif kami tanpa melenceng dari garis besar spesifikasi yang ada.

GOAL : Mengalahkan semua Clan Akatsuki dan menyelamatkan Hinata 
Win State : Clan Akatsuki kalah dan Hinata berhasil diselamatkan
Lose State : Naruto dan semua teman(pengikut)nya mati

Command yang tersedia di dalam game :
- start.    : untuk menjalankan permainan pertama kali.
- w.        : bergerak ke arah utara/atas.
- a.        : bergerak ke arah kiri/barat.
- s.        : bergerak ke arah selatan/bawah.
- d.        : bergerak ke arah timur/kanan.
- load.     : membuka hasil penyimpanan game.
- save.     : menyimpan game.
- battle.   : bertarung melawan musuh.
- run.      : kabur dari musuh.
- normal.   : menyerang musuh dengan serangan normal.
- skill.    : menyerang musuh dengan serangan spesial/skill.
- capture.  : menambah teman.
- swap.     : mengganti teman (hanya bisa digunakan saat inventory penuh).
- status.   : melihat status pemain.
- map.      : memperlihatkan map terkini.
- help.     : memperlihatkan command yang bisa dijalankan.
- exit.     : keluar dari permainan.

## AWAL GAME ##
Inisiasi player awal sebagai Naruto dengan status :
Nama    : naruto
Type    : wind
Location: (1,1)
HP      : 350
Damage  : 30
Skill   : Rasengan / 190
Inventoy: [naruto]

## GAME BERJALAN ##
Pemain hanya bisa bergerak di antara koordinat (1,1) hingga (10,10).
Untuk berpindah lokasi, pemain dapat memilih command 'w a s d'. Pada
peta terdapat Medical Station yang berada pada (6,4). Pemain hanya bisa
menggunakannya sekali selama permainan.

Setiap mengalahkan 3 musuh, akan muncul akatsuki pertama.
Setiap mengalahkan 7 musuh, akan muncul akatsuki kedua.
Setiap mengalahkan 10 musuh, akan muncul akatsuki ketiga.
Ketika ketiga akatsuki kalah, akan muncul big boss yaitu itachi.
Pemain harus mengalahkan itachi untuk menyelamatkan hinata.

Medical Station bisa digunakan untuk menyembuhkan semua teman, tetapi hanya
bisa digunakan sekali selama permainan berlangsung.