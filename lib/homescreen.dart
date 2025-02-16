import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uasgeraldo/chat.dart';
import 'package:uasgeraldo/keranjang.dart';
import 'package:uasgeraldo/map.dart';
import 'package:uasgeraldo/obat.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController bannerController = PageController();
  // final searchController = TextEditingController();
  int indexBanner = 0;
  Timer? timer;

  List<dynamic> listAllBerita = [];
  // List<dynamic> dataObat = [];

  @override
  void initState() {
    super.initState();
    bannerController.addListener(() {
      setState(() {
        indexBanner = bannerController.page?.round() ?? 0;
      });
    });
    bannerOnBoarding();
    getAllBerita();
  }

  Future<void> getAllBerita() async {
    String urlBerita = "http://10.0.3.2/server_uas/berita.php";
    try {
      var response = await http.get(Uri.parse(urlBerita));
      listAllBerita = jsonDecode(response.body);
      setState(() {
        listAllBerita = jsonDecode(response.body);
      });
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  void bannerOnBoarding() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (indexBanner < 3) {
        indexBanner++;
      } else {
        indexBanner = 0;
      }
      bannerController.animateToPage(indexBanner,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() {
    bannerController.dispose();
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> bannerList = [
      './lib/assets/banner1.jpg',
      './lib/assets/banner3.jpg',
      './lib/assets/banner2.jpg',
      './lib/assets/banner4.jpg',
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 5),
            const SizedBox(height: 5),
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: bannerController,
                itemCount: bannerList.length,
                itemBuilder: (context, index) {
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset(
                      bannerList[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                bannerList.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: indexBanner == index ? Colors.blue : Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Card(
                      elevation: 5,
                      child: InkWell(
                        child: SizedBox(
                          width: 60,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                './lib/assets/dokter2.png',
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 5),
                              const Text("Tanya Dokter",
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ChatPage(),
                            ),
                          );
                        },
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: InkWell(
                        child: SizedBox(
                          width: 60,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                './lib/assets/rumkit.png',
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 5),
                              const Text("Rumah Sakit",
                                  style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ))
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => const MapPage(),
                          ));
                        },
                      ),
                    ),
                    Card(
                      elevation: 5,
                      child: InkWell(
                        child: SizedBox(
                          width: 60,
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                './lib/assets/obat.png',
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 5),
                              const Text("Obat",
                                  style: TextStyle(
                                      fontSize: 8,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black))
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) => const ObatPage(),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Text(
                  "Berita Terkini",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: listAllBerita.length,
                itemBuilder: (context, index) {
                  var berita = listAllBerita[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBerita(berita: berita),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            if (berita['gambar'] != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  berita['gambar'],
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text("Gambar tidak tersedia");
                                  },
                                ),
                              ),
                            const SizedBox(height: 10),
                            Text(
                              berita['judul_berita'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              (berita['deskripsi']
                                  ?.split(' ')
                                  .take(10)
                                  .join(' ')),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            )
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

class DetailBerita extends StatelessWidget {
  final dynamic berita;

  const DetailBerita({Key? key, required this.berita}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(berita['judul_berita'])),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (berita['gambar'] != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  berita['gambar'],
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              berita['judul_berita'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              berita['deskripsi'],
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
