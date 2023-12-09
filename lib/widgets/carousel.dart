import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  ImageSlider({super.key});

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'images/jeweleryy.jpg',
      'images/electronicdevices.jpg',
      'images/clothesmen.jpg',
      'images/clotheswomen.jpg',
    ];

    return Column(
      children: [
        Container(
          height: 200.0,
          child: PageView.builder(
            itemCount: imagePaths.length,
            controller: PageController(
              initialPage: 0,
              viewportFraction: 0.8,
            ),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(0, 255, 193, 7),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Image.asset(
                  imagePaths[index],
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
