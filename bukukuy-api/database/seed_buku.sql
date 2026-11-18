-- 20 buku Indonesia yang ada di Open Library (openlibrary.org).
-- Deskripsi: paragraf awal adalah sinopsis dari Open Library (yang berbahasa Inggris
-- diterjemahkan; kutipan pujian tokoh dibuang), lalu ditambah beberapa paragraf tanpa
-- bocoran tentang penulis, tema, dan gaya buku. Cover dari covers.openlibrary.org.
-- Tahun terbit memakai tahun terbit pertama di Indonesia.
-- Sumber sinopsis per buku:
--   Laskar Pelangi                             : https://openlibrary.org/works/OL15302003W (kutipan pujian dibuang)
--   Cantik Itu Luka                            : https://openlibrary.org/works/OL34965326W (asli)
--   Anjing Mengeong, Kucing Menggonggong       : https://openlibrary.org/works/OL42609631W (asli)
--   Gadis Pantai                               : https://openlibrary.org/works/OL307190W (diterjemahkan)
--   Saman                                      : https://openlibrary.org/works/OL2325374W (diterjemahkan)
--   Seporsi Mie Ayam Sebelum Mati              : https://openlibrary.org/works/OL42830484W (asli)
--   Anak Semua Bangsa                          : https://openlibrary.org/works/OL307178W (diterjemahkan)
--   Jejak Langkah                              : https://openlibrary.org/works/OL307189W (diterjemahkan)
--   Rumah Kaca                                 : https://openlibrary.org/works/OL307195W (diterjemahkan)
--   Teruslah Bodoh Jangan Pintar               : https://openlibrary.org/works/OL37900765W (asli)
--   Bumi                                       : https://openlibrary.org/works/OL23233727W (asli)
--   Pulang                                     : https://openlibrary.org/works/OL28941542W (kutipan pujian dibuang)
--   Rindu                                      : https://openlibrary.org/works/OL23252280W (asli)
--   Negeri Para Bedebah                        : https://openlibrary.org/works/OL23204670W (asli)
--   Tentang Kamu                               : https://openlibrary.org/works/OL36895009W (asli)
--   Hafalan Shalat Delisa                      : https://openlibrary.org/works/OL23997362W (disesuaikan dari bahasa Melayu)
--   Ayahku (Bukan) Pembohong                   : https://openlibrary.org/works/OL22604015W (kutipan pujian dibuang)
--   Rembulan Tenggelam di Wajahmu              : https://openlibrary.org/works/OL11713474W (asli)
--   Daun yang Jatuh Tak Pernah Membenci Angin  : https://openlibrary.org/works/OL22106205W (asli)
--   Rasa                                       : https://openlibrary.org/works/OL36896696W (asli)
--
-- PERHATIAN: TRUNCATE di bawah menghapus semua buku DAN semua isi rak (favorites)
-- karena favorites mengacu ke buku. Akun (users) tidak terhapus.

ALTER TABLE buku ADD COLUMN IF NOT EXISTS cover_url TEXT;
ALTER TABLE buku DROP COLUMN IF EXISTS rangkuman;
ALTER TABLE buku DROP COLUMN IF EXISTS isi;

TRUNCATE TABLE buku RESTART IDENTITY CASCADE;

INSERT INTO buku (judul, penulis, penerbit, tahun_terbit, deskripsi, cover_url) VALUES
($$Laskar Pelangi$$,
 $$Andrea Hirata$$,
 $$Bentang Pustaka$$,
 $$2005$$,
 $$Begitu banyak hal menakjubkan yang terjadi dalam masa kecil para anggota Laskar Pelangi. Sebelas orang anak Melayu Belitong yang luar biasa ini tak menyerah walau keadaan tak bersimpati pada mereka. Tengoklah Lintang, seorang kuli kopra cilik yang genius dan dengan senang hati bersepeda 80 kilometer pulang pergi untuk memuaskan dahaganya akan ilmu, bahkan terkadang hanya untuk menyanyikan Padamu Negeri di akhir jam sekolah. Atau Mahar, seorang pesuruh tukang parut kelapa sekaligus seniman dadakan yang imajinatif, tak logis, kreatif, dan sering diremehkan sahabat-sahabatnya, namun berhasil mengangkat derajat sekolah kampung mereka dalam karnaval 17 Agustus. Dan juga sembilan orang Laskar Pelangi lain yang begitu bersemangat dalam menjalani hidup dan berjuang meraih cita-cita.

Selami ironisnya kehidupan mereka, kejujuran pemikiran mereka, indahnya petualangan mereka, dan temukan diri Anda tertawa, menangis, dan tersentuh saat membaca setiap lembarnya. Laskar Pelangi ini dipersembahkan buat mereka yang meyakini the magic of childhood memories, dan khususnya juga buat siapa saja yang masih meyakini adanya pintu keajaiban lain untuk mengubah dunia: pendidikan.

Laskar Pelangi adalah novel pertama Andrea Hirata, diterbitkan Bentang Pustaka pada tahun 2005. Novel ini terinspirasi dari masa kecil penulisnya di Pulau Belitung, terutama dari pengalamannya bersekolah di sebuah SD Muhammadiyah yang sederhana. Laskar Pelangi menjadi salah satu novel terlaris dalam sejarah sastra Indonesia dan diterjemahkan ke banyak bahasa.

Novel ini adalah bagian pertama dari tetralogi yang dilanjutkan dengan Sang Pemimpi, Edensor, dan Maryamah Karpov. Pada tahun 2008, Laskar Pelangi diadaptasi menjadi film yang disutradarai Riri Riza dan ditonton jutaan orang, sehingga semakin banyak pembaca yang mengenal kisah ini.

Kekuatan novel ini terletak pada caranya memadukan humor, kenangan masa kecil, dan kritik sosial. Di balik cerita tentang persahabatan anak-anak, terdapat gambaran tentang kesenjangan antara kekayaan alam Belitung, terutama timah, dan kemiskinan masyarakatnya. Tokoh guru seperti Bu Mus juga menjadi simbol pengabdian dalam dunia pendidikan.

Bahasanya ringan dan penuh warna lokal Melayu Belitong, sehingga cocok dibaca oleh remaja maupun dewasa. Novel ini sering direkomendasikan bagi siapa saja yang ingin membaca kisah inspiratif tentang pendidikan dan semangat pantang menyerah.$$,
 $$https://covers.openlibrary.org/b/id/7079796-L.jpg$$),
($$Cantik Itu Luka$$,
 $$Eka Kurniawan$$,
 $$Gramedia Pustaka Utama$$,
 $$2002$$,
 $$Di satu sore, seorang perempuan bangkit dari kuburannya setelah dua puluh satu tahun kematian. Kebangkitannya menguak kutukan dan tragedi keluarga, yang terentang sejak akhir masa kolonial, perpaduan antara epik keluarga yang dibalut roman, kisah hantu, kekejaman politik, mitologi, dan petualangan. Dari kekasih yang lenyap ditelan kabut hingga seorang ibu yang menginginkan bayi buruk rupa.

Cantik Itu Luka adalah novel pertama Eka Kurniawan, pertama kali terbit pada tahun 2002 dan kemudian diterbitkan ulang oleh Gramedia Pustaka Utama. Novel ini berlatar di sebuah kota fiktif bernama Halimunda dan membentang dari masa kolonial Belanda, pendudukan Jepang, revolusi, hingga masa setelah tahun 1965.

Pusat ceritanya adalah Dewi Ayu dan keturunannya. Lewat keluarga ini, Eka menelusuri sejarah Indonesia dengan cara yang tidak biasa, memadukan kenyataan sejarah dengan hal-hal gaib, humor gelap, dan kekerasan. Gaya ini sering dibandingkan dengan realisme magis para penulis Amerika Latin, tetapi akarnya juga kuat dalam cerita rakyat dan wayang Jawa.

Novel ini diterjemahkan ke bahasa Inggris dengan judul Beauty Is a Wound dan ke puluhan bahasa lain, sehingga mengangkat nama Eka Kurniawan di dunia sastra internasional. Karya-karyanya yang lain antara lain Lelaki Harimau, Seperti Dendam, Rindu Harus Dibayar Tuntas, dan Anjing Mengeong, Kucing Menggonggong.

Karena memuat kekerasan dan adegan dewasa yang cukup eksplisit, novel ini lebih cocok untuk pembaca dewasa. Bagi pembaca yang menyukai sastra dengan sejarah, mitos, dan satire yang berlapis, buku ini termasuk bacaan penting dalam sastra Indonesia modern.$$,
 $$https://covers.openlibrary.org/b/id/13903116-L.jpg$$),
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
($$Gadis Pantai$$,
 $$Pramoedya Ananta Toer$$,
 $$Hasta Mitra$$,
 $$1987$$,
 $$Di sebuah kampung nelayan miskin di pesisir, seorang gadis cantik tanpa sadar menarik perhatian seorang bangsawan setempat. Sebelum ia sempat memahami apa yang terjadi, ia dipaksa menikah dengan laki-laki yang belum pernah ia lihat dan meninggalkan semua yang akrab baginya: hari-hari tanpa beban membantu ibunya mengerjakan tugas sehari-hari, melamun mendengarkan suara angin dan ombak, dan memandangi perahu-perahu yang datang dan pergi. Ia dibawa ke rumah besar suaminya di kota dan dicemplungkan ke dalam dunia asing yang penuh kemewahan sekaligus kekakuan yang sunyi.

Perlahan Gadis Pantai mulai terbiasa dengan aturan rumah tangga itu, tetapi semakin lama ia semakin dihantui keraguan. Ke mana suaminya pergi berhari-hari? Apa yang sebenarnya ia pikirkan tentang dirinya? Mengapa semua orang begitu takut kepadanya? Terlalu malu untuk menanyakan hal-hal itu langsung kepada suaminya, ia berulang kali berpaling kepada pelayan perempuan yang ditugaskan untuknya, dan dari percakapan dengan perempuan yang lebih tua itulah sang gadis mulai memahami kebenaran tentang hidup barunya.

Yang menyusul adalah kisah perjalanan seorang perempuan muda menempuh jalan yang sepi dan menyakitkan menuju kedewasaan. Di sepanjang jalan, ia berhadapan dengan kenyataan pahit sebuah masyarakat tempat perempuan tak lebih dari barang milik, masyarakat yang terdiri dari mereka yang memberi perintah dan mereka yang menjalankannya.

Gadis Pantai adalah novel karya Pramoedya Ananta Toer, salah satu sastrawan terbesar Indonesia. Novel ini terbit dalam bentuk buku pada tahun 1987, meskipun pernah dimuat sebagai cerita bersambung jauh sebelumnya. Novel ini terinspirasi dari kisah nenek Pramoedya sendiri dan direncanakan sebagai bagian pertama dari sebuah trilogi, tetapi naskah lanjutannya hilang.

Lewat kisah seorang gadis dari kampung nelayan yang dinikahkan dengan seorang priyayi, Pramoedya mengkritik sistem feodal Jawa yang menempatkan perempuan dan rakyat kecil di posisi yang lemah. Kontras antara kehidupan pesisir yang sederhana dan kehidupan bangsawan yang penuh aturan menjadi inti cerita.

Pramoedya menulis dengan bahasa yang lugas namun penuh empati terhadap tokoh-tokohnya. Novel ini relatif pendek dibandingkan karya-karya besarnya yang lain, sehingga sering menjadi pintu masuk yang baik bagi pembaca yang ingin mengenal karya Pramoedya.

Buku ini cocok bagi pembaca yang tertarik pada sastra Indonesia klasik, sejarah sosial Jawa, dan kisah tentang perjuangan perempuan.$$,
 $$https://covers.openlibrary.org/b/id/13810472-L.jpg$$),
($$Saman$$,
 $$Ayu Utami$$,
 $$Kepustakaan Populer Gramedia$$,
 $$1998$$,
 $$Saman adalah kisah yang disaring melalui kehidupan para tokoh perempuannya yang berani dan sosok "pahlawan" yang penuh teka-teki, Saman. Novel ini sekaligus membongkar penindasan terhadap buruh perkebunan di Sumatra Selatan, menjadi pencarian liris untuk memahami tempat agama dan spiritualitas dalam kehidupan masa kini, menjelajahi seksualitas perempuan dengan jenaka, dan bercerita tentang cinta dalam berbagai wujudnya, sambil menyentuh berbagai hal yang dianggap tabu di Indonesia: seks di luar nikah, represi politik, dan hubungan antara umat Kristen dan Muslim.

Saman adalah novel pertama Ayu Utami yang diterbitkan Kepustakaan Populer Gramedia pada tahun 1998. Novel ini memenangkan sayembara penulisan roman Dewan Kesenian Jakarta tahun 1998 dan terbit pada masa yang sangat penting, menjelang dan sekitar jatuhnya Orde Baru.

Saman dianggap sebagai salah satu karya yang membuka babak baru dalam sastra Indonesia, karena keberaniannya membicarakan politik, agama, dan seksualitas dari sudut pandang perempuan. Novel ini kemudian dilanjutkan dengan Larung pada tahun 2001.

Struktur ceritanya tidak linear. Kisah berpindah-pindah antara beberapa tokoh, tempat, dan waktu, termasuk New York dan perkebunan di Sumatra. Gaya bahasanya puitis dan padat, sehingga membutuhkan perhatian lebih saat membaca.

Karena tema dan adegannya yang dewasa, buku ini lebih cocok untuk pembaca dewasa. Bagi peminat sastra Indonesia, Saman adalah bacaan penting untuk memahami perkembangan sastra setelah tahun 1998.$$,
 $$https://covers.openlibrary.org/b/id/1054753-L.jpg$$),
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
($$Anak Semua Bangsa$$,
 $$Pramoedya Ananta Toer$$,
 $$Hasta Mitra$$,
 $$1980$$,
 $$Bergulat dengan penindasan dan ketidakadilan rezim Eropa di negerinya, Minke, penulis Jawa berpendidikan Belanda, berjuang menyuarakan dirinya dan suara bangsanya. Namun di setiap langkah ia dihadang oleh kebusukan orang-orang yang ia percayai dan oleh tragedi yang menimpa orang-orang yang paling ia cintai.

Anak Semua Bangsa adalah buku kedua dari Tetralogi Buru karya Pramoedya Ananta Toer, setelah Bumi Manusia. Novel ini diterbitkan Hasta Mitra pada tahun 1980. Seluruh tetralogi ini disusun Pramoedya ketika ia menjadi tahanan politik di Pulau Buru, awalnya dituturkan secara lisan kepada sesama tahanan sebelum akhirnya ditulis.

Tokoh utamanya, Minke, terinspirasi dari tokoh pers nasional Tirto Adhi Soerjo. Dalam buku ini Minke semakin menyadari ketidakadilan sistem kolonial dan mulai melihat bahwa perjuangannya terkait dengan nasib banyak bangsa terjajah lain, sesuai judulnya.

Tetralogi Buru sempat dilarang beredar pada masa Orde Baru, sehingga banyak pembaca membacanya secara sembunyi-sembunyi. Kini karya ini diakui sebagai salah satu puncak sastra Indonesia dan telah diterjemahkan ke banyak bahasa.

Pembaca disarankan membaca Bumi Manusia terlebih dahulu agar memahami latar dan hubungan antartokoh. Buku ini cocok bagi pembaca yang tertarik pada sejarah pergerakan nasional dan sastra Indonesia klasik.$$,
 $$https://covers.openlibrary.org/b/id/6635926-L.jpg$$),
($$Jejak Langkah$$,
 $$Pramoedya Ananta Toer$$,
 $$Hasta Mitra$$,
 $$1985$$,
 $$Melanjutkan petualangan Minke, wartawan berpendidikan Belanda, ketika ia dan negerinya memasuki abad kedua puluh. Menetap di kota baru untuk memulai sekolah kedokteran, Minke bertekad meninggalkan tragedi masa lalunya. Namun sekali lagi laki-laki yang cerdas dan berbelas kasih ini terseret dalam ketidakadilan eksploitasi kolonial. Saat ia berjuang bukan hanya untuk memahami dunianya, tetapi juga untuk mengubahnya, Minke memulai pengembaraan pribadi untuk menemukan jati diri yang membawanya melintasi dunia Hindia Belanda yang penuh warna dan bergejolak.

Jejak Langkah adalah buku ketiga dari Tetralogi Buru karya Pramoedya Ananta Toer, diterbitkan Hasta Mitra pada tahun 1985. Buku ini melanjutkan kisah Minke setelah Bumi Manusia dan Anak Semua Bangsa.

Jika dua buku sebelumnya banyak berfokus pada kesadaran pribadi Minke, Jejak Langkah memperlihatkan bagaimana ia mulai bergerak: menulis, mendirikan surat kabar, dan berorganisasi. Buku ini menggambarkan masa awal kebangkitan nasional, ketika pers dan organisasi menjadi alat perjuangan baru melawan penjajahan.

Pramoedya menghadirkan banyak tokoh dan peristiwa yang terinspirasi dari sejarah pergerakan di awal abad kedua puluh. Karena itu, novel ini juga bisa dibaca sebagai cara memahami suasana zaman ketika gagasan tentang bangsa Indonesia mulai tumbuh.

Buku ini sebaiknya dibaca setelah dua buku sebelumnya. Cocok bagi pembaca yang menyukai fiksi sejarah dan ingin memahami akar pergerakan nasional Indonesia.$$,
 $$https://covers.openlibrary.org/b/id/99404-L.jpg$$),
($$Rumah Kaca$$,
 $$Pramoedya Ananta Toer$$,
 $$Hasta Mitra$$,
 $$1988$$,
 $$Rumah Kaca adalah bab terakhir dari tetralogi epik Pramoedya, berlatar di Hindia Belanda pada pergantian abad. Sebuah novel tentang kepahlawanan, gairah, dan pengkhianatan, buku ini menjadi penutup yang luar biasa bagi sebuah seri yang dipuji sebagai salah satu karya besar sastra modern.

Di awal Rumah Kaca, Minke, penulis dan pemimpin gerakan perlawanan, kini dipenjara, dan penceritaan beralih kepada Pangemanann, mantan polisi yang bertugas memata-matai dan melaporkan orang-orang yang terus memperjuangkan kemerdekaan. Namun sang pemburu mulai menjadi yang diburu. Pangemanann menjadi korban hati nuraninya sendiri dan mulai mengagumi lawan-lawannya. Ia harus memutuskan apakah hukum ada untuk melindungi hak rakyat atau untuk mengendalikan rakyat. Ia takut kehilangan kedudukan, keluarga, dan harga dirinya. Akhirnya Pangemanann menyadari bahwa lawannya yang sesungguhnya bukanlah Minke dan para pengikutnya, melainkan daya hidup dan semangat sebuah masyarakat yang telah terbangun.

Rumah Kaca adalah buku keempat sekaligus penutup Tetralogi Buru karya Pramoedya Ananta Toer, diterbitkan Hasta Mitra pada tahun 1988. Seperti tiga buku sebelumnya, Rumah Kaca disusun Pramoedya selama masa penahanannya di Pulau Buru.

Yang membuat buku ini berbeda adalah sudut pandangnya. Jika tiga buku sebelumnya dituturkan oleh Minke, buku ini dituturkan oleh Pangemanann, seorang pejabat yang bertugas mengawasi para aktivis pergerakan. Judulnya merujuk pada cara pemerintah kolonial mengawasi rakyatnya seakan-akan mereka berada di dalam rumah kaca.

Perubahan sudut pandang ini memberi gambaran tentang cara kerja kekuasaan dari dalam, termasuk dilema moral orang-orang yang menjalankannya. Banyak pembaca menganggap buku ini sebagai bagian paling reflektif dari tetralogi tersebut.

Buku ini sebaiknya dibaca setelah tiga buku sebelumnya. Cocok bagi pembaca yang ingin menuntaskan Tetralogi Buru dan tertarik pada tema kekuasaan, pengawasan, dan hati nurani.$$,
 $$https://covers.openlibrary.org/b/id/99417-L.jpg$$),
($$Teruslah Bodoh Jangan Pintar$$,
 $$Tere Liye$$,
 $$Sabak Grip Nusantara$$,
 $$2024$$,
 $$Saat hukum dan kekuasaan dipegang oleh serigala-serigala buas berbulu domba. Saat seluruh negeri dikangkangi orang-orang jualan sok sederhana tapi sejatinya serakah. Apakah kalian akan tutup mata, tutup mulut, tidak peduli dengan apa yang terjadi? Atau kalian akan mengepalkan tangan ke udara, LAWAN!!

Teruslah Bodoh Jangan Pintar adalah novel karya Tere Liye yang diterbitkan Sabak Grip Nusantara pada tahun 2024. Tere Liye adalah salah satu penulis paling produktif dan paling banyak dibaca di Indonesia. Karya-karyanya antara lain seri Bumi, Hujan, Rindu, Pulang, dan Negeri Para Bedebah. Ia dikenal karena menulis dalam berbagai genre, mulai dari fantasi dan romansa hingga cerita yang menyindir keadaan sosial dan politik.

Novel ini termasuk dalam kelompok karya Tere Liye yang bernada kritik sosial. Seperti tergambar dari sinopsisnya, ceritanya menyoroti hukum dan kekuasaan yang dikuasai orang-orang serakah yang tampil seolah sederhana, serta mengajak pembaca bertanya apakah mereka akan diam atau melawan. Judulnya sendiri terdengar seperti sindiran: anjuran untuk tetap bodoh dan tidak pintar, seakan menggambarkan keadaan ketika orang yang kritis justru dianggap mengganggu.

Tema-tema seperti keadilan, keserakahan, kerusakan akibat penyalahgunaan kekuasaan, dan keberanian untuk bersuara sudah sering muncul dalam karya Tere Liye lainnya, misalnya Negeri Para Bedebah dan Negeri di Ujung Tanduk. Pembaca yang menyukai karya-karya tersebut kemungkinan akan menemukan semangat yang serupa di sini.

Seperti umumnya buku Tere Liye, novel ini ditulis dengan bahasa yang lugas dan mudah diikuti, sehingga cocok bagi pembaca remaja maupun dewasa. Buku ini cocok bagi pembaca yang menyukai fiksi Indonesia dengan pesan sosial yang kuat dan ingin merenungkan keadaan di sekitar mereka.$$,
 $$https://covers.openlibrary.org/b/id/14589014-L.jpg$$),
($$Bumi$$,
 $$Tere Liye$$,
 $$Gramedia Pustaka Utama$$,
 $$2014$$,
 $$Namaku Raib, usiaku 15 tahun, kelas sepuluh. Aku anak perempuan seperti kalian, adik-adik kalian, tetangga kalian. Aku punya dua kucing, namanya si Putih dan si Hitam. Mama dan papaku menyenangkan. Guru-guru di sekolahku seru. Teman-temanku baik dan kompak. Aku sama seperti remaja kebanyakan, kecuali satu hal. Sesuatu yang kusimpan sendiri sejak kecil. Sesuatu yang menakjubkan. Namaku, Raib. Dan aku bisa menghilang.

Bumi adalah buku pertama dari seri fantasi karya Tere Liye yang diterbitkan Gramedia Pustaka Utama pada tahun 2014. Seri ini kemudian berkembang menjadi salah satu seri fantasi Indonesia yang paling populer, dengan lanjutan seperti Bulan, Matahari, Bintang, Ceros dan Batozar, Komet, dan seterusnya.

Ceritanya mengikuti Raib, siswi SMA yang memiliki kemampuan menghilang, bersama dua temannya, Seli dan Ali. Mereka terseret ke dunia lain yang ternyata hidup berdampingan dengan dunia kita, dengan klan-klan yang memiliki teknologi dan kekuatan masing-masing.

Tere Liye menulis seri ini dengan tempo cepat, banyak petualangan, dan persahabatan yang hangat di antara para tokohnya. Dunia ceritanya dibangun sedikit demi sedikit, sehingga pembaca baru tidak kewalahan.

Buku ini cocok bagi pembaca remaja maupun dewasa yang menyukai fantasi petualangan. Karena ini buku pertama, Bumi adalah titik awal yang tepat untuk mengikuti seluruh serinya.$$,
 $$https://covers.openlibrary.org/b/id/12810708-L.jpg$$),
($$Pulang$$,
 $$Tere Liye$$,
 $$Republika$$,
 $$2015$$,
 $$"Aku tahu sekarang, lebih banyak luka di hati bapakku dibanding di tubuhnya. Juga mamakku, lebih banyak tangis di hati Mamak dibanding di matanya."

Sebuah kisah tentang perjalanan pulang, melalui pertarungan demi pertarungan, untuk memeluk erat semua kebencian dan rasa sakit.

Pulang adalah novel karya Tere Liye yang diterbitkan Republika pada tahun 2015. Novel ini mengikuti Bujang, anak dari pedalaman Sumatra yang dibawa ke kota dan tumbuh di tengah keluarga besar yang menguasai dunia ekonomi bayangan, yaitu bisnis-bisnis yang bergerak di balik layar.

Novel ini menggabungkan aksi, intrik, dan drama keluarga. Di balik pertarungan dan persaingan kekuasaan, Tere Liye menyelipkan perenungan tentang masa lalu, hubungan dengan orang tua, dan arti pulang dalam makna yang lebih dalam.

Pulang mendapat sambutan besar dari pembaca dan kemudian dilanjutkan dengan Pergi dan Pulang-Pergi, yang meneruskan kisah Bujang. Gaya penulisannya cepat dan penuh ketegangan, berbeda dengan novel-novel Tere Liye yang lebih melankolis.

Buku ini cocok bagi pembaca yang menyukai cerita aksi dengan pesan keluarga dan perenungan hidup.$$,
 $$https://covers.openlibrary.org/b/id/12905869-L.jpg$$),
($$Rindu$$,
 $$Tere Liye$$,
 $$Republika$$,
 $$2014$$,
 $$"Apalah arti memiliki, ketika diri kami sendiri bukanlah milik kami? Apalah arti kehilangan, ketika kami sebenarnya menemukan banyak saat kehilangan, dan sebaliknya, kehilangan banyak pula saat menemukan? Apalah arti cinta, ketika menangis terluka atas perasaan yg seharusnya indah? Bagaimana mungkin, kami terduduk patah hati atas sesuatu yg seharusnya suci dan tidak menuntut apa pun? Wahai, bukankah banyak kerinduan saat kami hendak melupakan? Dan tidak terbilang keinginan melupakan saat kami dalam rindu? Hingga rindu dan melupakan jaraknya setipis benang saja” Rindu- Tere Liye. Lima kisah dalam sebuah perjalanan panjang kerinduan. Selamat membaca.

Rindu adalah novel karya Tere Liye yang diterbitkan Republika pada tahun 2014. Ceritanya berlatar pada akhir tahun 1930-an, ketika sebuah kapal besar membawa rombongan jemaah haji dari Hindia Belanda menuju Tanah Suci.

Sesuai sinopsisnya, novel ini memuat lima kisah dari beberapa penumpang kapal tersebut. Masing-masing membawa pertanyaan dan beban batin sendiri, misalnya tentang masa lalu, kehilangan, cinta, dan kebencian. Perjalanan panjang di atas kapal menjadi kesempatan bagi mereka untuk mencari jawaban.

Tere Liye memadukan latar sejarah masa kolonial dengan perenungan spiritual yang lembut. Novel ini juga memberi gambaran tentang perjalanan haji pada masa itu, yang memakan waktu berbulan-bulan dan penuh tantangan.

Buku ini cocok bagi pembaca yang menyukai novel reflektif dengan latar sejarah dan pesan tentang memaafkan, menerima, dan berdamai dengan masa lalu.$$,
 $$https://covers.openlibrary.org/b/id/14541663-L.jpg$$),
($$Negeri Para Bedebah$$,
 $$Tere Liye$$,
 $$Gramedia Pustaka Utama$$,
 $$2012$$,
 $$Di negeri para bedebah, kisah fiksi kalah seru dibanding kisah nyata. Di negeri para bedebah, musang berbulu domba berkeliaran di halaman rumah. Tetapi setidaknya, Kawan, di negeri para bedebah, petarung sejati tidak akan pernah berkhianat.

Negeri Para Bedebah adalah novel karya Tere Liye yang diterbitkan Gramedia Pustaka Utama pada tahun 2012. Novel ini termasuk karya Tere Liye bergenre thriller, berbeda dari novel-novel romantis atau keluarganya yang lebih dikenal.

Tokoh utamanya adalah Thomas, seorang konsultan keuangan yang terlibat dalam upaya menyelamatkan sebuah bank dari kebangkrutan, sambil berhadapan dengan politikus, penegak hukum, dan para pelaku kejahatan keuangan. Ceritanya berlangsung dalam waktu singkat dengan tempo yang sangat cepat.

Lewat cerita ini, Tere Liye menyindir praktik korupsi, permainan kekuasaan, dan kejahatan kerah putih yang merugikan banyak orang. Novel ini dilanjutkan dengan Negeri di Ujung Tanduk, yang masih mengikuti tokoh Thomas.

Buku ini cocok bagi pembaca yang menyukai cerita penuh ketegangan dengan latar ekonomi dan politik Indonesia.$$,
 $$https://covers.openlibrary.org/b/id/14541661-L.jpg$$),
($$Tentang Kamu$$,
 $$Tere Liye$$,
 $$Republika$$,
 $$2016$$,
 $$Terima kasih untuk kesempatan mengenalmu, itu adalah salah satu anugerah terbesar hidupku. Cinta memang tidak perlu ditemukan, cintalah yang akan menemukan kita. Terima kasih. Nasihat lama itu benar sekali, aku tidak akan menangis karena sesuatu telah berakhir, tapi aku akan tersenyum karena sesuatu itu pernah terjadi. Masa lalu. Rasa sakit. Masa depan. Mimpi-mimpi. Semua akan berlalu, seperti sungai yang mengalir. Maka biarlah hidupku mengalir seperti sungai kehidupan. *** Atas dasar pekerjaan, Zaman Zulkarnaen harus menelusuri hidup seorang kliennya, perempuan pemegang paspor Inggris yang barusan meninggal dan mewariskan harta yang jumlahnya bisa menyaingi kekayaan Ratu Inggris. Tiga negara, lima kota, beribu luka. Hingga akhirnya Zaman mengerti, bahwa ini bukan sekadar perkara mengerti jalan hidup seorang klien, melainkan pengejawantahan prinsip kuat di tengah cobaan yang terus mendera. Tentang Kamu adalah novel terbaru Tere Liye. Sebuah karya yang tak hanya akan membawa pembacanya menyelami sebuah petualangan yang seru dan sarat emosi, tapi juga memberikan nilai positif sehingga membuat hidup serasa lebih patut disyukuri.

Tentang Kamu adalah novel karya Tere Liye yang diterbitkan Republika pada tahun 2016. Ceritanya mengikuti Zaman Zulkarnaen, pengacara muda di sebuah firma hukum di London, yang mendapat tugas menelusuri jejak hidup seorang klien yang meninggal dan meninggalkan warisan sangat besar.

Penelusuran itu membawanya ke berbagai tempat dan mengungkap kisah hidup seorang perempuan bernama Sri Ningsih, yang penuh cobaan, kehilangan, dan keteguhan hati. Struktur ceritanya bergerak bolak-balik antara penelusuran Zaman di masa kini dan kisah Sri Ningsih di masa lalu.

Novel ini termasuk karya Tere Liye yang banyak disukai pembaca karena memadukan unsur misteri dengan kisah hidup yang menyentuh. Pesan tentang ketabahan, kebaikan, dan menerima takdir menjadi benang merahnya.

Buku ini cocok bagi pembaca yang menyukai cerita perjalanan hidup yang panjang dan mengharukan.$$,
 $$https://covers.openlibrary.org/b/id/14541664-L.jpg$$),
($$Hafalan Shalat Delisa$$,
 $$Tere Liye$$,
 $$Republika$$,
 $$2005$$,
 $$Delisa adalah anak perempuan bermata hijau bening yang usianya baru menginjak lima tahun. Ia hidup bersama keluarganya yang sederhana, dan sedang berusaha menghafal bacaan shalat dengan bantuan ibu dan kakak-kakaknya. Namun Tuhan lebih tahu apa yang terbaik bagi hamba-Nya. Tsunami datang dan merenggut senyum dari wajah Delisa. Tsunami mengambil segalanya, keluarganya dan juga kaki kecilnya. Yang tersisa hanya Delisa dan ayahnya. Dalam keadaan seperti itu, mampukah Delisa tetap tersenyum seperti dulu dan menyelesaikan hafalannya?

Hafalan Shalat Delisa adalah salah satu novel awal Tere Liye, diterbitkan Republika pada tahun 2005. Ceritanya berlatar di Aceh dan terinspirasi oleh bencana tsunami yang melanda Aceh pada 26 Desember 2004.

Novel ini mengikuti Delisa, anak kecil yang sedang berusaha menghafal bacaan shalat untuk ujian di sekolahnya. Lewat sudut pandang seorang anak, Tere Liye menggambarkan kehilangan besar dengan cara yang lembut dan penuh harapan.

Novel ini diadaptasi menjadi film pada tahun 2011 dan membuat kisah Delisa dikenal lebih luas. Tema keikhlasan, ketabahan, dan kasih sayang keluarga menjadi inti ceritanya.

Buku ini cocok bagi pembaca dari berbagai usia, termasuk remaja, yang menyukai kisah mengharukan dengan nilai-nilai keagamaan dan kemanusiaan.$$,
 $$https://covers.openlibrary.org/b/id/14541662-L.jpg$$),
($$Ayahku (Bukan) Pembohong$$,
 $$Tere Liye$$,
 $$Gramedia Pustaka Utama$$,
 $$2011$$,
 $$Kapan terakhir kali kita memeluk ayah kita? Menatap wajahnya, lantas bilang kita sungguh sayang padanya? Kapan terakhir kali kita bercakap ringan, tertawa gelak, bercengkerama, lantas menyentuh lembut tangannya, bilang kita sungguh bangga padanya?

Inilah kisah tentang seorang anak yang dibesarkan dengan dongeng-dongeng kesederhanaan hidup. Kesederhanaan yang justru membuat ia membenci ayahnya sendiri. Inilah kisah tentang hakikat kebahagiaan sejati. Jika kalian tidak menemukan rumus itu di novel ini, tidak ada lagi cara terbaik untuk menjelaskannya.

Mulailah membaca novel ini dengan hati lapang, dan saat tiba di halaman terakhir, berlarilah secepat mungkin menemui ayah kita, sebelum semuanya terlambat, dan kita tidak pernah sempat mengatakannya.

Ayahku (Bukan) Pembohong adalah novel karya Tere Liye yang diterbitkan Gramedia Pustaka Utama pada tahun 2011. Novel ini berkisah tentang hubungan seorang anak dengan ayahnya, yang sejak kecil menceritakan kisah-kisah luar biasa tentang masa mudanya.

Ketika sang anak tumbuh dewasa, ia mulai meragukan kebenaran cerita-cerita itu dan merasa ayahnya telah membohonginya. Konflik inilah yang menjadi inti novel, sekaligus pintu untuk membicarakan arti kesederhanaan dan kebahagiaan.

Seperti banyak karya Tere Liye lainnya, novel ini ditulis dengan bahasa yang sederhana dan menyentuh. Pesannya tentang menghargai orang tua dan mencari kebahagiaan dalam hal-hal sederhana membuat novel ini sering direkomendasikan untuk dibaca bersama keluarga.

Buku ini cocok bagi pembaca remaja dan dewasa yang menyukai kisah keluarga yang hangat dan reflektif.$$,
 $$https://covers.openlibrary.org/b/id/14541670-L.jpg$$),
($$Rembulan Tenggelam di Wajahmu$$,
 $$Tere Liye$$,
 $$Republika$$,
 $$2009$$,
 $$Tutup mata kita. Tutup pikiran kita dari carut- marut kehidupan. Mari berpikir takjim sejenak. Bayangkan saat ini ada satu malaikat bersayap indah datang kepada kita, lantas lembut berkata: Aku memberikan kau kesempatan hebat. Lima kesempatan untuk bertanya tentang rahasia kehidupan, dan aku akan menjawabnya langsung sekarang. Lima Pertanyaan. Lima jawaban. Apakah pertanyaan pertamamu? Maka apakah kita akan bertanya: Apakah cinta itu? Apakah hidup ini adil? Apakah kaya adalah segalanya? Apakah kita memilki pilihan dalam hidup? Apakah makna kehilangan? Ray (tokoh utama dalam kisah ini), ternyata memiliki kecamuk pertanyaan sendiri. Lima pertanyaan sebelum akhirnya dia mengerti makna hidup dan kehidupannya. Siapkan energi Anda untuk memasuki dunia Fantasi Tere-Liye tentang perjalanan hidup. Di sini hanya ada satu rumus: semua urusan adalah sederhana. Maka mulailah membaca dengan menghela nafas lega

Rembulan Tenggelam di Wajahmu adalah novel karya Tere Liye yang diterbitkan Republika pada tahun 2009. Novel ini mengikuti Ray, laki-laki yang tumbuh di panti asuhan dan menjalani hidup yang penuh luka, kegagalan, dan kehilangan.

Keunikan novel ini terletak pada strukturnya. Ray diberi kesempatan untuk melihat kembali perjalanan hidupnya dan mendapatkan jawaban atas lima pertanyaan besar yang selama ini menghantuinya. Setiap jawaban membuka sisi baru dari peristiwa-peristiwa yang pernah ia alami.

Lewat cerita ini, Tere Liye mengajak pembaca merenungkan bahwa setiap kejadian dalam hidup saling terhubung, dan bahwa banyak hal yang tampak tidak adil sebenarnya memiliki makna yang belum kita pahami. Novel ini juga diadaptasi menjadi film.

Buku ini cocok bagi pembaca yang menyukai novel reflektif tentang makna hidup, takdir, dan pengampunan.$$,
 $$https://covers.openlibrary.org/b/id/14541660-L.jpg$$),
($$Daun yang Jatuh Tak Pernah Membenci Angin$$,
 $$Tere Liye$$,
 $$Gramedia Pustaka Utama$$,
 $$2010$$,
 $$Dia bagai malaikat bagi keluarga kami. Merengkuh aku, adikku, dan Ibu dari kehidupan jalanan yang miskin dan nestapa. Memberikan makan, tempat berteduh, sekolah, dan janji masa depan yang lebih baik. Dia sungguh bagai malaikat bagi keluarga kami. Memberikan kasih sayang, perhatian, dan teladan tanpa mengharap budi sekali pun. Dan lihatlah, aku membalas itu semua dengan membiarkan mekar perasaan ini. Ibu benar, tak layak aku mencintai malaikat keluarga kami. Tak pantas. Maafkan aku, Ibu. Perasaan kagum, terpesona, atau entahlah itu muncul tak tertahankan bahkan sejak rambutku masih dikepang dua. Sekarang, ketika aku tahu dia boleh jadi tidak pernah menganggapku lebih dari seorang adik yang tidak tahu diri, biarlah... Biarlah aku luruh ke bumi seperti sehelai daun... daun yang tidak pernah membenci angin meski harus terenggutkan dari tangkai pohonnya.

Daun yang Jatuh Tak Pernah Membenci Angin adalah novel karya Tere Liye yang diterbitkan Gramedia Pustaka Utama. Novel ini termasuk karya Tere Liye yang paling dikenal karena judulnya yang puitis dan kisahnya yang menyentuh.

Ceritanya dituturkan oleh Tania, gadis yang bersama ibu dan adiknya pernah hidup di jalanan sebelum ditolong oleh seorang laki-laki baik hati. Seiring waktu, rasa terima kasih Tania tumbuh menjadi perasaan yang lebih dalam, dan ia harus berdamai dengan perasaan itu.

Novel ini relatif pendek dan ditulis dengan gaya melankolis yang khas. Tema tentang cinta yang tak terucap, pengorbanan, dan menerima kenyataan membuat banyak pembaca merasa terhubung dengan kisahnya.

Buku ini cocok bagi pembaca yang menyukai kisah cinta yang lembut dan penuh perenungan.$$,
 $$https://covers.openlibrary.org/b/id/10441642-L.jpg$$),
($$Rasa$$,
 $$Tere Liye$$,
 $$Sabak Grip Nusantara$$,
 $$2022$$,
 $$Apakah memaafkan itu mudah diberikan? Apakah melupakan itu ringan dilakukan? Sayangnya, itu sering kali lebih enteng diucapkan, tapi di hati terdalam tetap begitulah. Bagaimana caranya kita memeluk erat semua rasa marah, benci, sakit hati, ketika itu bahkan baru mulai dibicarakan saja sudah menyakitkan? Bagaimana berdamai dengan situasi tersebut? Inilah novel tentang ’rasa’. Berbagai rasa berkumpul di novel ini. Jika kalian tertawa, menangis, atau merenung panjang saat membaca buku ini, ingatlah selalu: apapun yang terjadi atas kehidupan, tidak semuanya berjalan sesuai keinginan kita. Tapi kita selalu bisa menerimanya.

Rasa adalah novel karya Tere Liye yang diterbitkan Sabak Grip Nusantara pada tahun 2022. Sabak Grip Nusantara adalah penerbit yang menerbitkan banyak karya terbaru Tere Liye.

Seperti tergambar dari sinopsisnya, novel ini membahas pergulatan batin tentang memaafkan, melupakan, dan berdamai dengan rasa marah, benci, dan sakit hati. Tere Liye menempatkan berbagai perasaan itu sebagai pusat cerita, sehingga novel ini terasa reflektif.

Tema menerima keadaan yang tidak berjalan sesuai keinginan sudah sering muncul dalam karya-karya Tere Liye, misalnya Rembulan Tenggelam di Wajahmu dan Rindu. Pembaca yang menyukai karya-karya tersebut kemungkinan akan menikmati novel ini.

Buku ini cocok bagi pembaca yang mencari novel tentang pengampunan dan penerimaan, dengan bahasa yang sederhana dan mudah diikuti.$$,
 $$https://covers.openlibrary.org/b/id/14542360-L.jpg$$);
