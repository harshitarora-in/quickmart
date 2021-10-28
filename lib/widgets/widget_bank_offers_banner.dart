import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

Widget offersBannerCarousel(BuildContext context) {
  List<String> images = [
    "http://quickmart.harshitarora.in/wp-content/uploads/2021/10/hp_aff_m_mastercard_360_111021.jpg",
    "http://quickmart.harshitarora.in/wp-content/uploads/2021/10/hp_aff_m_paytm_360_111021.jpg",
    "http://quickmart.harshitarora.in/wp-content/uploads/2021/10/hp_aff_m_indusind_360_111021.jpg",
    "http://quickmart.harshitarora.in/wp-content/uploads/2021/10/hp_aff_m_dbs_360_111021.jpg",
  ];
  return Column(children: [
    Text(
      "BANK OFFERS",
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    ),
    SizedBox(
      height: 2.0,
    ),
    Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      child: Divider(
        thickness: 1.0,
        color: Colors.grey[400],
      ),
    ),
    Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 5.0),
        height: 190.0,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              images[index],
              fit: BoxFit.fill,
            );
          },
          itemCount: images.length,
          autoplay: true,
          autoplayDelay: kDefaultAutoplayDelayMs,
          pagination: SwiperPagination(
              margin: EdgeInsets.only(top: 15.0),
              builder: DotSwiperPaginationBuilder(
                  size: 5.0,
                  activeSize: 9.0,
                  space: 4.0,
                  color: Colors.transparent,
                  activeColor: Colors.transparent)),
          viewportFraction: 0.8,
          scale: 0.8,
        )),
    SizedBox(
      height: 5.0,
    ),
    Container(
      margin: EdgeInsets.fromLTRB(15.0, 0, 15.0, 10),
      child: Divider(
        thickness: 1.0,
        color: Colors.grey[400],
      ),
    ),
  ]);
}
