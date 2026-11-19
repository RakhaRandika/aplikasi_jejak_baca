-- 20 buku Indonesia terbitan 2023 ke atas yang ada di Open Library (openlibrary.org).
-- Deskripsi: paragraf awal adalah sinopsis dari Open Library (hanya dirapikan: bagian promosi
-- dibuang dan typo hasil scan diperbaiki), lalu ditambah beberapa paragraf tanpa bocoran
-- tentang penulis, tema, dan gaya buku (sebagian dari riset ulasan di Gramedia, Goodreads,
-- Detik, dan jurnal kampus). Cover dari covers.openlibrary.org.
-- Sumber sinopsis per buku:
--   Bandung Menjelang Pagi               : https://openlibrary.org/works/OL43313265W (bagian promosi dibuang)
--   Sisi Tergelap Surga                  : https://openlibrary.org/works/OL43313318W (bagian promosi dibuang)
--   23:59                                : https://openlibrary.org/works/OL43313462W (asli)
--   Seporsi Mie Ayam Sebelum Mati        : https://openlibrary.org/works/OL42830484W (asli)
--   Anjing Mengeong, Kucing Menggonggong : https://openlibrary.org/works/OL42609631W (asli)
--   Teruslah Bodoh Jangan Pintar         : https://openlibrary.org/works/OL37900765W (asli)
--   Tanah Para Bandit                    : https://openlibrary.org/works/OL36896697W (asli)
--   Aldebaran                            : https://openlibrary.org/works/OL43816748W (asli)
--   Hana-Tara-Hata                       : https://openlibrary.org/works/OL43816784W (asli)
--   Sendiri                              : https://openlibrary.org/works/OL39364710W (asli)
--   Sebelas                              : https://openlibrary.org/works/OL43816761W (asli)
--   Bungkam Suara                        : https://openlibrary.org/works/OL42658163W (asli)
--   Perkumpulan Anak Luar Nikah          : https://openlibrary.org/works/OL38005386W (asli)
--   Timun Jelita                         : https://openlibrary.org/works/OL42380281W (typo diperbaiki)
--   Perempuan Pemanggul Jenazah          : https://openlibrary.org/works/OL43702853W (asli)
--   Ngomongin Uang                       : https://openlibrary.org/works/OL46093648W (tips membaca umum dibuang)
--   Yang Kamu Belum Tahu Soal Palestina  : https://openlibrary.org/works/OL38849977W (typo diperbaiki)
--   Mata Keramat                         : https://openlibrary.org/works/OL43883028W (asli)
--   Flâneur                              : https://openlibrary.org/works/OL42522190W (asli)
--   Matahari di Balik Bukit Partisan     : https://openlibrary.org/works/OL43825292W (asli)
--
-- PERHATIAN: TRUNCATE di bawah menghapus semua buku DAN semua isi rak (jejak_baca)
-- karena jejak_baca mengacu ke buku. Akun (users) tidak terhapus.

ALTER TABLE buku ADD COLUMN IF NOT EXISTS cover_url TEXT;
ALTER TABLE buku DROP COLUMN IF EXISTS rangkuman;
ALTER TABLE buku DROP COLUMN IF EXISTS isi;

TRUNCATE TABLE buku RESTART IDENTITY CASCADE;

INSERT INTO buku (judul, penulis, penerbit, tahun_terbit, deskripsi, cover_url) VALUES
($$Bandung Menjelang Pagi$$,
 $$Brian Khrisna$$,
 $$Mediakita$$,
 $$2024$$,
 $$Menjelang pagi, Bandung berubah menjadi kota yang tak lagi sama. Malam terasa sangat panjang dan lebih mencekam dari kelam. Para bandit, pemadat, tukang judi, bocah geng motor, begundal grafiti, semuanya berkeliaran bak tikus-tikus ketika air got meluap. Di kota ini, Dipha adalah bocah berandalan yang mampu mengerjakan apa saja. Berjualan bacang di Asia Afrika, pelayan kafe di Braga, buruh angkut kertas di Pajagalan, ataupun buruh kain di Tamin. Apa pun ia lakukan untuk bertahan hidup. Kemampuannya untuk mengerjakan apa saja itu membawanya bertemu dengan seorang gadis misterius bernama Vinda yang ngotot minta dicarikan tempat tinggal dengan segala syarat yang tak masuk akal. Seperti dipermainkan oleh takdir, satu-satunya tempat yang tersedia adalah kontrakan petak yang terletak tepat di seberang kontrakan Dipha. Mau tidak mau, Vinda akhirnya menempati kontrakan itu. Vinda yang sangat mencintai Bandung begitu bertolak belakang dengan Dipha yang sudah mengenal betapa bobroknya kota itu ketika menjelang pagi. Asia Afrika, Braga, Dago, Kalipah Apo, Astana Anyar, Banceuy, Jalan ABC, dan seluruh jalan-jalan tikus di Kota Bandung menjadi saksi tumbuhnya perasaan di antara keduanya. Namun, sayangnya mereka berdua kerap lupa, bahwa sejatinya, oleh-oleh paling khas dari Kota Bandung adalah: patah hati.

Brian Khrisna adalah penulis asal Bandung. Dalam catatan penulis di salah satu bukunya, ia menyebut karya-karyanya antara lain Merayakan Kehilangan (2016), The Book of Almost (2018), Kudasai (2019), This is Why I Need You (2019), Museum of Broken Heart (2020), Parable (2021), serta 23:59 dan The Matchbreaker (2023).

Bandung Menjelang Pagi diterbitkan Mediakita pada tahun 2024. Sesuai judulnya, novel ini memadukan kisah cinta dengan potret Kota Bandung dari sisi yang jarang terlihat wisatawan: orang-orang yang bekerja serabutan, jalanan malam, dan kehidupan di kontrakan petak. Tempat-tempat terkenal seperti Asia Afrika, Braga, dan Dago menjadi latar yang hidup sepanjang cerita.

Gaya penulisan Brian Khrisna dikenal ringan dan jenaka, dengan dialog sehari-hari yang terasa dekat. Namun di balik humor itu, novel ini juga membicarakan kerasnya hidup orang-orang di pinggiran kota dan kenyataan bahwa tidak semua rencana berjalan sesuai harapan.

Buku ini cocok bagi pembaca yang menyukai kisah romansa dengan latar kota yang kuat, terutama mereka yang mengenal atau mencintai Bandung.$$,
 $$https://covers.openlibrary.org/b/id/15044646-L.jpg$$),
($$Sisi Tergelap Surga$$,
 $$Brian Khrisna$$,
 $$Gramedia Pustaka Utama$$,
 $$2023$$,
 $$Jakarta kerap menjadi pelabuhan bagi mereka yang datang membawa sekoper harapan. Mereka yang siap bertaruh dengan nasibnya sendiri-sendiri. Namun, kota ini selalu mampu melumat habis harapan dan menukarnya dengan keputusasaan. Pemulung, pengamen, pramuria yang menjajakan tubuh agar anaknya bisa makan, pemimpin-pemimpin kecil yang culas, lelaki tua di balik kostum badut ayam, pencuri motor yang ingin membeli obat untuk ibunya, remaja yang melumuri tubuh dengan cat perak, hingga mereka yang bergelut di terminal setelah terpaksa merelakan impiannya habis digerus kejinya ibu kota. Di Jakarta, semua orang dipaksa bergelut dan bertempur demi bisa hidup dari hari ke hari. Dan di kampung inilah semua itu dimulai. Sebuah cerita tentang kehidupan orang-orang yang hidup di sisi tergelap surga kota bernama Jakarta...

Dari penulis: 25 tahun hidup sebagai anak penjual nasi di pinggir jalan membuatku akrab dengan hal-hal yang jarang sekali diketahui orang. Tentang pengemis yang memiliki penghasilan lebih besar dari UMR ibu kota, permainan alih kuasa dan perizinan jualan dengan berbagai pihak, hingga tentang pergaulan dan geliat kehidupan mereka yang hidup dari hari ke hari tanpa jaminan masa depan yang pasti. Oleh sebab itu, menulis buku ini rasa-rasanya membawaku kembali pada nostalgia, tentang kehidupan yang rumit tetapi sebenarnya dialami oleh sebagian dari kita. Buku ini kubuat apa adanya, menggambarkan apa yang pernah kulihat, beberapa yang pernah kualami, dan pengalaman-pengalaman teman seperjuangan yang sekarang sudah entah di mana. Kuharap buku ini bisa menjadi sebuah jendela bagi kita untuk melihat kehidupan yang lain namun dekat. Sebuah cerita fiksi tentang bagaimana hebatnya kemampuan manusia untuk tetap bertahan hidup, apa pun situasinya.

Brian Khrisna adalah penulis asal Bandung. Dalam catatan penulis di salah satu bukunya, ia menyebut karya-karyanya antara lain Merayakan Kehilangan (2016), The Book of Almost (2018), Kudasai (2019), This is Why I Need You (2019), Museum of Broken Heart (2020), Parable (2021), serta 23:59 dan The Matchbreaker (2023).

Sisi Tergelap Surga diterbitkan Gramedia Pustaka Utama pada tahun 2023. Berbeda dari banyak karyanya yang bernuansa romansa, novel ini memotret kehidupan orang-orang kecil di sebuah kampung di Jakarta: pemulung, pengamen, pencuri motor, hingga orang-orang yang bertahan hidup dari hari ke hari tanpa jaminan masa depan.

Seperti yang ia ceritakan sendiri, penulis tumbuh sebagai anak penjual nasi di pinggir jalan, sehingga banyak gambaran dalam novel ini berangkat dari pengamatan dan pengalaman nyata. Hal ini membuat ceritanya terasa jujur dan dekat dengan kenyataan.

Tema utama buku ini adalah ketahanan manusia dalam menghadapi kemiskinan dan ketidakadilan kota besar. Buku ini cocok bagi pembaca yang menyukai fiksi realis tentang kehidupan urban dan orang-orang yang jarang mendapat sorotan.$$,
 $$https://covers.openlibrary.org/b/id/15044690-L.jpg$$),
($$23:59$$,
 $$Brian Khrisna$$,
 $$Kawah Media$$,
 $$2023$$,
 $$Tidak ada yang lebih menyakitkan ketimbang hubungan yang berakhir dengan penuh tanda tanya. Ketika kamu harus dipaksa ikhlas atas perpisahan yang terjadi tanpa kamu tahu apa yang salah dari hubunganmu kemarin. Lalu, kamu akan melewati hari demi hari dengan terus menyalahkan diri sendiri. Apa kurangku? Apakah dia tidak bahagia bersamaku? Apakah aku tidak cukup untuknya? Itulah perasaan yang selama ini Ami derita. Seorang gadis cantik yang dipaksa harus merelakan hubungannya bersama Raga berakhir, tanpa ada sedikitpun penjelasan yang dia dapatkan. Trauma, depresi, kantung mata, rambut rontok, dan segala macam obat tidur harus dilaluinya pasca perpisahan terkutuk itu. Meski sulit, perjalanan penuh luka itu akhirnya membawanya ditemukan oleh seseorang yang baru. Yang lebih mencintainya. Yang tak pernah sekali pun pergi meninggalkannya. Ami perlahan mulai bisa mengikhlaskan Raga. Namun, dua hari sebelum pernikahannya, Raga-lelaki yang selama ini diam-diam masih dicintainya-tiba-tiba hadir di keadaan yang benar-benar membuat Ami merasa hampir setengah gila. Seketika itu juga, semua usaha Ami untuk akhirnya bisa ikhlas, tiba-tiba sirna begitu saja. Apakah pada akhirnya Ami berhasil menemukan jawaban atas segala pertanyaannya selama ini? Lantas, apakah Ami akan kembali bersama Raga, lelaki yang sudah melukainya teramat dalam, namun juga masih menjadi segala doa yang kerap ia layangkan dalam diam?

Brian Khrisna adalah penulis asal Bandung. Dalam catatan penulis di salah satu bukunya, ia menyebut karya-karyanya antara lain Merayakan Kehilangan (2016), The Book of Almost (2018), Kudasai (2019), This is Why I Need You (2019), Museum of Broken Heart (2020), Parable (2021), serta 23:59 dan The Matchbreaker (2023).

23:59 terbit pada tahun 2023 melalui Kawah Media. Novel ini berfokus pada perasaan seseorang yang ditinggalkan tanpa penjelasan, dan bagaimana luka itu terus membayangi bahkan ketika hidup sudah mulai bergerak maju.

Tema yang diangkat dekat dengan banyak pembaca muda: patah hati, trauma setelah putus, kebiasaan menyalahkan diri sendiri, dan keraguan ketika masa lalu kembali di saat yang paling tidak tepat. Brian Khrisna menuliskannya dengan bahasa yang lugas dan emosional.

Buku ini cocok bagi pembaca yang menyukai novel romansa dengan konflik batin yang kuat dan pertanyaan tentang ikhlas, memaafkan, dan memilih.$$,
 $$https://covers.openlibrary.org/b/id/15044823-L.jpg$$),
($$Seporsi Mie Ayam Sebelum Mati$$,
 $$Brian Khrisna$$,
 $$Gramedia Widiasarana Indonesia$$,
 $$2025$$,
 $$Ale, seorang pria berusia 37 tahun memiliki tinggi badan 189 cm dan berat 138 kg. Badannya bongsor, berkulit hitam, dan memiliki masalah dengan bau badan. Sejak kecil, Ale hidup di lingkungan keluarga yang tidak mendukungnya. Ia tak memiliki teman dekat dan menjadi korban perundungan di sekolahnya. Ale didiagnosis psikiaternya mengalami depresi akut. Bukannya Ale tidak peduli untuk memperbaiki dirinya sendiri, ia peduli. Ale telah berusaha mengatasi masalah-masalah yang timbul dari dirinya agar ia diterima di lingkungan pertemanan. Namun usahanya tidak pernah berhasil. Bahkan keluarganya pun tidak mendukungnya saat Ale membutuhkan sandaran dan dukungan. Atas itu semua, Ale memutuskan untuk mati. Ia mempersiapkan kematiannya dengan baik. Agar ketika mati pun, Ale tidak banyak merepotkan orang. Dua puluh empat jam dari sekarang, ia akan menelan obat antidepresan yang dia punya sekaligus. Sebelum waktu itu tiba, Ale membersihkan apartemennya yang berantakan, makan makanan mahal yang tak pernah ia beli, pergi berkaraoke dan menyanyi sepuasnya hingga mabuk. Saat 24 jam itu tiba, Ale telah bersiap dengan kemeja hitam dan celana hitam, bak baju melayat ke pemakamannya sendiri. Ia kenakan topi kecurut ulang tahun dan meletuskan konfeti yang ia beli untuk dirinya sendiri. “Selamat ulang tahun yang terakhir, Ale.” Ale siap menenggak seluruh obat antidepresan yang ia punya. Saat ia memain-mainkan botolnya, Ale terdiam saat membaca anjuran di kemasan botol itu, dikonsumsi sesudah makan. Seketika perutnya berbunyi. Dan Ale pun memutuskan untuk makan dulu sebelum mengakhiri hidupnya. Setidaknya, itu akan menjadi satu-satunya keputusan yang bisa dia ambil atas kehendaknya sendiri. Setelah selama hidupnya ia tak pernah mampu melakukan hal-hal yang ia inginkan. Ale akan makan seporsi mie ayam sebelum mati.

Seporsi Mie Ayam Sebelum Mati adalah novel karya Brian Khrisna yang diterbitkan Gramedia Widiasarana Indonesia. Penulisnya berasal dari Bandung dan lahir pada 17 Januari 1992. Sebelum buku ini, ia sudah menulis antara lain Sisi Tergelap Surga dan Bandung Menjelang Pagi. Novel ini kemudian menjadi perbincangan luas karena dibaca sebagai cerita tentang kesehatan mental yang disampaikan dengan gaya yang ringan.

Ulasan yang membahas buku ini menyebut nada penulisannya ringan, jenaka, dan satir, ciri khas Brian Khrisna, meski kali ini dengan kedalaman yang berbeda dari karya-karyanya sebelumnya. Kombinasi humor dan tema yang gelap inilah yang membuat banyak pembaca merasa buku ini dekat dengan pengalaman sehari-hari, terutama bagi mereka yang pernah merasa tidak terlihat atau tidak cukup baik.

Novel ini juga sudah diumumkan akan diadaptasi menjadi film, sehingga banyak orang yang ingin membaca versi bukunya terlebih dahulu.

Karena temanya menyentuh isu bunuh diri dan harga diri yang rendah, buku ini sebaiknya dibaca dengan hati-hati dan bukan pengganti bantuan profesional. Bila kamu atau orang di sekitarmu sedang berada di titik yang berat, mencari bantuan dari tenaga kesehatan jiwa atau orang yang dipercaya adalah langkah yang penting.$$,
 $$https://covers.openlibrary.org/b/id/15268683-L.jpg$$),
($$Anjing Mengeong, Kucing Menggonggong$$,
 $$Eka Kurniawan$$,
 $$Gramedia Pustaka Utama$$,
 $$2024$$,
 $$“Berbuatlah sedikit dosa, Jamal,” kata Sato Reang kepada satu kawan sekelasnya. Jamal anak yang saleh, selalu sembahyang lima kali sehari, juga rajin mengaji. “Pahalamu sudah banyak. Bertumpuk-tumpuk. Tak akan habis dikurangi timbangan dosamu.” Ini kisah Sato Reang. Kadang ia demikian intim dengan dirinya, sehingga ini merupakan cerita tentang aku, tapi kali lain ia tercerabut, dan ini menjadi kisah tentang Sato Reang. Isi kepalanya riuh dan berisik, terutama sejak ia berumur tujuh tahun, ketika sang ayah berkata kepadanya, “Sudah saatnya kau menjadi anak saleh.”

Anjing Mengeong, Kucing Menggonggong adalah karya terbaru Eka Kurniawan yang diterbitkan Gramedia Pustaka Utama pada Agustus 2024. Karya ini berbentuk novela, yaitu fiksi yang lebih pendek daripada novel, dengan tebal sekitar 133 halaman. Judul bahasa Inggrisnya adalah The Dog Meows, The Cat Barks, dan edisi bahasa Inggrisnya akan diterbitkan oleh New Directions di Amerika Serikat.

Eka Kurniawan adalah salah satu penulis Indonesia yang paling dikenal di dunia internasional. Ia menulis Cantik Itu Luka dan Lelaki Harimau, yang terbit dalam bahasa Inggris sebagai Beauty Is a Wound dan Man Tiger. Lelaki Harimau masuk daftar panjang Man Booker International Prize. Novelnya Seperti Dendam, Rindu Harus Dibayar Tuntas kemudian diadaptasi menjadi film yang memenangkan penghargaan bergengsi di Festival Film Locarno. Karena itu, setiap karya barunya selalu ditunggu pembaca di dalam dan luar negeri.

Novela ini berpusat pada tokoh bernama Sato Reang, seorang remaja yang bergulat dengan pencarian jati dirinya. Sumber ulasan menggambarkan karya ini sebagai cerita tentang pergolakan batin remaja yang mencari identitas, dengan latar yang dekat dengan kematian. Tokoh lain bernama Barseso juga muncul dan menjadi bagian penting dari dunia cerita. Judul yang tampak mustahil, anjing yang mengeong dan kucing yang menggonggong, memberi isyarat bahwa dunia di dalamnya tidak berjalan sebagaimana aturan biasa.

Seperti karya-karya Eka sebelumnya, tulisannya memadukan realitas dengan unsur yang ganjil, humor yang getir, dan perhatian terhadap hal-hal yang kerap disembunyikan masyarakat. Karena bentuknya pendek, novela ini lebih mudah dibaca dalam sekali atau dua kali duduk dibandingkan novel-novelnya yang tebal. Bagi pembaca yang baru ingin mengenal Eka Kurniawan, ini bisa menjadi pintu masuk yang tidak terlalu berat.

Beberapa ulasan menyebut karya ini lebih tenang dan lebih padat dibanding karya-karya epiknya. Kamu tidak perlu membaca buku-bukunya yang lain untuk menikmatinya, tetapi pembaca yang sudah mengenal gaya Eka mungkin akan menangkap lebih banyak lapisan makna.$$,
 $$https://covers.openlibrary.org/b/id/14846599-L.jpg$$),
($$Teruslah Bodoh Jangan Pintar$$,
 $$Tere Liye$$,
 $$Sabak Grip Nusantara$$,
 $$2024$$,
 $$Saat hukum dan kekuasaan dipegang oleh serigala-serigala buas berbulu domba. Saat seluruh negeri dikangkangi orang-orang jualan sok sederhana tapi sejatinya serakah. Apakah kalian akan tutup mata, tutup mulut, tidak peduli dengan apa yang terjadi? Atau kalian akan mengepalkan tangan ke udara, LAWAN!!

Teruslah Bodoh Jangan Pintar adalah novel karya Tere Liye yang diterbitkan Sabak Grip Nusantara pada tahun 2024. Tere Liye adalah salah satu penulis paling produktif dan paling banyak dibaca di Indonesia. Karya-karyanya antara lain seri Bumi, Hujan, Rindu, Pulang, dan Negeri Para Bedebah. Ia dikenal karena menulis dalam berbagai genre, mulai dari fantasi dan romansa hingga cerita yang menyindir keadaan sosial dan politik.

Novel ini termasuk dalam kelompok karya Tere Liye yang bernada kritik sosial. Seperti tergambar dari sinopsisnya, ceritanya menyoroti hukum dan kekuasaan yang dikuasai orang-orang serakah yang tampil seolah sederhana, serta mengajak pembaca bertanya apakah mereka akan diam atau melawan. Judulnya sendiri terdengar seperti sindiran: anjuran untuk tetap bodoh dan tidak pintar, seakan menggambarkan keadaan ketika orang yang kritis justru dianggap mengganggu.

Tema-tema seperti keadilan, keserakahan, kerusakan akibat penyalahgunaan kekuasaan, dan keberanian untuk bersuara sudah sering muncul dalam karya Tere Liye lainnya, misalnya Negeri Para Bedebah dan Negeri di Ujung Tanduk. Pembaca yang menyukai karya-karya tersebut kemungkinan akan menemukan semangat yang serupa di sini.

Seperti umumnya buku Tere Liye, novel ini ditulis dengan bahasa yang lugas dan mudah diikuti, sehingga cocok bagi pembaca remaja maupun dewasa. Buku ini cocok bagi pembaca yang menyukai fiksi Indonesia dengan pesan sosial yang kuat dan ingin merenungkan keadaan di sekitar mereka.

Menurut kajian akademik yang membahas novel ini, ceritanya mengikuti enam aktivis yang melawan perusahaan multinasional, dan memperlihatkan dampak buruk perusahaan tambang terhadap masyarakat dan lingkungan. Kajian lain menyoroti tema manipulasi hukum dan dominasi kekuasaan yang muncul di sepanjang cerita.

Novel setebal sekitar 371 halaman ini terbit pada awal tahun 2024. Sebuah analisis mencatat bahwa waktu terbitnya berdekatan dengan masa pemilihan umum 2024, sehingga pesan sosial dan politiknya terasa relevan bagi pembaca saat itu. Ulasan di Gramedia menyebutnya sebagai buku tentang intrik dan korupsi yang terasa sangat dekat dengan kenyataan.$$,
 $$https://covers.openlibrary.org/b/id/14589014-L.jpg$$),
($$Tanah Para Bandit$$,
 $$Tere Liye$$,
 $$Sabak Grip Nusantara$$,
 $$2023$$,
 $$Di sini, para penjahat dibesarkan sejak buaian. Dilatih lewat kebohongan. Dididik dengan kemunafikan. Diajarkan melalui ketidakpedulian. Di sini, semua bisa diatur sepanjang ada uangnya. Yang bodoh bisa menjadi pintar seketika. Yang tidak layak bisa segera memenuhi syarat. Yang bersalah bisa jadi benar. Yang bengkok bisa diluruskan. Tidak suka lurus? Mari dibengkokkan lagi. Di sini, di Tanah Para Bandit, tidak ada lagi beda antara penjahat bejat dengan tuan nyonya terhormat. Mencuri, merampok hak orang lain, lumrah saja. Ayo, jangan terlalu serius, Kawan. Kita berpesta malam ini. Buku ini adalah buku ke-7 dari serial aksi Tere Liye. Setelah: Negeri Para Bedebah, Negeri Di Ujung Tanduk, Pulang, Pergi, Pulang-Pergi, dan Bedebah Di Ujung Tanduk.

Tanah Para Bandit adalah novel karya Tere Liye yang diterbitkan Sabak Grip Nusantara pada tahun 2023. Seperti disebut dalam sinopsisnya, buku ini adalah buku ketujuh dari serial aksi Tere Liye, setelah Negeri Para Bedebah, Negeri di Ujung Tanduk, Pulang, Pergi, Pulang-Pergi, dan Bedebah di Ujung Tanduk.

Serial aksi ini dikenal dengan tempo cerita yang cepat, pertarungan, dan intrik di dunia kekuasaan dan uang. Di balik aksinya, Tere Liye kerap menyelipkan sindiran tentang korupsi, kemunafikan, dan hukum yang bisa dibeli, tema yang juga terasa kuat dalam sinopsis buku ini.

Pembaca yang sudah mengikuti serial ini akan lebih mudah memahami tokoh dan hubungan di antara mereka, tetapi pembaca baru tetap dapat menikmati semangat ceritanya. Buku ini cocok bagi pembaca yang menyukai cerita aksi dengan kritik sosial.

Dengan tebal 433 halaman, novel ini disebut sebagai buku ketujuh sekaligus penutup serial aksi Tere Liye. Tokoh utamanya adalah Padma, perempuan muda yang sejak kecil dilatih secara fisik, pikiran, mental, dan jiwa. Bersama teman-temannya, ia berhadapan dengan sebuah kelompok bandit bernama Jiwa Korsa.

Latar ceritanya sama dengan novel Pulang, yaitu Talang, tempat yang dalam serial ini dikenal sebagai tanah yang melahirkan para bandit dan tempat asal tokoh Bujang. Ulasan di Gramedia menilai karakter yang kuat dan pengungkapan misteri kejahatan secara bertahap sebagai kekuatan novel ini. Sejumlah kajian akademik juga membahasnya, antara lain dari sisi bentuk-bentuk kejahatan ekonomi, kekerasan, dan politik, serta tema kesetaraan gender.$$,
 $$https://covers.openlibrary.org/b/id/14542361-L.jpg$$),
($$Aldebaran$$,
 $$Tere Liye$$,
 $$Sabak Grip Nusantara$$,
 $$2024$$,
 $$ALDEBARAN Bagian 1 adalah buku ke-16 dari serial BUMI. Setelah petualangan Raib dan Seli di klan Matahari Minor, persahabatan mereka terancam. Seli tidak bisa menjelaskan kenapa dia memilih Tazk dibanding Ily. Sementara Raib, dipenuhi prasangka buruk atas sahabat terbaiknya. Apakah mereka berdua bisa berdamai? Lantas, apa peran April? Kabar baiknya, Ali, yang masih di SagaraS, memutuskan pulang ke klan rendah. Di buku ini juga, perjalanan menuju klan Aldebaran siap dimulai. Adalah Bibi Gill yang mengumpulkan semua pemegang pusaka Sarung Tangan, petarung-petarung besar dan pimpinan klan di konstelasi jauh untuk merundingkan urusan tersebut. Inilah buku ke-16 dari Serial BUMI

Aldebaran adalah novel karya Tere Liye yang diterbitkan Sabak Grip Nusantara pada tahun 2024. Sesuai keterangan di sinopsisnya, buku ini adalah buku ke-16 dari Serial Bumi, serial fantasi yang dimulai dengan Bumi pada tahun 2014.

Serial Bumi mengikuti petualangan tiga sahabat, Raib, Seli, dan Ali, yang menjelajahi dunia-dunia paralel yang disebut klan, masing-masing dengan kekuatan dan teknologinya sendiri. Di buku ini, persahabatan Raib dan Seli diuji, sementara perjalanan menuju klan Aldebaran mulai dipersiapkan.

Karena merupakan bagian dari serial panjang, buku ini akan paling dinikmati oleh pembaca yang sudah mengikuti buku-buku sebelumnya. Bagi penggemar Serial Bumi, buku ini membuka babak baru petualangan yang lebih luas. Cocok bagi pembaca remaja maupun dewasa yang menyukai fantasi petualangan dan kisah persahabatan.

Menurut ulasan di Gramedia, buku ini tidak lagi berfokus pada petualangan seru Raib, Seli, dan Ali seperti buku-buku sebelumnya. Suasananya lebih hangat, seperti sebuah reuni keluarga besar yang mempertemukan banyak tokoh dari seluruh serial. Pembaca disarankan membaca buku-buku sebelumnya terlebih dahulu agar memahami hubungan antartokoh.

Dalam sebuah wawancara pada tahun 2022, Tere Liye menyebut bahwa Aldebaran akan menjadi penutup fase pertama dari semesta Bumi, dan bahwa fase berikutnya sudah direncanakan. Karena itu, buku ini memiliki posisi penting bagi penggemar Serial Bumi yang sudah mengikuti petualangan para tokohnya sejak buku pertama.$$,
 $$https://covers.openlibrary.org/b/id/15110517-L.jpg$$),
($$Hana-Tara-Hata$$,
 $$Tere Liye$$,
 $$Sabak Grip Nusantara$$,
 $$2025$$,
 $$Kalian sudah mengenal Hana, penduduk di Padang Perdu Klan Matahari? Maka ini adalah kisah tentangnya. Kisah yang mengharukan. Tentang seorang pemilik kekuatan “membaca alam sekitar”. Tentang seorang Ibu yang sangat menyayangi anaknya. Rasa sakit. Kehilangan. Pengorbanan. Kebencian. Memaafkan. Tumpah menjadi satu. Juga pertarungan mematikan, tempat-tempat berbahaya, hewan dan tumbuhan legendaris. Kalian mungkin telah tahu kisah ini dari buku-buku sebelumnya, bukan? Tapi itu tidak lengkap. Belum selesai. Karena kita tidak benar-benar tahu akhir sesuatu sebelum sesuatu itu benar-benar berakhir, bukan? Dan saat kisah itu ‘berakhir’, itu boleh jadi ternyata menjadi ‘awal’ dari kisah lain yang lebih seru. HANA-TARA-HATA adalah buku ke-17 dari Serial BUMI.

HANA-TARA-HATA adalah novel karya Tere Liye yang diterbitkan Sabak Grip Nusantara pada tahun 2025. Menurut sinopsisnya, buku ini adalah buku ke-17 dari Serial Bumi, setelah Aldebaran.

Berbeda dari banyak buku sebelumnya yang berfokus pada Raib, Seli, dan Ali, buku ini mengangkat kisah Hana, penduduk Padang Perdu Klan Matahari yang sudah dikenal pembaca dari buku-buku terdahulu. Sinopsisnya menjanjikan kisah tentang seorang ibu, kehilangan, pengorbanan, dan memaafkan, di samping pertarungan dan tempat-tempat berbahaya yang menjadi ciri serial ini.

Buku ini cocok bagi penggemar Serial Bumi yang ingin mengenal lebih dalam tokoh-tokoh pendukungnya. Pembaca baru sebaiknya memulai dari buku pertama, Bumi, agar memahami dunia dan sejarah tokoh-tokohnya.$$,
 $$https://covers.openlibrary.org/b/id/15111012-L.jpg$$),
($$Sendiri$$,
 $$Tere Liye$$,
 $$Sabak Grip Nusantara$$,
 $$2024$$,
 $$Tidak ada yang abadi di dunia ini. Lautan bisa mengering. Gunung bisa rata. Benua terpisah, bersatu, dan terpisah lagi. Apalagi cinta pasangan manusia. Sehebat apapun cinta tersebut, pasti akan berakhir. Waktu akan menelannya. Inilah kisah tentang seorang laki-laki usia 70 tahun, yang ditinggal istrinya meninggal setelah begitu lama menikah, menghabiskan waktu bersama-sama. Saat hari itu tiba, apa yang harus dia lakukan? Bagaimana dia akan melewati sisa hidupnya? Menjalani hari demi hari? Apakah hidupnya masih seru? Apakah masih ada petualangan spesial baginya. Atau hanya tersisa. Sendiri.

Sendiri adalah novel karya Tere Liye yang diterbitkan Sabak Grip Nusantara pada tahun 2024. Seperti tergambar dari sinopsisnya, novel ini mengangkat kisah yang jarang menjadi pusat cerita fiksi populer: seorang laki-laki berusia tujuh puluh tahun yang harus melanjutkan hidup setelah ditinggal istrinya.

Tema kehilangan, kesepian di usia senja, dan pertanyaan tentang makna hidup setelah orang terkasih pergi menjadi inti novel ini. Tere Liye juga memberi ruang untuk harapan, sebagaimana tersirat dalam pertanyaan apakah masih ada petualangan spesial bagi sang tokoh.

Seperti banyak karya Tere Liye lainnya, novel ini ditulis dengan bahasa yang sederhana dan menyentuh. Buku ini cocok bagi pembaca yang menyukai kisah reflektif tentang cinta, kehilangan, dan cara manusia berdamai dengan perubahan.

Novel setebal 320 halaman ini terbit pada 18 Oktober 2024. Ulasan di situs Gramedia memuji alurnya yang rapi dan kejutan-kejutan yang mampu mengaduk emosi pembaca, meskipun bagian awal ceritanya dinilai agak lambat.

Dengan tokoh utama seorang laki-laki berusia tujuh puluh tahun, novel ini menawarkan sudut pandang yang jarang ditemui dalam novel populer Indonesia. Pembaca muda bisa mendapat gambaran tentang perasaan orang tua yang kehilangan pasangan hidupnya, sementara pembaca dewasa mungkin akan menemukan banyak hal yang terasa dekat dengan pengalaman keluarga mereka sendiri.$$,
 $$https://covers.openlibrary.org/b/id/14811646-L.jpg$$),
($$Sebelas$$,
 $$Tere Liye$$,
 $$Sabak Grip Nusantara$$,
 $$2025$$,
 $$Sebelas pemain dikumpulkan dari berbagai tempat. Tanah Papua, Pulau Sumbawa, Sumatera, Bali, Jawa dan berbagai tempat lain. Sebelas pemain dikumpulkan untuk membentuk tim tangguh. Yang bersiap mengalahkan Real Madrid, Manchester United, Barcelona, dan klub-klub besar Eropa dan Amerika Selatan. Inilah kisah tentang sebelas anak-anak berbakat Nusantara. Apa pentingnya sepakbola bagi mereka? Apa pentingnya sepakbola bagi peradaban dunia? Atau itu hanyalah bisnis trilyunan rupiah, pertunjukan komersil, kehidupan mewah, popularitas, yang kosong saja.

Sebelas adalah novel karya Tere Liye yang diterbitkan Sabak Grip Nusantara pada tahun 2025. Novel ini mengangkat dunia sepak bola, olahraga yang sangat digemari di Indonesia, lewat kisah sebelas anak berbakat dari berbagai penjuru Nusantara, mulai dari Papua, Sumbawa, Sumatra, Bali, hingga Jawa.

Selain menghadirkan semangat persahabatan dan perjuangan membentuk tim yang tangguh, sinopsisnya juga mengajukan pertanyaan yang lebih dalam tentang arti sepak bola: apakah sekadar bisnis dan popularitas, atau sesuatu yang lebih bermakna bagi kehidupan.

Novel ini cocok bagi pembaca remaja maupun dewasa, terutama pencinta sepak bola dan pembaca yang menyukai kisah tentang mimpi, kerja keras, dan keberagaman Indonesia.

Novel ini terbit pada April 2025. Menurut ulasan pembaca, cerita berpusat pada Paul, seorang mantan pemain sepak bola terkenal, yang berkeliling ke berbagai daerah di Nusantara untuk mencari anak-anak berbakat dan membentuk tim yang mampu menghadapi klub-klub besar dunia.

Pembaca juga menilai bahwa novel ini bukan sekadar cerita tentang sepak bola. Di balik pencarian para pemain, ada perjalanan tokoh-tokohnya dalam menemukan jawaban tentang luka masa lalu dan belajar menerimanya. Sebagian pembaca menyebut susunan dan suasana ceritanya cukup berbeda dari novel-novel lepas Tere Liye sebelumnya, tetapi ciri khas penulisannya tetap terasa.$$,
 $$https://covers.openlibrary.org/b/id/15111013-L.jpg$$),
($$Bungkam Suara$$,
 $$J. S. Khairen$$,
 $$Gramedia Widiasarana Indonesia$$,
 $$2023$$,
 $$Ini adalah Hari Bebas Bicara di Negara Kesatuan Adat Lawaknesia (NAKAL). Siapa saja boleh berbicara secara gamblang, terang-terangan, tanpa takut akan konsekuensi hukum. Setiap warga negara berhak berbicara: membongkar kejahatan, membeberkan penipuan, mengungkapkan keburukan. Tujuannya, agar tercapai keadilan untuk seluruh rakyat. Namun, kawan, tujuan mulia ini berubah menjadi awan hitam. Jutaan aib terbongkar. Jutaan fitnah tersebar. Jutaan kebencian dan perundungan mengakar. Rakyat berkelahi dengan rakyat. Tetangga dengan tetangga. Murid dengan guru. Karyawan dengan atasan. Anak dengan orangtua. Sahabat dengan sahabat. Kekasih dengan kekasih. Ucapan orang terdekat merobek dinding tiap rumah. Ini adalah Hari Bebas Bicara. Setiap dendam, setiap benci, setiap amarah, lepas berkeliaran. Namun percayalah, kawan, orang jujur selalu ada, bak jarum dalam tumpukan jerami sekalipun.

Bungkam Suara adalah novel karya J. S. Khairen yang diterbitkan Gramedia Widiasarana Indonesia pada tahun 2023. J. S. Khairen dikenal luas lewat novel Kami (Bukan) Sarjana Kertas, yang populer di kalangan pembaca muda.

Novel ini berlatar di sebuah negara rekaan bernama Negara Kesatuan Adat Lawaknesia, disingkat NAKAL. Lewat gagasan tentang Hari Bebas Bicara, novel ini menyindir dunia yang dipenuhi fitnah, perundungan, dan kebencian, terutama di era ketika siapa pun bisa bersuara tanpa batas. Nama negaranya sendiri sudah memberi isyarat bahwa ceritanya dikemas dengan humor dan satire.

Tema utama buku ini adalah kebebasan berbicara, tanggung jawab atas ucapan, dan kejujuran di tengah masyarakat yang mudah terpecah. Buku ini cocok bagi pembaca yang menyukai fiksi satir dengan kritik sosial yang relevan dengan kehidupan sehari-hari dan dunia media sosial.

Novel ini terbit pada Januari 2023 dengan tebal sekitar 368 halaman. Tokoh utamanya bernama Juju Timur, yang kepribadian dan cara bertahannya menghadapi tekanan menjadi bahan kajian psikologi sastra.

Bungkam Suara cukup banyak dibahas dalam penelitian kampus. Para peneliti membacanya sebagai potret negara totaliter, lengkap dengan pengawasan ketat, propaganda, dan ketidakadilan, serta bagaimana warga negara menanggapi pemerintahannya. Di Goodreads, novel ini mendapat penilaian rata-rata di atas empat dari ratusan pembaca, menunjukkan sambutan yang baik dari pembaca muda.$$,
 $$https://covers.openlibrary.org/b/id/14848204-L.jpg$$),
($$Perkumpulan Anak Luar Nikah$$,
 $$Grace Tioso$$,
 $$Noura Books$$,
 $$2023$$,
 $$Shocking Confession from an Indonesian’s Ex-ASEAN Scholarship Recipient Judul artikel itu mengguncang media sosial dalam semalam. Martha, sang tersangka, panik. Keteledoran masa lalunya kini mencuat ke permukaan. Sebagai lulusan Computer Science, bagaimana bisa dia meninggalkan jejak digital yang menghantuinya dengan iming-iming penjara pada masa sekarang? Pernikahannya guncang, kebebasannya terenggut, anak-anaknya terancam kehilangan sosok ibu hanya karena Martha memainkan “25 Question About Me” di blognya belasan tahun lalu dan menjawab terlalu jujur pertanyaan: “What is the wildest thing you’ve ever done when you’re 17 years old?” I forged a legal document. Later, I used it to apply for a scholarship, and I got accepted!

Perkumpulan Anak Luar Nikah adalah novel karya Grace Tioso yang diterbitkan Noura Books pada tahun 2023. Sesuai sinopsisnya, cerita dibuka dengan sebuah artikel yang viral di media sosial dan membongkar rahasia masa lalu tokoh utamanya, Martha.

Novel ini menyentuh tema yang sangat dekat dengan zaman sekarang: jejak digital yang sulit dihapus, kejujuran yang berbalik menjadi masalah, dan bagaimana kesalahan di masa muda dapat mengguncang kehidupan keluarga bertahun-tahun kemudian. Judulnya yang provokatif juga memberi isyarat bahwa cerita ini membahas identitas dan latar belakang keluarga.

Buku ini cocok bagi pembaca yang menyukai fiksi kontemporer dengan konflik keluarga, isu sosial, dan cerita yang dipicu oleh dunia internet.

Grace Tioso mengembangkan novel ini dari cerita pendeknya yang berjudul sama. Ceritanya mengangkat pengalaman warga Tionghoa-Indonesia, termasuk persoalan kewarganegaraan: dalam kisah Martha, sang ayah digambarkan tidak memiliki status kewarganegaraan yang jelas. Media internasional seperti South China Morning Post juga mengulas latar novel ini, yaitu pengalaman warga Tionghoa-Indonesia yang tumbuh di masa Orde Baru.

Novel setebal 396 halaman ini memenangkan salah satu penghargaan Mizan Writing Bootcamp pada tahun 2023 dan juara pertama Ayu Utami Literary Award for Beginners pada tahun 2024. Kolom buku di Detik menyebut gaya bahasanya mengingatkan pada novel metropop, tetapi ceritanya berubah menjadi thriller di bagian tengah, ketika pemalsuan dokumen yang dilakukan Martha ternyata membawa akibat yang sangat serius di Singapura. Banyak pembaca di Goodreads memberi nilai tinggi dan mengaku buku ini membuka mata mereka tentang hak istimewa yang tidak dimiliki semua orang.$$,
 $$https://covers.openlibrary.org/b/id/14613013-L.jpg$$),
($$Timun Jelita$$,
 $$Raditya Dika$$,
 $$GagasMedia$$,
 $$2024$$,
 $$Dalam novel Timun Jelita kita akan mengikuti cerita Timun, seorang akuntan freelance yang ingin bermusik setelah ayahnya wafat dan meninggalkan sebuah gitar tua. Timun kesulitan mendapatkan teman band karena usianya sudah tidak muda lagi. Untung ada Jelita. Sepupunya ini adalah mahasiswi yang pernah dikecewakan oleh teman-teman band-nya yang lama. Mereka pun sepakat membuat duo musik. Dalam 8 bab novel ini kita akan mengikuti cerita tentang suka duka bermusik di zaman sekarang, tentang jujur dalam berkarya, dan tentang umur bukanlah halangan untuk membangkitkan kembali passion yang lama terkubur.

Timun Jelita adalah novel karya Raditya Dika yang diterbitkan GagasMedia pada tahun 2024. Raditya Dika dikenal sebagai penulis, komedian, dan sutradara film. Ia mulai dikenal lewat buku Kambing Jantan dan kemudian menulis buku-buku komedi seperti Cinta Brontosaurus, Marmut Merah Jambu, Manusia Setengah Salmon, dan Koala Kumal.

Novel ini mengikuti Timun, seorang akuntan lepas yang ingin kembali bermusik setelah ayahnya meninggal dan meninggalkan sebuah gitar tua, serta sepupunya, Jelita. Bersama-sama mereka membentuk duo musik dan menghadapi suka duka bermusik di zaman sekarang.

Sesuai sinopsisnya, novel yang terdiri dari delapan bab ini membicarakan kejujuran dalam berkarya dan keyakinan bahwa usia bukan halangan untuk mengejar kembali passion yang lama terkubur. Buku ini cocok bagi pembaca yang menyukai cerita ringan dengan humor khas Raditya Dika, terutama mereka yang pernah bermimpi bermusik.

Novel setebal 168 halaman ini resmi dirilis pada 6 Desember 2024. Tokoh Timun digambarkan sebagai akuntan berusia sekitar empat puluh tahun, sementara Jelita adalah sepupunya yang masih kuliah dan sulit percaya pada orang baru. Kisah mereka berlanjut dalam Timun Jelita Volume 2.

Ulasan di blog Gramedia menyebut novel ini sebagai kisah inspiratif tentang mengejar mimpi meskipun ada banyak hambatan, dengan tokoh-tokoh yang terasa nyata dan seolah mencerminkan diri Raditya Dika sendiri. Novel ini juga menjadi bahan kajian akademik yang membahas pencarian makna hidup para tokohnya.$$,
 $$https://covers.openlibrary.org/b/id/14837534-L.jpg$$),
($$Perempuan Pemanggul Jenazah$$,
 $$Hendra Purnama$$,
 $$Lentera App$$,
 $$2023$$,
 $$“Dewi Sekar Atisaya akan melewati desa ini. Ia datang sambil menebarkan aroma bunga di depannya, tapi meninggalkan bau bangkai di belakangnya. Tutup hidung kita, jangan sampai aroma itu terhirup. Kita bisa gila karenanya. Jangan pula coba-coba mengikutinya karena kita akan mati. Sebab seribu tumbak di belakangnya ada malaikat pencabut nyawa yang bisa menarik jiwa manusia hanya dengan satu entakan.” Demikian cerita itu terus beredar dari mulut ke telinga. Selama tiga hari aku ada di desa ini, nama Dewi Sekar Atisaya—putri Pangeran Indrawardhana dan Ratu Saridyanti, penguasa Pamunjungan Bwanakerta—terus bergema. Aku jadi bertanya-tanya, seperti apa rupanya? Seorang penulis cerita tiba di satu desa dan mendengar cerita seperti itu. Ia penasaran, semengerikan apa sosok Dewi Sekar Atisaya itu sebenarnya? Untuk memperoleh jawabannya dia harus menunggu, dan mencegat sosok itu sebelum masuk ke padang pasir tak bertuan, yang memisahkan kehidupan dan kematian.

Perempuan Pemanggul Jenazah adalah karya Hendra Purnama yang terbit pada tahun 2023. Dari sinopsisnya, cerita ini memiliki nuansa legenda dan kerajaan: seorang penulis cerita tiba di sebuah desa dan mendengar kisah menyeramkan tentang Dewi Sekar Atisaya, putri penguasa Pamunjungan Bwanakerta.

Kisah ini memadukan unsur misteri, cerita rakyat, dan suasana gaib. Penyebutan padang pasir yang memisahkan kehidupan dan kematian memberi isyarat bahwa ceritanya bergerak di wilayah antara dunia nyata dan dunia lain, dengan rasa penasaran sang narator sebagai penggerak cerita.

Buku ini cocok bagi pembaca yang menyukai fiksi bernuansa legenda, misteri, dan kisah yang dituturkan seperti cerita turun-temurun dari mulut ke mulut.

Berdasarkan catatan di Goodreads, karya ini terbit sebagai buku elektronik melalui Lentera App pada 17 Maret 2023, dengan tebal sekitar 73 halaman. Ukurannya yang ringkas membuat buku ini bisa dibaca dalam sekali duduk.$$,
 $$https://covers.openlibrary.org/b/id/15103633-L.jpg$$),
($$Ngomongin Uang$$,
 $$Glenn Ardi$$,
 $$Penerbit Buku Kompas$$,
 $$2024$$,
 $$Kekayaan sering kali bukan hanya soal uang atau status sosial. Kekayaan yang sesungguhnya bersifat sangat personal, karena setiap orang mendefinisikan kesuksesan dan kebahagiaannya dengan cara yang berbeda. Namun, apa pun definisi kekayaan bagi kamu, UANG adalah alat ukur dan kendaraan yang bisa membawamu mencapai tujuan. Karena itulah, memahami keuangan adalah hal yang fundamental dalam membangun kehidupan terbaik versi kamu. Buku ini hadir untuk kamu yang merasa keuangannya mandek, kamu yang overthinking dan terus membandingkan dirimu dengan kesuksesan orang lain, dan kamu yang merasa masa depan keuangan kamu suram—Yuk, kita Ngomongin Uang! Karena ngomongin uang telah mengubah hidup saya! Membuat hidup saya lebih terencana, memberi rasa aman, kedamaian, kebebasan, sekaligus rasa kecukupan. Buku ini bukan soal motivasi sukses atau cara cepat kaya, tetapi buku ini akan membuat kamu menjadi ‘KAYA’ versi kamu sendiri.

Ngomongin Uang adalah buku nonfiksi karya Glenn Ardi yang diterbitkan Penerbit Buku Kompas pada tahun 2024. Buku ini membahas keuangan pribadi dengan bahasa yang santai dan dekat dengan pembaca muda.

Seperti dijelaskan dalam sinopsisnya, buku ini tidak menawarkan cara cepat kaya, melainkan mengajak pembaca memahami uang sebagai alat untuk mencapai tujuan hidup masing-masing. Penulis menekankan bahwa definisi kaya bersifat personal, dan bahwa memahami keuangan dapat memberi rasa aman, rencana yang lebih jelas, dan rasa cukup.

Sasaran utama buku ini adalah pembaca yang merasa keuangannya mandek, sering membandingkan diri dengan orang lain, atau cemas tentang masa depan keuangannya. Buku ini cocok sebagai bacaan awal bagi mahasiswa dan pekerja muda yang ingin mulai mengatur keuangan dengan lebih terencana.

Judul lengkap buku ini adalah Ngomongin Uang: Menjadi 'KAYA' Versi Kamu Sendiri, dengan tebal sekitar 256 halaman. Penulisnya, Glenn Ardi, adalah praktisi di bidang edutech, branding, dan content marketing, sekaligus pendiri dan CEO Ngomongin Uang, platform edukasi keuangan yang ia dirikan pada awal tahun 2020 untuk meningkatkan literasi keuangan masyarakat.

Menurut ulasan media, buku ini menekankan perbedaan antara kebutuhan dan keinginan, serta pesan bahwa pengelolaan uang lebih bergantung pada niat dan disiplin daripada pada besarnya penghasilan. Catatan pembaca menyebut bagian awal buku membahas fondasi, termasuk konsep dan sejarah uang, sebelum masuk ke cara mengelola keuangan sehari-hari.$$,
 $$https://covers.openlibrary.org/b/id/15265063-L.jpg$$),
($$Yang Kamu Belum Tahu Soal Palestina$$,
 $$Shofwan Al-Banna$$,
 $$Pro-U Media$$,
 $$2024$$,
 $$Palestina adalah ujian bagi kemanusiaan kita. Gimana nggak? Kejahatan demi kejahatan terjadi dengan bukti yang terang benderang. Penjajah telah membunuh puluhan ribu bahkan ratusan ribu jiwa manusia (dengan mayoritasnya anak-anak dan perempuan), melukai ratusan ribu hingga jutaan lainnya, menghancurkan rumah dan memaksa jutaan orang menjadi pengungsi, menghancurkan rumah sakit-rumah sakit, memburu para dokter dan tenaga medis, serta para jurnalis dan pekerja kemanusiaan, menghancurkan sekolah, dan bahkan tenda-tenda pengungsian. Ini baru menghitung korban selama Oktober 2023 hingga Mei 2024, yang masih terus bertambah. Terlebih lagi, kejahatan- kejahatan ini semua sudah terjadi lebih dari 75 tahun. Dalam ronde kejahatan yang terakhir ini saja (data dari Oktober 2023-April 2024), Israel telah menjatuhkan lebih dari 70.000 ton bom di sebuah wilayah seluas 365 kilometer persegi Ya, luas Jalur Gaza yang diblokade sejak tahun 2007 itu cuma sedikit lebih besar dari Depok, Jawa Barat yang 200 kilometer persegi dan lebih kecil dari Jakarta yang mencapai 661,52 kilometer persegi. Di wilayah padat yang diisi oleh para pengungsi itu, entitas yang mengklaim sebagai “pasukan paling bermoral sedunia” itu menjatuhkan bom lebih banyak daripada seluruh bom yang dijatuhkan di Dresden, Hamburg, dan London selama Perang Dunia II. Berdasarkan penyelidikan dari Human Rights Watch, Israel terbukti menggunakan berbagai senjata yang dilarang oleh hukum internasional, seperti fosfor putih. Sekali lagi, ini semua sudah terjadi lebih dari 75 tahun! Namun, nggak cuma nurani yang akan terusik. Akal kita juga. Kok bisa ya kejahatan demi kejahatan terjadi terang benderang tapi dunia tidak bisa apa-apa? Kenapa Amerika Serikat justru meloloskan undang-undang yang memberi sanksi pada para pejabat International Criminal Court kalau berani menangkap pejabat Israel? AS biasanya marah-marah kalau ada negara lain mencoba memengaruhi pemilu AS, menyerang kantor perwakilan, atau menyerang dan membunuh kru kapal perangnya. Mengapa AS membiarkan saja Israel melakukan semua hal itu terhadap AS, dan malah menambah bantuan ekonomi dan militernya ke entitas Zionis? Kalau kita diskusikan lebih panjang dan luas lagi, kita juga akan ketemu pertanyaan-pertanyaan yang makin mengusik. Mengapa seorang yang sering disebut-sebut sebagai antisemit seperti Arthur Balfour justru mendukung Zionisme? Benarkah orang Palestina nggak mau damai? Mengapa Zionis membunuh diplomat Swedia yang diutus PBB? Mengapa teroris yang mengebom Hotel King David bisa menjadi perdana menteri, sementara pemenang pemilu yang sah tidak diakui karena dianggap teroris? Temukan jawaban dari pertanyaan-pertanyaan itu serta berbagai pertanyaan lainnya terkait Palestina di dalam buku ini. Ia juga bisa menjadi bekal yang baik untuk membuka pikiran sebagian kita atau teman kita yang masih dibuat bingung oleh aparatur pendukung genosida dan apartheid. Kalau sudah baca, pertanyaannya tinggal. Apakah kamu cuma bisa diam saja?

Yang Kamu Belum Tahu Soal Palestina adalah buku nonfiksi karya Shofwan Al-Banna yang diterbitkan Pro-U Media pada tahun 2024. Buku ini membahas konflik Palestina dan Israel dengan bahasa yang santai, menyasar pembaca muda yang ingin memahami persoalan ini lebih dalam.

Sinopsisnya menunjukkan bahwa buku ini disusun dalam bentuk pertanyaan-pertanyaan yang sering muncul, mulai dari sejarah Deklarasi Balfour, peran Amerika Serikat, hingga peristiwa-peristiwa penting dalam sejarah konflik tersebut. Penulis juga merujuk pada data korban dan laporan lembaga seperti Human Rights Watch untuk menjelaskan situasi di Gaza sejak Oktober 2023.

Buku ini ditulis dengan sudut pandang yang tegas membela Palestina. Pembaca yang ingin memahami konflik ini secara menyeluruh dapat membacanya bersama sumber-sumber lain. Buku ini cocok bagi pembaca yang ingin mempelajari sejarah dan konteks politik di balik berita tentang Palestina.$$,
 $$https://covers.openlibrary.org/b/id/14650181-L.jpg$$),
($$Mata Keramat$$,
 $$Sinta Yudisia$$,
 $$Syab Publishing$$,
 $$2025$$,
 $$Novel ini menceritakan tentang Mutiara yang memiliki kondisi khusus dimana dia bisa merasakan dan melihat makhluk halus. Lengkap dengan segala permasalahan dia menghadapi ibunya yang sakit mental, masalah pertemanan, masalah akademik, pekerjaan dan beban psikologis lainnya.

Mata Keramat adalah novel karya Sinta Yudisia yang diterbitkan Syab Publishing pada tahun 2025. Dari sinopsisnya, novel ini mengikuti Mutiara, seorang gadis yang memiliki kemampuan merasakan dan melihat makhluk halus.

Yang menarik, kemampuan gaib itu tidak berdiri sendiri. Mutiara juga harus menghadapi persoalan yang sangat manusiawi: ibunya yang mengalami gangguan mental, masalah pertemanan, tuntutan akademik, pekerjaan, dan beban psikologis lainnya. Perpaduan unsur supernatural dengan isu kesehatan mental dan keluarga membuat cerita ini lebih dari sekadar kisah horor.

Buku ini cocok bagi pembaca yang menyukai fiksi bernuansa misteri dan supernatural, sekaligus cerita tentang ketahanan seseorang menghadapi masalah keluarga dan tekanan hidup.

Di halaman penjualannya, novel ini digambarkan dengan suasana yang mencekam: sosok-sosok tak kasat mata yang menunggu dalam kegelapan, dan makhluk-makhluk yang muncul saat senja, misalnya di lorong sekolah yang sepi. Gambaran ini menunjukkan bahwa sebagian cerita berlangsung di lingkungan sekolah, dekat dengan keseharian pembaca remaja.

Sinta Yudisia, yang bernama lengkap Sinta Yudisia Wisudanti, adalah penulis asal Tegal. Ia dikenal menulis banyak novel, termasuk novel bertema psikologi dan cerita horor untuk anak. Latar belakang itu terasa dalam Mata Keramat, yang tidak hanya menghadirkan unsur gaib, tetapi juga memperhatikan kondisi kejiwaan tokoh-tokohnya, seperti ibu Mutiara yang mengalami gangguan mental dan beban psikologis yang dipikul Mutiara sendiri.$$,
 $$https://covers.openlibrary.org/b/id/15113412-L.jpg$$),
($$Flâneur$$,
 $$Alief Rahman$$,
 $$PT Kreasi Makna Aneka$$,
 $$2023$$,
 $$Apakah cinta hanya ilusi yang kita ciptakan sendiri? Apakah setiap pertemuan hanyalah kebetulan atau takdir yang telah diatur? Flâneur adalah kumpulan cerita yang menangkap fragmen-fragmen kehidupan dengan nuansa reflektif, melankolis, dan penuh makna. Dari kisah seorang pria yang terjebak dalam perselingkuhan, perdebatan abadi antara hati dan logika di atas panggung, hingga perjalanan tanpa arah di lorong-lorong kota, setiap cerita dalam buku ini mengundangmu untuk berhenti sejenak dan merenung.

Flâneur adalah kumpulan cerita karya Alief Rahman yang terbit pada tahun 2023. Judulnya diambil dari istilah bahasa Prancis untuk orang yang berjalan-jalan menyusuri kota sambil mengamati kehidupan di sekitarnya, sebuah gambaran yang sesuai dengan isi buku ini.

Sesuai sinopsisnya, cerita-cerita dalam buku ini menangkap potongan-potongan kehidupan dengan suasana reflektif dan melankolis, mulai dari kisah perselingkuhan, pergulatan antara hati dan logika, hingga perjalanan tanpa arah di lorong-lorong kota. Pertanyaan tentang cinta, kebetulan, dan takdir menjadi benang merahnya.

Karena berbentuk kumpulan cerita, buku ini bisa dibaca sedikit demi sedikit. Cocok bagi pembaca yang menyukai cerita pendek yang tenang dan mengajak merenung.$$,
 $$https://covers.openlibrary.org/b/id/14843394-L.jpg$$),
($$Matahari di Balik Bukit Partisan$$,
 $$Cumbu Sigil$$,
 $$Nyorangan Books$$,
 $$2025$$,
 $$‘[...] Mereka mati saat mereka mulai percaya bahwa nama mereka, pekerjaan mereka, atau agama mereka, lebih penting daripada diri mereka sendiri.’ Matahari di Balik Bukit Partisan menyajikan sebuah kekuatan naratif yang tidak terletak pada kisah kepahlawanan, melainkan pada potret banal tentang upaya bertahan hidup di dalam sistem yang menyesakkan. Proposisi ini berakar pada penolakan total terhadap semua bentuk juru selamat—baik itu negara dengan jargon pembangunannya, kaum revolusioner dengan idealisme naifnya, maupun sang protagonis sendiri yang menolak jubah kepahlawanan.

Matahari di Balik Bukit Partisan adalah karya Cumbu Sigil yang diterbitkan Nyorangan Books di Sumedang pada tahun 2025. Di halaman judulnya, buku ini disebut sebagai antinovel, yaitu karya fiksi yang sengaja tidak mengikuti pola novel konvensional.

Penulis dan penerbitnya menyatakan melepaskan semua hak cipta atas karya ini dan menempatkannya di domain publik. Cerita dibuka di Jakarta, dengan tokoh aku seorang penulis yang bekerja di depan mesin tik di kamar sempit yang penuh asap rokok.

Seperti tergambar dari sinopsisnya, kekuatan buku ini bukan pada kisah kepahlawanan, melainkan pada potret upaya bertahan hidup di dalam sistem yang menekan, dengan penolakan terhadap segala bentuk sosok penyelamat. Buku ini cocok bagi pembaca yang menyukai prosa yang bermain dengan bentuk dan gagasan, serta fiksi yang mempertanyakan identitas dan kekuasaan.

Bab pertamanya dibuka dengan suasana kamar yang pengap: asbak kaleng bekas biskuit yang penuh puntung kretek, mesin tik Remington, dan suara knalpot kendaraan umum dari jalanan Jakarta. Tokoh aku menolak ajakan seorang anak muda dari lingkaran diskusi, lalu teringat pada sahabatnya, Darman, yang pernah mengajaknya merenungkan apa yang sebenarnya diimani manusia. Dari bagian pembuka ini, pembaca sudah bisa merasakan nada cerita yang sinis, getir, dan penuh perenungan.$$,
 $$https://covers.openlibrary.org/b/id/15110868-L.jpg$$);
