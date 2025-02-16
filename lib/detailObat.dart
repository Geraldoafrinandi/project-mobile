import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailObatPage extends StatefulWidget {
  final int obatId;
  const DetailObatPage({super.key, required this.obatId});

  @override
  State<DetailObatPage> createState() => _DetailObatPageState();
}

class _DetailObatPageState extends State<DetailObatPage> {
  late Map<String, dynamic> obatDetail = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getObatDetail();
  }

  tambahKeranjang() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('user_id');

  

  var urlTambahKeranjang = "http://10.0.3.2/server_uas/keranjang.php";

  var dataKeranjang = {
    'user_id': userId, 
    'produk_id': widget.obatId.toString(),
    'nama_obat': obatDetail['nama_obat'] ?? 'Unknown',
    'harga': obatDetail['harga'].toString(),
    'jumlah': '1',
  };

  try {
    var response = await http.post(
      Uri.parse(urlTambahKeranjang),
      body: dataKeranjang,
    );

    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['value'] == '1') {
        _showDialog(
          'Obat Ditambahkan Ke Keranjang',
          'Sukses',
          CupertinoIcons.check_mark_circled_solid,
          Colors.green,
        );
      } else {
        _showDialog(
          'Gagal Menambahkan Obat',
          'Gagal',
          CupertinoIcons.clear_circled,
          Colors.red,
        );
      }
    } else {
      _showDialog(
        'Terjadi kesalahan saat menghubungi server',
        'Error',
        CupertinoIcons.clear_circled_solid,
        Colors.red,
      );
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error: $e");
      _showDialog(
        'Terjadi Kesalahan',
        'Gagal',
        CupertinoIcons.clear_circled,
        Colors.red,
      );
    }
  }
}

  Future<void> getObatDetail() async {
    String urlObat =
        "http://10.0.3.2/server_uas/obat_detail.php?id=${widget.obatId}";
    try {
      var response = await http.get(Uri.parse(urlObat));

      if (response.statusCode == 200) {
        setState(() {
          obatDetail = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal memuat data obat")),
        );
        setState(() {
          isLoading = false;
        });
      }
    } catch (exc) {
      if (kDebugMode) {
        print("Error: $exc");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Terjadi kesalahan saat mengambil data")),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _showDialog(String message, String title, IconData icon, Color color) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          content: Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
        );
      },
    );

    Future.delayed(const Duration(seconds: 1), () {
      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Obat'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.network(
                      obatDetail['gambar'] ?? '',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 80);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      obatDetail['nama_obat'] ?? 'Nama Obat Tidak Tersedia',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rp ${obatDetail['harga'] ?? "0"}',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: tambahKeranjang,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade400),
                        child: isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Tambah ke keranjang',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Deskripsi: \n\n${obatDetail['keterangan'] ?? 'Deskripsi tidak tersedia'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}
