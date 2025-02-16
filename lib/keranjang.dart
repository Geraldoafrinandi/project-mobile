import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:uasgeraldo/homepage.dart';
import 'package:http/http.dart' as http;
import 'package:uasgeraldo/ordersukses.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({super.key});

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  String nama = '';
  String alamat = '';
  int idPasien = 1;

  List<dynamic> listCart = [];

  Future<void> getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      if (userId == null) {
        if (kDebugMode) {
          print('User ID tidak ditemukan di SharedPreferences');
        }
        return;
      }

      final response = await http.get(
        Uri.parse('http://10.0.3.2/server_uas/data_pasien.php?id=$userId'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data != null) {
          setState(() {
            nama = data['nama'] ?? 'Nama tidak tersedia';
            alamat = data['alamat'] ?? 'Alamat tidak tersedia';
          });
        } else {
          if (kDebugMode) {
            print('Data null.');
          }
        }
      } else {
        throw Exception(
            'Gagal mengambil data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  Future<void> getCart() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      if (userId == null) {
        if (kDebugMode) {
          print('User ID tidak ditemukan di SharedPreferences');
        }
        return;
      }

      final response = await http.post(
        Uri.parse('http://10.0.3.2/server_uas/get_cart.php'),
        body: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data is List) {
          setState(() {
            listCart = data;
          });
        } else if (data is Map) {
          if (data['keranjang'] != null && data['keranjang'] is List) {
            setState(() {
              listCart = data['keranjang'];
            });
          } else {
            if (kDebugMode) {
              print('Data tidak sesuai. Cart tidak ditemukan.');
            }
          }
        } else {
          if (kDebugMode) {
            print('Data tidak sesuai. Tipe data bukan List atau Map.');
          }
        }
      } else {
        throw Exception(
            'Gagal mengambil data keranjang. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  var total = "0";

  Future<void> getTotal() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('user_id');

      if (userId == null) {
        if (kDebugMode) {
          print('User ID tidak ditemukan di SharedPreferences');
        }
        return;
      }

      final response = await http.get(
        Uri.parse(
            'http://10.0.3.2/server_uas/total_belanja.php?user_id=$userId'),
      );

      // print('Response status: ${response.statusCode}');
      // print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          setState(() {
            total = data['total'];
          });
        } else {
          throw Exception(data['message'] ?? 'Gagal mengambil total harga');
        }
      } else {
        throw Exception(
            'Gagal mengambil total harga. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> checkout() async {
    var urlCheckout = "http://10.0.3.2/server_uas/checkout.php";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    try {
      final response = await http.post(
        Uri.parse(urlCheckout),
        body: {'user_id': userId},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['status'] == "Checkout Berhasil") {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //         content: const Row(
          //           children: [
          //             Icon(
          //               CupertinoIcons.checkmark_alt_circle,
          //               color: Colors.white,
          //             ),
          //             SizedBox(width: 8),
          //             Text('Checkout Berhasil!'),
          //           ],
          //         ),
          //         behavior: SnackBarBehavior.floating,
          //         backgroundColor: Colors.green,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         duration: const Duration(seconds: 1),
          //       ),
          // );
          Future.delayed(const Duration(milliseconds: 300), () {
            if (mounted) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const OrderSuccessPage(),
                ),
              );
            }
          });
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Row(
                children: [
                  Icon(
                    CupertinoIcons.clear_circled_solid,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text('Checkout Gagal :('),
                ],
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      } else {
        throw Exception(
            'Gagal melakukan checkout. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Terjadi kesalahan. Silakan coba lagi."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    getCart();
    getTotal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(left: 18),
          height: 220,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              children: <Widget>[
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Harga",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Rp. $total',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Jumlah Bayar",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Rp. $total',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        onPressed: () {
                          checkout();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade400),
                        child: const Text(
                          "Check Out",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => const Homepage(),
                ));
              },
              icon: const Icon(CupertinoIcons.arrow_left,
                  size: 25, color: Colors.white)),
          title: const Text(
            'Keranjang Saya',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue,
        ),
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Center(
                  child: Text(
                    "Detail Barang",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Nama",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      nama,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Alamat",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      alamat,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                padding: const EdgeInsets.only(bottom: 220),
                itemCount: listCart.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = listCart[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              item['gambar'],
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  item['nama_obat'] ?? 'Nama Obat',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                Text(
                                  "Rp. ${item['harga']}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
            ],
          ),
        ));
  }
}
