import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:uasgeraldo/homepage.dart';
import 'package:uasgeraldo/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
  var url = "http://10.0.3.2/server_uas/login.php";
  final Map<String, dynamic> queryParams = {
    "email": emailController.text,
    "password": passwordController.text,
  };

  try {
    http.Response response = await http.post(Uri.parse(url), body: queryParams);

    if (response.statusCode == 200) {
      var user = jsonDecode(response.body);

      if (user['status'] == "Login berhasil") {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        await prefs.setString('user_id', user['user_id']);
        await prefs.setString('email', user['email']);
        await prefs.setString('nama', user['nama']);

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
                  Text('Login berhasil!'),
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

        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) => const Homepage(),
              ),
            );
          }
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(user['error'] ?? 'Login gagal'),
              behavior: SnackBarBehavior.floating,
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
          content:
              Text('Tidak dapat terhubung ke server. Periksa koneksi Anda.'),
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
              image: AssetImage("./lib/assets/background3.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.only(top: 60.0, left: 22),
            child: Text(
              "Halo\nSelamat Datang!",
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
              padding: const EdgeInsets.only(left: 25.0, right: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // TextField(
                  //   controller: namaController,
                  //   decoration: const InputDecoration(
                  //       suffixIcon: Icon(
                  //         CupertinoIcons.person_circle,
                  //         color: Colors.grey,
                  //       ),
                  //       label: Text(
                  //         "Nama",
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           color: Color.fromARGB(255, 37, 173, 247),
                  //         ),
                  //       )),
                  // ),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          CupertinoIcons.mail_solid,
                          color: Colors.grey,
                        ),
                        label: Text(
                          "Email",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 37, 173, 247),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0,
                                color: Colors.blue,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.grey,
                        ),
                        label: Text(
                          "Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 37, 173, 247),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 3.0,
                                color: Colors.blue,
                                style: BorderStyle.solid),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Belum punya akun?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 130),
                  GestureDetector(
                    onTap: () {
                      login();
                    },
                    child: Container(
                      height: 55,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 37, 173, 247),
                            Color.fromARGB(255, 80, 68, 207)
                          ],
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
