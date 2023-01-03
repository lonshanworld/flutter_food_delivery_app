import 'package:food_delivery_app/ui/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import "package:flutter/material.dart";

class AccountWidget extends StatelessWidget {

  final AppIcon appIcon;
  final BigText bigText;
  const AccountWidget({
    Key? key,
    required this.appIcon,
    required this.bigText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: Dimensions.OneUnitWidth * 10,
          top: Dimensions.OneUnitHeight * 7,
          bottom: Dimensions.OneUnitHeight * 7,
        ),
        child: Row(
          children: <Widget>[
            appIcon,
            bigText,
          ],
        ),
      ),
    );
  }
}
