# Project flutter Klinik Sehat "Sejahtera"

Project ini merupakan syarat kelulusan pada mata kuliah Pemograman Mobile. Project ini dibangun dengan menggunakan **Dart**, **MySql**, dan **PHP**. Project ini menyimpan data produk dan pengguna didalam database SQL dan menggunakan PHP sebagai backend nya.

**Fitur**
- **Tanya Dokter**: Fitur AI untuk berkonsultasi seputar kesehatan, obat, penyakit dan penyembuhan
- **Rumah Sakit**: Fitur petunjuk rumah sakit terdekat dan call center nya, petunjuk rumah sakit sudah di integrasikan dengan google maps
-  **Obat**: Fitur untuk membeli obat langsung sesuai dengan resep yang sudah diberikan dokter. Dapat menghemat waktu dan tidak perlu mengantri
-  **Berita Terkini**: Memberikan berita terbaru seputar kesehatan

## Teknologi Yang digunakan
- **Backend**: PHP
- **Database**: MySQl
- **Library**: Google Maps Flutter, Image Picker, Shared Preferences
- **Kredensial Autentikasi**: Google Maps Api Keys  Google Maps Api Keys - digunakan untuk mengintegrasikan dengan google maps. APi Keys ini bisa didapatkan melalui Google Cloud Console

## Instalasi
1. **Kloning repositori**:
     ```bash
     git clone https://github.com/Geraldoafrinandi/project-mobile.git
     cd project-mobile
     ```
2. **Import Database**
     Buat sebuah Database baru pada MySql dengan nama "db_klinik" kemudian import tabelnya
     
3. **Pindahkan Folder Backend**
     Pindahkan folder yang bernama **server_uas** ke dalam folder xampp -> htdocs

4. **Jalankan Aplikasi**
     ### Pastikan memiliki emulator yang sudah support Google Play Store
     ```bash
     flutter run
     ```
