import 'package:flutter/material.dart';

class CustomStepper extends StatefulWidget {
  CustomStepper(
      {Key? key,
      @required this.iconSize,
      @required this.lowerLimit,
      @required this.stepValue,
      @required this.upperLimit,
      @required this.value,
      @required this.onChanged,
      this.height = 40})
      : super(key: key);

  final int? lowerLimit;
  final int? upperLimit;
  final int? stepValue;
  final double? iconSize;
  int? value;
  final double? height;
  final ValueChanged<dynamic>? onChanged;

  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.height,
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 1, spreadRadius: 0.5)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  widget.value = widget.value == widget.lowerLimit
                      ? widget.lowerLimit
                      : widget.value =
                          (widget.value! - widget.stepValue!.toInt());
                  this.widget.onChanged!(widget.value);
                });
              },
              icon: Icon(Icons.remove)),
          Container(
            width: this.widget.iconSize,
            child: Text(
              "${this.widget.value}",
              style: TextStyle(fontSize: widget.iconSize! * 0.8),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  widget.value = widget.value == widget.upperLimit
                      ? widget.upperLimit
                      : widget.value =
                          (widget.value! + widget.stepValue!.toInt());
                  this.widget.onChanged!(widget.value);
                });
              },
              icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
