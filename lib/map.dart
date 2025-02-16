import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uasgeraldo/homepage.dart';
import 'package:http/http.dart' as http;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List listRumkit = [];

  @override
  void initState() {
    super.initState();
    getAllRumkit();
  }

  Future<void> getAllRumkit() async {
    String urlRumkit = "http://10.0.3.2/server_uas/rumkit.php";
    try {
      var response = await http.get(Uri.parse(urlRumkit));
      listRumkit = jsonDecode(response.body);
      setState(() {
        listRumkit = jsonDecode(response.body);
      });
    } catch (exc) {
      if (kDebugMode) {
        print(exc);
      }
    }
  }

  void _showDialog(String namaRumkit, String nomorTelepon) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hubungi $namaRumkit'),
          content: const Text('Apakah Anda ingin menghubungi rumah sakit ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Menghubungi $namaRumkit...'),
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 6,
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.call, size: 15),
                  SizedBox(width: 8),
                  Text(
                    'Hubungi',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _openMaps(LatLng location) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Lokasi Rumah Sakit'), titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            backgroundColor: Colors.blue,
          ),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: location,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId("_currentLocation"),
                icon: BitmapDescriptor.defaultMarker,
                position: location,
              ),
            },
          ),
        ),
      ),
    );
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
                size: 25, color: Colors.white)),
        title: const Text(
          'Rumah Sakit',
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
      body: ListView.builder(
          itemCount: listRumkit.length,
          itemBuilder: (context, index) {
            var rumkit = listRumkit[index];

            if (rumkit['map'] == null || rumkit['map'].isEmpty) {
              return const SizedBox();
            }
            List<String> latLng = rumkit['map'].split(',');
            if (latLng.length != 2) {
              return const SizedBox();
            }
            double latitude = double.tryParse(latLng[0]) ?? 0.0;
            double longitude = double.tryParse(latLng[1]) ?? 0.0;
            LatLng location = LatLng(latitude, longitude);

            return Card(
              elevation: 5,
              margin: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (rumkit['gambar'] != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          rumkit['gambar'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text("Gambar tidak tersedia");
                          },
                        ),
                      ),
                    const SizedBox(height: 10),
                    Text(
                      rumkit['nama_rs'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      rumkit['alamat'],
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _showDialog(rumkit['nama_rs'], rumkit['no_telp']);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.phone, size: 15),
                              SizedBox(width: 5),
                              Text('Hubungi', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _openMaps(location);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 5,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.map, size: 15),
                              SizedBox(width: 5),
                              Text('Buka Maps', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
