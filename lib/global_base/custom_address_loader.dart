import 'package:food_delivery_app/ui/customColor.dart';
import "package:flutter/material.dart";

class CustomAddressLoader extends StatelessWidget {
  const CustomAddressLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white.withOpacity(0.7),
      child: const Center(
        child: CircularProgressIndicator(
          color: CustomColor.ctmMilkGreen,
        ),
      ),
    );
  }
}
