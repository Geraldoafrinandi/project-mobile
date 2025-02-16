import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uasgeraldo/homepage.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();

    _messages.add({
      'sender': 'server',
      'message': 'Halo! Saya dokterBot, ada yang bisa saya bantu?'
    });
  }

  Future<void> kirimPesan() async {
    final message = _controller.text;

    if (message.isEmpty) return;

    setState(() {
      _messages.add({'sender': 'user', 'message': message});
      _controller.clear();
    });

    final url = Uri.parse('http://10.0.3.2/server_uas/chat.php');

    try {
      await Future.delayed( const Duration(seconds: 1));
      final response = await http.post(
        url,
        body: jsonEncode({'message': message}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _messages.add({'sender': 'server', 'message': data['response']});
        });
      } else {
        setState(() {
          _messages.add({
            'sender': 'server',
            'message': 'Gagal mendapatkan respons dari server.'
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'sender': 'server',
          'message': 'Terjadi kesalahan. Cek koneksi Anda.'
        });
      });
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
                size: 25, color: Colors.white)),
        title: const Text(
          'DokterBot',
          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message['sender'] == 'user';

                return Row(
                  mainAxisAlignment:
                      isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    if (!isUser) 
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('./lib/assets/dokter2.png'),
                      ),
                    if (!isUser)
                      const SizedBox(width: 8), 
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width *
                              0.7), 
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[100] : Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12),
                          topRight: const Radius.circular(12),
                          bottomLeft:
                              isUser ? const Radius.circular(12) : Radius.zero,
                          bottomRight:
                              isUser ? Radius.zero : const Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        message['message']!,
                        style:const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    if (isUser)
                      const SizedBox(width: 8), 
                    if (isUser) 
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage('./lib/assets/default.jpg'),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Tulis pesan',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: kirimPesan,
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.send_rounded, color: Colors.blue,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
