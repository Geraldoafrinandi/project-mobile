import 'dart:convert'; // Import untuk jsonDecode
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<dynamic> orders = [];

  Future<void> getOrders() async {
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
      Uri.parse('http://10.0.3.2/server_uas/riwayat.php'),
      body: {'user_id': userId}, 
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is List) {
        setState(() {
          orders = data;
        });
      } else {
        if (kDebugMode) {
          print('Data tidak sesuai format. Harus berupa List.');
        }
      }
    } else {
      if (kDebugMode) {
        print('Gagal mengambil data. Status code: ${response.statusCode}');
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error: $e');
    }
  }
}

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: orders.isEmpty
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                './lib/assets/history.png', 
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 16),
              const Text(
                'Tidak ada riwayat pesanan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      'Resi: ${order['resi']} - ${order['order_at']}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: order['detail'].map<Widget>((detail) {
                            return ListTile(
                              leading: Image.network(detail['gambar'],
                                  width: 50, height: 50), 
                              title: Text(detail['namaProduk']),
                              subtitle: Text(
                                  'Jumlah: ${detail['jumlah']} | Harga: ${detail['harga']}'),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () { Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailPage(orderDetail: order),
                        ),
                      );},
                  ),
                );
              },
            ),
    );
  }
}

class OrderDetailPage extends StatelessWidget {
  final Map<String, dynamic> orderDetail;

  const OrderDetailPage({Key? key, required this.orderDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan ${orderDetail['resi']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
      
            Text(
              'Resi: ${orderDetail['resi']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Tanggal Pesanan: ${orderDetail['order_at']}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Detail Produk:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            
 
            Expanded(
              child: ListView.builder(
                itemCount: orderDetail['detail'].length,
                itemBuilder: (context, index) {
                  final product = orderDetail['detail'][index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        
                            product['gambar'] != null
                                ? Image.network(
                                    product['gambar'],
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  )
                                : const Icon(Icons.image, size: 100),

                            const SizedBox(height: 10),

                         
                            Text(
                              product['namaProduk'],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                     
                            Text(
                              'Jumlah: ${product['jumlah']} | Harga: ${product['harga']}',
                              style: const TextStyle(fontSize: 16),
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
      ),
    );
  }
}