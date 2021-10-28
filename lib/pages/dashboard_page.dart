import 'package:quickmart/constants.dart';
import 'package:quickmart/widgets/banner_carousel.dart';
import 'package:flutter/material.dart';
import 'package:quickmart/widgets/widget_home_categories.dart';
import 'package:quickmart/widgets/widget_bank_offers_banner.dart';
import 'package:quickmart/widgets/widget_offers_list.dart';
import 'package:quickmart/widgets/widget_tag_product.dart';
import 'package:quickmart/config.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.grey.shade100,
      child: ListView(
        children: [
          bannerCarousel(context),
          WidgetCategories(),
          SizedBox(
            height: 8.0,
          ),
          offersList(context,
              offerImage: kOfferImageSet1,
              bgColor: Colors.transparent,
              title: "In focus today",
              subtitle: "Explore the coolest brands",
              titleColor: Colors.black87,
              subtitleColor: Colors.black45,
              subtitleBottomPadding: 5.0,
              imageLeftMargin: 4.0),
          offersBannerCarousel(context),
          WidgetTagProducts(
              labelName: "Popular Deals", tagId: Config.todayOffersTag),
          WidgetTagProducts(labelName: "Deals", tagId: Config.topSellingTag),
          offersList(context,
              offerImage: kOfferImageSet2,
              bgColor: kLightOrange,
              title: "Grab the deal!",
              subtitle: "Explore the coolest brands",
              titleColor: kOrange,
              subtitleColor: Colors.black45)
        ],
      ),
    ));
  }
}
