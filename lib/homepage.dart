import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uasgeraldo/homescreen.dart';
import 'package:uasgeraldo/keranjang.dart';
import 'call.dart';
import 'profile.dart';
import 'riwayat.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const MainPage(),
      const HistoryPage(),
      const CallPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Klinik Sejahtera",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.cart_fill, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => const KeranjangPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        backgroundColor: Colors.blue.shade400,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house, size: 20),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, size: 20),
            label: "Riwayat",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.headphones, size: 20),
            label: "Pengaduan",
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_circle_fill, size: 20),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}
