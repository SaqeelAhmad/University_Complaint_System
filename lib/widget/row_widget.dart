import 'package:flutter/material.dart';
class RowWidget extends StatefulWidget {

  String title1,title2,title3;

   RowWidget({Key? key, required this.title1,required this.title2,required this.title3}) : super(key: key);

  @override
  State<RowWidget> createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 5,right: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title1),Text(widget.title2),Text(widget.title3),
          Row(
            children: [
              Text(widget.title1),
              Row(
                children: [
                  Text(widget.title2),

                ],
              ),
              Row(
                children: [
                  Text(widget.title3),

                ],
              )


            ],
          )
        ],

      ),

    );
  }
}
