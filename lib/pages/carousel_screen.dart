import 'package:dicoding/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselScreen extends StatefulWidget {
  static const routeName = "/carousel_screen";

  const CarouselScreen({super.key});

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final List<Map<String, String>> carouselItems = [
    {
      'title': 'Efficient Task Management',
      'description': 'Streamline your workflow with our powerful task management features, enabling you to stay organized and boost productivity.',
      'image': 'images/carousel1.jpg',
    },
    {
      'title': 'Seamless Collaboration',
      'description': 'Foster effective teamwork with our collaborative tools, allowing you to easily share files, communicate, and coordinate projects with your team.',
      'image': 'images/carousel2.jpg',
    },
    {
      'title': 'Intuitive Analytics',
      'description': 'Gain valuable insights into your data through comprehensive analytics, empowering you to make data-driven decisions and optimize your performance.',
      'image': 'images/carousel3.jpg',
    },
  ];

  int currentIndex = 0;
  String next = "Next";
  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel App'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                CarouselSlider(
                  carouselController: _carouselController,
                  options: CarouselOptions(
                    height: double.infinity,
                    enableInfiniteScroll: false,
                    viewportFraction: 1.0,
                    onPageChanged: (index, _) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                  ),
                  items: carouselItems.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  item["image"]!,
                                  width: 200,
                                  height: 200,
                                ),
                                Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 16.0),
                                Padding(
                                  padding: const EdgeInsets.only(left:64.0,right:64.0),
                                  child: Text(
                                    item['description']!,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 72,
                          width: 84,
                          child: IconButton(
                            icon: const Row(
                              children: [
                                Icon(Icons.arrow_back_rounded,size: 32),
                                Text('Prev'),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                currentIndex = currentIndex > 0 ? currentIndex - 1 : 0;
                              });
                              if (currentIndex < 2){
                                next = "Next";
                              }else{
                                next = "Login";
                              }
                              _carouselController.animateToPage(currentIndex);
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: carouselItems.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _carouselController.animateToPage(entry.key),
                              child: Container(
                                width: 12.0,
                                height: 12.0,
                                margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentIndex == entry.key ? Colors.blue : Colors.grey,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        SizedBox(
                          height: 72,
                          width: 84,
                          child: IconButton(
                            icon: Row(
                              children: [
                                Text(next),
                                const Icon(Icons.arrow_forward_rounded,size: 32),
                              ],
                            ),
                            iconSize: 32.0,
                            onPressed: () {
                              if (currentIndex==2){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                              }
                              setState(() {
                                currentIndex = currentIndex < carouselItems.length - 1 ? currentIndex + 1 : currentIndex;
                              });
                              if (currentIndex < 2){
                                next = "Next";
                              }else{
                                next = "Login";
                              }
                              _carouselController.animateToPage(currentIndex);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
