import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/widgets/smalltext.dart';
import "package:flutter/material.dart";

import '../ui/dimensions.dart';

class ExpandableTextWidget extends StatefulWidget {

  final String longtxt;
  final double? fontsize;
  const ExpandableTextWidget({
    Key? key,
    required this.longtxt,
    this.fontsize,
  }) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {

  late String firsthalf;
  late String secondhalf;

  bool hiddenText = true;
  double textHeight = Dimensions.screenHeight/5.63;


  @override
  void initState() {
    super.initState();
    if(widget.longtxt.length > textHeight){
      firsthalf = widget.longtxt.substring(0, textHeight.toInt());
      secondhalf = widget.longtxt.substring(textHeight.toInt() + 1, widget.longtxt.length);
    }else{
      firsthalf = widget.longtxt;
      secondhalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondhalf.isEmpty
          ?
        SmallText(txt: firsthalf,fontsize: widget.fontsize ?? Dimensions.OneUnitWidth * 14,)
          :
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SmallText(
                txt: hiddenText
                  ?
                ("$firsthalf....")
                  :
                (firsthalf + secondhalf),
              txtheight: Dimensions.OneUnitHeight * 1.6,
              fontsize: widget.fontsize ?? Dimensions.OneUnitWidth * 14,
            ),
            SizedBox(
              width: Dimensions.OneUnitWidth * 130,
              child: TextButton(
                onPressed: (){
                  setState(() {
                    hiddenText = !hiddenText;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SmallText(
                      txt: hiddenText
                          ?
                        "Show More"
                          :
                        "Show Less",
                      clr: CustomColor.ctmMilkGreen,
                      fontsize: Dimensions.OneUnitWidth * 15,
                    ),
                    Icon(
                      hiddenText ? Icons.keyboard_arrow_down_outlined : Icons.keyboard_arrow_up_outlined,
                      color: CustomColor.ctmMilkGreen,
                      size: Dimensions.OneUnitWidth * 32,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}
