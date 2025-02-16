import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:uasgeraldo/detailObat.dart';
import 'package:uasgeraldo/homepage.dart';

class ObatPage extends StatefulWidget {
  const ObatPage({super.key});

  @override
  State<ObatPage> createState() => _ObatPageState();
}

class _ObatPageState extends State<ObatPage> {
  List<dynamic> listObat = [];
  List<dynamic> dataObat = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllObat();
    searchObat();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> searchObat() async {
    final search = searchController.text.trim();
    if (search.isEmpty) {
      getAllObat();
      return;
    }

    String urlSearch = "http://10.0.3.2/server_uas/search.php?search=$search";
    try {
      var responsesearch = await http.get(Uri.parse(urlSearch));

      if (responsesearch.statusCode == 200) {
        final List<dynamic> listsearchobat = jsonDecode(responsesearch.body);
        setState(() {
          listObat = listsearchobat;
        });
      } else {
        print("Error: Status code ${responsesearch.statusCode}");
      }
    } catch (exc) {
      if (kDebugMode) {
        print("Gagal mencari produk: $exc");
      }
    }
  }

  Future<void> getAllObat() async {
    String urlObat = "http://10.0.3.2/server_uas/obat.php";
    try {
      var response = await http.get(Uri.parse(urlObat));
      if (response.statusCode == 200) {
        setState(() {
          listObat = jsonDecode(response.body);
        });
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal memuat data obat")),
        );
      }
    } catch (exc) {
      if (kDebugMode) {
        print("Error: $exc");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Terjadi kesalahan saat mengambil data")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const Homepage(),
            ));
          },
          icon: const Icon(CupertinoIcons.arrow_left,
              size: 25, color: Colors.white),
        ),
        title: const Text(
          'Daftar Obat',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Stack(
          children: [
            Image.asset(
              './lib/assets/background.png',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Cari obat...",
                hintStyle: const TextStyle(color: Colors.black54),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  size: 20,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 216, 230, 237),
              ),
              onChanged: (search) {
                searchObat();
              },
            ),
          ),
          Expanded(
            child: listObat.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: listObat.length,
                    itemBuilder: (context, index) {
                      var obat = listObat[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailObatPage(obatId: obat['id']),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Image.network(
                                  obat['gambar'],
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.image_not_supported,
                                        size: 80);
                                  },
                                ),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        obat['nama_obat'] ??
                                            'Nama Obat Tidak Tersedia',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        'Rp ${obat['harga'] ?? "0"}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// class DetailObatPage extends StatelessWidget {
//   final Map<String, dynamic> obat;

//   const DetailObatPage({super.key, required this.obat});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Detail Obat'),
//         centerTitle: true,
//         backgroundColor: Colors.blue,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             Image.network(
//               obat['gambar'] ?? 'https://via.placeholder.com/150',
//               height: 150,
//               width: 150,
//               fit: BoxFit.cover,
//               errorBuilder: (context, error, stackTrace) {
//                 return const Icon(Icons.image_not_supported, size: 80);
//               },
//             ),
//             const SizedBox(height: 20),
//             Text(
//               obat['nama_obat'] ?? 'Nama Obat Tidak Tersedia',
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               'Rp ${obat['harga'] ?? "0"}',
//               style: const TextStyle(fontSize: 18, color: Colors.green),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                         '${obat['nama_obat']} berhasil ditambahkan ke keranjang'),
//                   ),
//                 );
//                 Navigator.pop(context);
//               },
//               child: const Text('Beli'),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'Deskripsi: ${obat['keterangan'] ?? 'Deskripsi tidak tersedia'}',
//               style: const TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
