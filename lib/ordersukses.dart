import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uasgeraldo/homepage.dart';

class OrderSuccessPage extends StatefulWidget {
  const OrderSuccessPage({super.key});

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 150,
          ),
          Center(
            child: Column(
              children: [
                Image.asset(
                  "./lib/assets/order.png",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Pesanan Anda Berhasil",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: () { Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const Homepage(),
              ));},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 124, 185, 232)),
              child: const Text(
                "Kembali ke halaman utama",
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }
}
