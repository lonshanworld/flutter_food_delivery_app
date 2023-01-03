import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:food_delivery_app/screens/cart/cart_screen.dart';
import 'package:food_delivery_app/screens/history/cart_history_screen.dart';
import 'package:food_delivery_app/screens/home/main_home_screen.dart';
import 'package:food_delivery_app/screens/profile/profile_screen.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import "package:flutter/material.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;

  List pages = [
    const MainHomeScreen(),
    const CartHistoryScreen(),
    const CartPage(),
    const ProfileScreen(),
  ];

  void onTapNar(int index){
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: pages[_selectedIndex],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              color: CustomColor.ctmMilkGreen,
              onTap: onTapNar,
              animationDuration: const Duration(milliseconds: 300),
              height: Dimensions.OneUnitWidth * 65,
              items: [
                Icon(
                  Icons.home,
                  color: CustomColor.primaryBgColor,
                  size: Dimensions.OneUnitWidth * 30,
                  semanticLabel: "Home",
                ),
                Icon(
                  Icons.archive,
                  color: CustomColor.primaryBgColor,
                  size: Dimensions.OneUnitWidth * 30,
                  semanticLabel: "History",
                ),
                Icon(
                  Icons.shopping_cart,
                  color: CustomColor.primaryBgColor,
                  size: Dimensions.OneUnitWidth * 30,
                  semanticLabel: "Cart",
                ),
                Icon(
                  Icons.person,
                  color: CustomColor.primaryBgColor,
                  size: Dimensions.OneUnitWidth * 30,
                  semanticLabel: "Me",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
