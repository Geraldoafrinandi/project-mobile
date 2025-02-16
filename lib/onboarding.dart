import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uasgeraldo/homepage.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController onBoardingController = PageController();
  int indexPage = 0;
  List<Map<String, String>> pagelist = [
    {"title": "Klinik Berobat", "image": "./lib/assets/onboarding1.jpg"},
    {"title": "Klinik Berobat", "image": "./lib/assets/onboarding2.jpg"},
    {"title": "Ayo Telusuri!", "image": "./lib/assets/onboarding3.jpeg"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: onBoardingController,
              onPageChanged: (page) {
                setState(() {
                  indexPage = page;
                });
              },
              itemCount: pagelist.length,
              itemBuilder: (context, index) {
                return OnBoardingData(
                  title: pagelist[index]['title']!,
                  image: pagelist[index]['image']!,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pagelist.length,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: indexPage == index ? Colors.blue : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              
                IconButton(
                  onPressed: () {
                    if (indexPage == pagelist.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Homepage()),
                      );
                    } else {
                      onBoardingController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  icon: const Icon(
                    CupertinoIcons.arrow_right,
                    size: 25,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class OnBoardingData extends StatelessWidget {
  final String title;
  final String image;

  const OnBoardingData({
    super.key,
    required this.title,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
  
        Image.asset(
          image, 
          height: 150,
          width: 300,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
      ],
    );
  }
}
