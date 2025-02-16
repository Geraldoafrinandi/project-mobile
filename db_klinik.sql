-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 08, 2025 at 08:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_klinik`
--

-- --------------------------------------------------------

--
-- Table structure for table `berita`
--

CREATE TABLE `berita` (
  `id` int(11) NOT NULL,
  `judul_berita` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `gambar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `berita`
--

INSERT INTO `berita` (`id`, `judul_berita`, `deskripsi`, `gambar`) VALUES
(1, 'Perdana di Wilayah Timur! Operasi Bedah Jantung Terbuka Berhasil Dilakukan RSUP dr. Ben Mboi', 'RSUP Dr. Ben Mboi, Kupang, mencetak sejarah baru dengan sukses melaksanakan operasi bedah jantung terbuka pertama di Provinsi Nusa Tenggara Timur (NTT) pada Jumat (20/12).\r\n\r\nOperasi ini dilakukan pada seorang pasien perempuan berusia 26 tahun yang didiag', 'https://sehatnegeriku.kemkes.go.id/wp-content/uploads/2024/12/IMG-20241221-WA0009-750x536.jpg'),
(2, 'Cara Melakukan Pemeriksaan Kesehatan Gratis Saat Ulang Tahun\r\n\r\n', 'KOMPAS.com - Pemerintah melalui Kementrian Kesehatan akan meluncurkan program pemeriksaan kesehatan gratis bagi masyarakat yang bisa diakses setiap ulang tahun. Program ini akan mulai berlaku pada Februari 2025. Dalam keterangan yang disampaikan oleh Juru Bicara Kantor Kepresidenan Dedek Prayudi, untuk mengakses pemeriksaan ini masyarakat yang berulang tahun tinggal datang ke puskesmas atau fasilitas kesehatan lain yang terdekat lalu menunjukkan kartu identitas. Setelah itu petugas akan memverifikasi data tersebut berbasis data kependudukan untuk mengakses layanan pemeriksaan. Baca juga: Kemenkes Ungkap Tantangan Utama Penanganan HIV di Indonesia \"Mudah caranya dan nilainya tidak sedikit apabila dibayar dengan kantong pribadi. Dapatkan hak, pertahankan pola hidup sehat agar tetap produktif dan makin sejahtera, demi masa depan keluarga dan bangsa,\" katanya. Sebelumnya Menteri Kesehatan Budi Gunadi telah mengatakan bahwa program pemeriksaan kesehatan ini bisa diakses oleh seluruh masyarakat. Adapun tiket pemeriksaan kesehatan gratis diberikan melalui aplikasi SatuSehat Mobile. Program ini dijalankan untuk memperkuat upaya deteksi dini dan pencegahan penyakit sesuai dengan kategori usia.\r\n\r\nKategori skrining berdasarkan golongan usia: Balita: Pemeriksaan fokus pada deteksi penyakit bawaan lahir, seperti hipotiroid kongenital. Dengan penanganan dini diharapkan dapat mencegah kematian atau kecacatan. Remaja (di bawah 18 tahun): Pemeriksaan remaja meliputi pemeriksaan obesitas, diabetes, dan kesehatan gigi. Tujuannya, untuk mendeteksi masalah kesehatan umum di usia ini. Dewasa: Difokuskan pada deteksi dini kanker, termasuk kanker payudara dan serviks, yang merupakan penyebab utama kematian pada wanita di Indonesia, serta kanker prostat pada laki-laki. Lansia: Pemeriksaan lansia meliputi pemeriksaan alzheimer, osteoporosis, dan kesehatan terkait penuaan.\r\n\r\n', 'https://asset.kompas.com/crops/ed0t1d2XZ04jFKjc0jeYEK7gZJg=/0x0:1000x667/1200x800/data/photo/2019/11/26/5ddcd9f09a3ed.jpg'),
(3, 'Batasi Gula dan Garam untuk MPASI', 'Memasuki usia 6 bulan, bayi dapat mulai diperkenalkan dengan berbagai tekstur dan cita rasa makanan melalui pemberian Makanan Pendamping ASI (MPASI). Salah satu pertanyaan yang sering muncul di kalangan orang tua adalah, bolehkah menggunakan gula dan garam dalam MPASI?\r\n\r\nDirektur Gizi dan Kesehatan Ibu dan Anak Kementerian Kesehatan (Kemenkes) RI, dr. Lovely Daisy, MKM, menjelaskan bahwa penggunaan gula dan garam untuk MPASI pada bayi harus dibatasi.\r\n\r\n“Anjuran sesuai ‘Pedoman Pemberian Makan Bayi dan Anak’ yang diterbitkan Kemenkes tahun 2020, penggunaan gula dan garam dalam MPASI harus dibatasi,” jelas Daisy di Jakarta.\r\n\r\n“Asupan gula dalam bentuk gula tambahan dibatasi di bawah 5% total kalori untuk anak di bawah usia 2 tahun. Asupan gula yang disarankan berupa gula alamiah seperti buah segar, bukan jus buah atau produk dengan tambahan pemanis.”\r\n\r\nPeraturan Menteri Kesehatan Nomor 41 Tahun 2014 tentang Pedoman Gizi Seimbang mengatur terkait pesan gizi seimbang untuk anak usia 6-24 bulan, yakni MPASI yang baik apabila tidak menggunakan gula dan garam tambahan, penyedap rasa, pewarna, dan pengawet.', 'https://sehatnegeriku.kemkes.go.id/wp-content/uploads/2024/12/background-sugar-cubes-750x536.jpg'),
(4, 'Kolaborasi Kemenkes dan KemenPPPA Hadirkan Akses Mudah Kontak Darurat KDRT di SATUSEHAT Mobile', 'Kementerian Kesehatan (Kemenkes) berkolaborasi dengan Kementerian Pemberdayaan Perempuan dan Perlindungan Anak (KemenPPPA) meluncurkan fitur akses cepat kontak darurat Kekerasan Dalam Rumah Tangga (KDRT) di SATUSEHAT Mobile.\r\n\r\nStaf Ahli Bidang Teknologi Kesehatan sekaligus Chief of Digital Transformation Office (DTO) Kemenkes, Setiaji, menjelaskan bahwa penambahan fitur baru ini merupakan respons pemerintah untuk meningkatkan dukungan bagi korban kekerasan berbasis gender.\r\n\r\n“Dengan fitur ini, SATUSEHAT Mobile diharapkan menjadi aplikasi yang inklusif. Tidak hanya dapat diandalkan untuk layanan kesehatan, melainkan juga untuk memberikan akses bantuan cepat terhadap isu-isu mendesak seperti KDRT,” ujar Setiaji, Selasa (17/12).\r\n\r\nUntuk mengakses fitur kontak darurat tersebut, masyarakat hanya perlu membuka aplikasi SATUSEHAT Mobile, kemudian memilih opsi ‘Darurat KDRT’ untuk terhubung ke hotline layanan Sahabat Perempuan dan Anak (SAPA) 129. Selain itu, aplikasi ini juga menyediakan fitur serupa untuk kontak ‘Darurat Medis’ yang terhubung ke hotline 119.', 'https://sehatnegeriku.kemkes.go.id/wp-content/uploads/2024/12/IMG-20241219-WA0031-750x536.jpg'),
(5, 'Kementerian Kesehatan Raih Predikat Informatif dalam Anugerah Keterbukaan Informasi Publik 2024', 'Kementerian Kesehatan (Kemenkes) Republik Indonesia berhasil meraih kategori “Informatif” pada Anugerah Keterbukaan Informasi Publik 2024 yang diselenggarakan oleh Komisi Informasi Pusat pada Selasa (17/12). Kategori “Informatif” merupakan pencapaian tertinggi dalam penilaian keterbukaan informasi.\r\n\r\nBagi Kemenkes, prestasi ini menunjukkan peningkatan signifikan dibandingkan tahun sebelumnya. Penghargaan ini sekaligus menjadi bukti komitmen Kemenkes dalam menyediakan informasi publik yang transparan, akurat, dan mudah diakses oleh masyarakat.\r\n\r\nDalam sambutannya, Ketua Komisi Informasi Pusat,Dr. Donny Yoesgiantoro, menyampaikan bahwa dari total 363 badan publik yang dimonitoring dan dievaluasi, sebanyak 162 badan publik berhasil meraih predikat informatif, meningkat signifikan dibandingkan tahun sebelumnya.\r\n\r\n“Anugerah ini adalah bentuk apresiasi terhadap badan publik yang konsisten dan inovatif dalam mengimplementasikan keterbukaan informasi. Kami berharap upaya ini terus berkembang di tahun-tahun mendatang,” ungkap Ketua Komisi Informasi Pusat.\r\n\r\nKomisi Informasi Pusat berharap acara ini dapat mendorong seluruh badan publik untuk lebih transparan dan inovatif dalam memberikan pelayanan informasi kepada masyarakat sesuai dengan amanat Undang-Undang Keterbukaan Informasi Publik.\r\n\r\n“Terima kasih kepada semua pihak yang telah menyukseskan monitoring dan evaluasi keterbukaan informasi tahun ini. Kerja sama ini sangat penting dalam mendorong tata kelola yang transparan dan akuntabel,” tutup Dr. Donny.', 'https://sehatnegeriku.kemkes.go.id/wp-content/uploads/2024/12/IMG-20241218-WA0004-750x536.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `pesan` text NOT NULL,
  `balasan` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chat`
--

INSERT INTO `chat` (`id`, `pesan`, `balasan`) VALUES
(1, 'halo', 'halo! ada yang bisa saya bantu'),
(2, 'apa kabar?', 'Saya baik, Terima Kasih!'),
(3, 'siapa kamu?', 'Saya adalah DokterBot, saya akan membantu keluhan anda'),
(4, 'saya demam', 'Untuk sembuh dari demam, Anda bisa melakukan beberapa hal berikut:\r\nMinum air putih: Demam dapat menyebabkan dehidrasi, sehingga Anda perlu minum banyak air putih untuk mengembalikan cairan yang hilang. Anda bisa minum air hangat untuk memberikan kenyamanan. \r\nIstirahat yang cukup: Istirahat yang cukup dapat membantu tubuh melawan infeksi dan mengembalikan vitalitas tubuh. \r\nKompres: Anda bisa mengompres dengan air hangat pada dahi dan ketiak, atau mengompres dengan air dingin pada pergelangan tangan dan betis. \r\nHindari minuman berkafein dan beralkohol: Minuman tersebut dapat membuat Anda dehidrasi. \r\nKonsumsi buah: Buah-buahan yang mengandung vitamin C seperti semangka, mangga, dan jeruk dapat meningkatkan imun tubuh. \r\nKonsumsi obat penurun panas: Anda bisa mengonsumsi obat penurun panas seperti paracetamol atau ibuprofen. Dosis paracetamol yang dianjurkan untuk orang dewasa adalah 500–1000 miligram (mg) setiap 6 jam. \r\nKonsumsi bahan-bahan herbal: Anda bisa mengonsumsi bahan-bahan herbal seperti daun kelor dan jahe. \r\nBerjemur di pagi hari: Berjemur di pagi hari dapat membantu menurunkan demam. '),
(5, 'saya batuk', 'Batuk umumnya akan sembuh sendiri dalam beberapa hari, tetapi Anda bisa melakukan beberapa cara untuk mempercepat penyembuhannya, seperti:\r\nMinum air putih\r\nMinum air putih hangat minimal 8 gelas per hari dapat membantu melegakan tenggorokan, mengencerkan dahak, dan mencegah dehidrasi. \r\nMinum obat batuk\r\nAnda bisa mengonsumsi obat batuk yang dijual bebas di apotek sesuai dengan aturan yang tertera pada kemasan. \r\nMinum minuman hangat\r\nMinuman hangat seperti teh jahe, teh peppermint, atau air jeruk lemon dengan madu dapat membantu meredakan batuk. \r\nBerkumur dengan air garam\r\nBerkumur dengan air garam hangat dapat membantu membersihkan dan mengeluarkan dahak. \r\nTinggikan kepala saat tidur\r\nJika batuk kering disebabkan oleh refluks asam lambung, Anda bisa meredakannya dengan meninggikan posisi kepala dengan cara menumpuk 2 bantal. \r\nIstirahat yang cukup\r\nPerbanyak istirahat di rumah agar cepat pulih dari batuk. \r\nJaga kebersihan ruangan\r\nJauhi bahan-bahan yang dapat menyebabkan batuk seperti asap rokok, debu, atau parfum. Anda juga bisa memasang air purifier di kamar untuk menjaga kualitas udara tetap baik. \r\nHindari alkohol dan kopi\r\nHindari konsumsi alkohol, kopi, dan minuman berkafein lainnya yang justru bisa menyebabkan dehidrasi.\r\n\r\nSemoga lekas sembuh :) '),
(6, 'terima kasih', 'Baik, senang bisa membantu. Semoga lekas sembuh :)');

-- --------------------------------------------------------

--
-- Table structure for table `detail_order`
--

CREATE TABLE `detail_order` (
  `id` int(11) NOT NULL,
  `produk_id` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `resi` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_order`
--

INSERT INTO `detail_order` (`id`, `produk_id`, `jumlah`, `harga`, `resi`) VALUES
(33, 1, 1, 5000, '20250108074837'),
(34, 2, 1, 10000, '20250108074837');

-- --------------------------------------------------------

--
-- Table structure for table `keranjang`
--

CREATE TABLE `keranjang` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `produk_id` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `obat`
--

CREATE TABLE `obat` (
  `id` int(11) NOT NULL,
  `nama_obat` varchar(25) NOT NULL,
  `keterangan` text NOT NULL,
  `kategori` varchar(255) NOT NULL,
  `harga` varchar(10) NOT NULL,
  `gambar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `obat`
--

INSERT INTO `obat` (`id`, `nama_obat`, `keterangan`, `kategori`, `harga`, `gambar`) VALUES
(1, 'Paracetamol', 'Tujuan: Meredakan demam dan nyeri, termasuk sakit kepala\r\n\r\nDewasa: 500–1.000 mg, diberikan setiap 4–6 jam sekali. Dosis maksimal 4.000 mg per hari. \r\n\r\nCara Menggunakan Paracetamol\r\n \r\n(Acetaminophen) dengan Benar\r\nParacetamol dapat dikonsumsi sebelum atau sesudah makan. Minumlah obat ini dengan bantuan segelas air.\r\n\r\nSebelum mengonsumsi paracetamol sirop atau tetes, kocok botol terlebih dahulu.\r\n\r\nGunakan alat takar atau pipet yang tersedia di dalam kemasan paracetamol sirop maupun tetes. Jangan menggunakan sendok makan atau sendok teh karena dosisnya bisa tidak sesuai.\r\n\r\nParacetamol tidak untuk digunakan dalam jangka panjang. Konsumsi obat ini bisa segera dihentikan begitu keluhan mereda.\r\nBila demam belum membaik setelah 3 hari atau nyeri belum mereda setelah 7 hari, hentikan konsumsi paracetamol dan konsultasikan ke dokter.\r\n\r\nPada anak-anak, segera bawa ia ke dokter jika demam belum turun setelah 3 hari, atau nyeri belum membaik setelah 5 hari pemberian paracetamol.\r\n\r\nSimpan paracetamol di tempat bersuhu ruangan dan terhindar dari paparan sinar matahari langsung. Jauhkan obat dari jangkauan anak-anak.', 'obat', '5000', 'https://ecs7.tokopedia.net/img/cache/700/product-1/2016/6/15/7540678/7540678_35e2c584-9921-4fd3-8fdc-b4de5411312a.jpg'),
(2, 'Antihistamin', 'Antihistamin adalah kelompok obat yang digunakan untuk meredakan gejala reaksi alergi, misalnya pada rhinitis atau biduran. Walaupun bisa meredakan gejala akibat reaksi alergi, antihistamin tidak bisa menyembuhkan alergi itu sendiri.\r\n\r\nPada saat tubuh terpapar zat pemicu alergi (alergen), histamin akan meningkat jumlahnya dan menyebabkan reaksi alergi. Antihistamin bekerja dengan cara menghambat kerja dan menurunkan jumlah histamin yang dikeluarkan oleh tubuh. Dengan begitu, gejala akibat reaksi alergi bisa mereda.', 'obat', '10000', 'https://d1vbn70lmn1nqe.cloudfront.net/prod/wp-content/uploads/2024/09/17100452/5-Daftar-Obat-yang-Mengandung-Antihistamin-untuk-Pereda-Alergi-.jpg.webp'),
(3, 'ENERVON C', 'Enervon C Multivitamin\r\n\r\n1 tablet Enervon C Multivitamin mengandung:\r\n\r\nVitamin C (Asam Askorbat) 500 mg\r\nNiasinamida 50 mg\r\nKalsium pantetonat 20 mg\r\nVitamin B1 (Tiamin Mononitrat) 50 mg\r\nVitamin B2 (Riboflavin) 25 mg\r\nVitamin B6 (Piridoksin HCl) 10 mg\r\nVitamin B12 5 mcg', 'vitamin', '20000', 'https://res-2.cloudinary.com/dk0z4ums3/image/upload/c_scale,h_500,w_500/v1/production/pharmacy/products/1661014096_5fb389d441ab59059e86a578'),
(4, 'AMOXSAN 500 MG ', 'AMOXSAN adalah obat antibiotik yang mengandung Amoxicillin 500 mg. Amoxicillin merupakan turunan Penisilin dengan aktifitas antibakteri spektrum luas. \r\nObat ini bersifat bakterisid yang efektif terhadap bakteri Gram negatif dan Gram positif seperti Staphylococci, Streptococci, Enterococci, S. pneumoniae, N. gonorrhoeae, H influenzas, E. coli, dan P. mirabiis. \r\nDalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.', 'Antibiotik', '5000', 'https://d2qjkwm11akmwu.cloudfront.net/products/a4f4d159-2e8b-4f00-8ba4-605099e3d839_product_image_url.webp'),
(5, 'ZITROLIN KAPLET 500 MG', 'ZITROLIN merupakan obat dengan kandungan Azithromycin dalam bentuk kaplet salut selaput. Azithromycin merupakan antibiotik golongan macrolide yang diberikan secara oral.\r\nMekanisme kerja dari azithromycin adalah dengan berikatan pada ribosom subunit 50 S sehingga mengganggu sintesis protein bakteri. Obat ini digunakan untuk terapi dengan infeksi ringan sampai sedang, saluran pernapasan atas dan bawah, kulit dan jaringan lunak, penyakit menular seksual. \r\nDalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.', 'Antibiotik', '10000', 'https://d2qjkwm11akmwu.cloudfront.net/products/f9bf636d-22bb-4761-9448-9d436338ee5c_product_image_url.webp'),
(6, 'AMOXSAN DRY SIRUP 60 ML', 'AMOXSAN adalah obat antibiotik yang mengandung Amoxicillin 125 mg tiap 5 ml. Amoxicillin merupakan turunan Penisilin dengan aktifitas antibakteri spektrum luas. \r\nObat ini bersifat bakterisid yang efektif terhadap bakteri Gram negatif dan Gram positif seperti Staphylococci, Streptococci, Enterococci, S. pneumoniae, N. gonorrhoeae, H influenzas, E. coli, dan P. mirabiis. \r\nDalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.', 'Antibiotik', '20000', 'https://d2qjkwm11akmwu.cloudfront.net/products/cef941df-136a-41c7-b44a-449ba346da57_product_image_url.webp'),
(7, 'AMOXICILLIN 250 MG ', 'AMOXICILLIN merupakan antibiotik yang mengandung zat aktif Amoxicillin. Amoxicillin termasuk golongan antibiotik beta-lactam turunan ampicillin. \r\nObat ini digunakan pada infeksi saluran nafas atas, otitis media, bronkitis akut dan kronik, pneumonia, sistitis, uretritis, pielonefritis, bakteriuria asimptomatik pada masa hamil, gonore, infeksi kulit dan jaringan lunak. \r\nAmoxicillin memiliki spektrum mirip dengan ampisilin yaitu gram positif dan gram negatif. Bekerja dengan berikatan dengan penicillin-binding protein yang menghambat proses transpeptidation (proses cross-linking di sintesis dinding sel), mengaktivkan enzim autolisis pada dinding sel bakteri. Proses ini menyebabkan lisis dari dinding sel dan penghancuran sel bakteri. \r\nDalam penggunaan obat ini harus SESUAI DENGAN PETUNJUK DOKTER.', 'Antibiotik', '10000', 'https://d2qjkwm11akmwu.cloudfront.net/products/2cdeb522-60e3-4ac7-b5f6-7a374ae52777_product_image_url.webp');

-- --------------------------------------------------------

--
-- Table structure for table `pasien`
--

CREATE TABLE `pasien` (
  `id` int(11) NOT NULL,
  `nama` varchar(25) NOT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `jenis_kelamin` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pasien`
--

INSERT INTO `pasien` (`id`, `nama`, `alamat`, `tgl_lahir`, `jenis_kelamin`) VALUES
(1, 'pasien', 'Padang', '2024-12-17', 'laki-laki'),
(48, 'dzaky', 'padang', '2025-01-08', 'Laki-laki'),
(49, 'geraldo2', 'padang', '2025-01-08', 'Laki-laki');

-- --------------------------------------------------------

--
-- Table structure for table `pengaduan`
--

CREATE TABLE `pengaduan` (
  `id` int(11) NOT NULL,
  `pesan` text NOT NULL,
  `gambar` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pengaduan`
--

INSERT INTO `pengaduan` (`id`, `pesan`, `gambar`) VALUES
(10, 'tes', 'uploads/IMG_20250103_024528.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id` int(11) NOT NULL,
  `resi` varchar(25) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_at` date NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id`, `resi`, `user_id`, `order_at`, `status`) VALUES
(24, '20250108074837', 49, '2025-01-08', 1);

-- --------------------------------------------------------

--
-- Table structure for table `rumkit`
--

CREATE TABLE `rumkit` (
  `id` int(11) NOT NULL,
  `nama_rs` varchar(50) NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `no_telp` varchar(25) NOT NULL,
  `gambar` varchar(255) NOT NULL,
  `map` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rumkit`
--

INSERT INTO `rumkit` (`id`, `nama_rs`, `alamat`, `no_telp`, `gambar`, `map`) VALUES
(1, 'Rumah Sakit Unand', 'Kompleks Kampus Unand, Limau Manis, Kecamatan Pauh, Kota Padang, Sumatera Barat 25176', ' (0751) 8465000', 'https://padangkita.com/wp-content/uploads/2024/04/images-2-1_11zon-1.webp', '-0.9205575265109, 100.45699623468603'),
(2, 'Semen Padang Hospital', 'Jl. By Pass KM 7 Kelurahan Pisang Kecamatan Pauh', '0751-777888', 'https://www.padang.go.id/uploads/images/image_default_621dabf85bd53.jpg', '-0.9417543482767621, 100.39966748150242'),
(3, ' RSIA Cicik', 'l. Dr. Sutomo No. 94, Kubu Marapalam, Padang Timur, Kota Padang', '(0751) 38846', 'https://www.padang.go.id/uploads/images/image_default_621dca6636f69.jpg', '-0.9500347587568005, 100.38623677621015'),
(4, 'RSUD Dr.M.Djamil Padang', 'Jl. Perintis Kemerdekaan, Sawahan Timur, Kec. Padang Timur, Kota Padang, Sumatera Barat 25171', '(0751) 37030', 'https://www.padang.go.id/uploads/images/image_default_621d9c4971a6a.jpg', '-0.9432326335466318, 100.36751786537043');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `nama`, `email`, `password`) VALUES
(1, 'pasien', 'testing@gmail.com', '12345678'),
(48, 'dzaky', 'dzaky@gmail.com', '12345678'),
(49, 'geraldo2', 'geraldo@gmal.com', '1234567');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `berita`
--
ALTER TABLE `berita`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `detail_order`
--
ALTER TABLE `detail_order`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `keranjang`
--
ALTER TABLE `keranjang`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `obat`
--
ALTER TABLE `obat`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pasien`
--
ALTER TABLE `pasien`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rumkit`
--
ALTER TABLE `rumkit`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `berita`
--
ALTER TABLE `berita`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `detail_order`
--
ALTER TABLE `detail_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `keranjang`
--
ALTER TABLE `keranjang`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `obat`
--
ALTER TABLE `obat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `pasien`
--
ALTER TABLE `pasien`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `pengaduan`
--
ALTER TABLE `pengaduan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pesanan`
--
ALTER TABLE `pesanan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `rumkit`
--
ALTER TABLE `rumkit`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
