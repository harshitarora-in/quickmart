import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:quickmart/constants.dart';

Widget bannerCarousel(BuildContext context) {
  List<String> images = [
    "https://quickmart.harshitarora.in/wp-content/uploads/2021/09/banner1.webp",
    "https://quickmart.harshitarora.in/wp-content/uploads/2021/09/banner2.webp",
    "https://quickmart.harshitarora.in/wp-content/uploads/2021/09/banner3.webp",
    "https://quickmart.harshitarora.in/wp-content/uploads/2021/09/banner4.webp",
    "https://quickmart.harshitarora.in/wp-content/uploads/2021/09/banner5.webp",
    "https://quickmart.harshitarora.in/wp-content/uploads/2021/09/banner6.webp",
  ];
  return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5.0),
      height: 180.0,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            images[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: 6,
        autoplay: true,
        autoplayDelay: kDefaultAutoplayDelayMs,
        pagination: SwiperPagination(
            margin: EdgeInsets.only(top: 15.0),
            builder: DotSwiperPaginationBuilder(
                size: 5.0,
                activeSize: 9.0,
                space: 4.0,
                color: Colors.orangeAccent,
                activeColor: kOrange)),
        viewportFraction: 0.81,
        scale: 0.9,
      ));
}
