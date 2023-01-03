import "package:flutter/material.dart";

import '../ui/dimensions.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController txtController;
  final String hinttxt;
  final IconData icn;
  final Color icnClr;
  final bool isPassword;

  const AppTextField({
    Key? key,
    required this.txtController,
    required this.hinttxt,
    required this.icn,
    required this.icnClr,
    this.isPassword = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(
        left: Dimensions.OneUnitWidth * 20,
        right: Dimensions.OneUnitWidth * 20,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 15)),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              spreadRadius: 1,
              offset: const Offset(1,1),
              color: Colors.grey.withOpacity(0.2),
            ),
          ]
        ),
        child: TextField(
          obscureText: isPassword,
          controller: txtController,
          decoration: InputDecoration(
            hintText: hinttxt,
            prefixIcon: Icon(icn,color: icnClr,),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 15)),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.white,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 15)),
              borderSide: const BorderSide(
                width: 1,
                color: Colors.white,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 15)),
            ),
          ),
        ),
      ),
    );
  }
}
