import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> imagePaths = [
    'images/clothes1.jpg',
  'images/clothes2.jpg',
   'images/clothes3.jpg',
   'images/clothes4.jpg',
   'images/clothes5.jpg',
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dots Indicator Example'),
      ),
      body: Column(
        children: [
          Container(
            height: 200.0,
            child: PageView.builder(
              itemCount: imagePaths.length,
              controller: PageController(
                initialPage: 0,
                viewportFraction: 0.8,
              ),
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    imagePaths[index],
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.0),
          DotsIndicator(
            dotsCount: imagePaths.length,
            position: _currentIndex,
            decorator: DotsDecorator(
              color: Colors.grey, // Inactive dot color
              activeColor: Colors.blueAccent, // Active dot color
              spacing: EdgeInsets.all(5.0), // Space between dots
              size: const Size.square(8.0), // Size of each dot
              activeSize: const Size(16.0, 8.0), // Size of active dot
            ),
          ),
        ],
      ),
    );
  }
}