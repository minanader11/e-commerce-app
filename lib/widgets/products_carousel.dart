import 'package:e_commerce/data/fakedata.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/main.dart';

class ProductsCarosuel extends StatelessWidget {
  final List<dynamic> images =
      products.map((product) => product['image']).toList();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 190,
        enlargeCenterPage: true,
        autoPlay: true,
      ),
      items: images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(0, 255, 255, 255),
              ),
              child: Image.network(
                image,
                fit: BoxFit.contain,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
