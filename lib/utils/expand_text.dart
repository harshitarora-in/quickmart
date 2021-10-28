import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
//import 'package:flutter_html/flutter_html.dart';

class ExpandText extends StatefulWidget {
  ExpandText(
      {Key? key,
      @required this.labelHeader,
      @required this.desc,
      @required this.shortDesc})
      : super(key: key);

  String? labelHeader;
  String? desc;
  String? shortDesc;

  @override
  _ExpandTextState createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  bool descTextShow = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.widget.labelHeader.toString(),
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          Html(
            data:
                descTextShow == true ? this.widget.desc : this.widget.shortDesc,
          ),
          GestureDetector(
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                descTextShow == true ? "Show less" : "Show more",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
              ),
              Icon(
                descTextShow == true
                    ? Icons.arrow_drop_up
                    : Icons.arrow_drop_down,
                color: Colors.red,
              )
            ]),
            onTap: () {
              setState(() {
                descTextShow = !descTextShow;
                print(descTextShow);
              });
            },
          )
        ],
      ),
    );
  }
}
