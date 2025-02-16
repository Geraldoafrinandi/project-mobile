import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:uasgeraldo/login.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();

  String? jenisKelamin;
  Future<void> register() async {
    var urlRegister = "http://10.0.3.2/server_uas/register.php";

    final Map<String, dynamic> queryParams = {
      "nama": namaController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "alamat": alamatController.text,
      "jenis_kelamin": jenisKelamin,
    };
    

    try {
      http.Response response =
          await http.post(Uri.parse(urlRegister), body: queryParams);
          // print(response.body);

      if (response.statusCode == 200) {
        var user = jsonDecode(response.body);
        if (user is Map<String, dynamic>) {
          if (user['pesan'] == 'Sukses') {
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Row(
                    children: [
                      Icon(
                        CupertinoIcons.checkmark_alt_circle,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8),
                      Text('Akun Berhasil Didaftarkan'),
                    ],
                  ),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            }

            Future.delayed(const Duration(milliseconds: 500), () {
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage(),
                  ),
                );
              }
            });
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Format data tidak valid'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Terjadi kesalahan pada server'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terjadi Kesalahan'),
            backgroundColor: Colors.red,
          ),
        );
      }
      if (kDebugMode) {
      print("Error: $error");
      
        
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/background3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              "Halo \nSilahkan isi data anda!",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 200.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              color: Colors.white,
            ),
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                children: [
                  TextField(
                    controller: namaController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          CupertinoIcons.person_circle,
                          color: Colors.grey,
                        ),
                        labelText: "Nama",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 37, 173, 247),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0,
                                color: Colors.blue,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          CupertinoIcons.mail_solid,
                          color: Colors.grey,
                        ),
                        labelText: "Email",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 37, 173, 247),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0,
                                color: Colors.blue,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 37, 173, 247),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0,
                                color: Colors.blue,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: alamatController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.location_on_outlined,
                          color: Colors.grey,
                        ),
                        labelText: "Alamat",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 37, 173, 247),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0,
                                color: Colors.blue,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(height: 15),

                  Container(
                    
                    padding:
                        const EdgeInsets.all(5.0), 
                    child: Row(
                      children: [
                        const Text(
                          'Jenis Kelamin ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 37, 173, 247),
                          ),
                        ),
                        Radio<String>(
                          value: 'Laki-laki',
                          groupValue: jenisKelamin,
                          onChanged: (String? value) {
                            setState(() {
                              jenisKelamin = value;
                            });
                          },
                        ),
                        const Text(
                          'Laki-laki',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 37, 173, 247),
                          ),
                        ),
                        Radio<String>(
                          value: 'Perempuan',
                          groupValue: jenisKelamin,
                          onChanged: (String? value) {
                            setState(() {
                              jenisKelamin = value;
                            });
                          },
                        ),
                        const Text(
                          'Perempuan',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 37, 173, 247),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const LoginPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 37, 173, 247),
                      // primary: const Color.fromARGB(255, 37, 173, 247),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
