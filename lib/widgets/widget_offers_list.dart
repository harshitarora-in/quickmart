import 'package:flutter/material.dart';

Widget offersList(BuildContext context,
    {List<String>? offerImage,
    Color? bgColor,
    String? title,
    String? subtitle,
    Color titleColor = Colors.black,
    Color subtitleColor = Colors.grey,
    double? imageLeftMargin = 0,
    double? subtitleBottomPadding = 0}) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Container(
        width: double.infinity,
        color: bgColor,
        padding: EdgeInsets.only(
            left: 10, top: 15.0, bottom: subtitleBottomPadding!.toDouble()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toString(),
              style: TextStyle(
                color: titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            Text(
              subtitle.toString(),
              style: TextStyle(
                  color: subtitleColor,
                  fontWeight: FontWeight.w300,
                  fontSize: 16),
            ),
          ],
        )),
    Container(
      color: bgColor,
      padding: EdgeInsets.only(bottom: 20.0, left: 0.0),
      height: 200,
      child: ListView.separated(
        padding: EdgeInsets.only(left: imageLeftMargin!.toDouble()),
        separatorBuilder: (context, _) => SizedBox(width: 0),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: offerImage!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 160,
            width: 120,
            child: Image.network(
              offerImage[index],
              fit: BoxFit.contain,
            ),
          );
        },
      ),
    ),
  ]);
}
