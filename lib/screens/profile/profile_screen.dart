import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/global_base/show_custom_message.dart';
import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import '../../widgets/account_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
      // print("User has loggin");
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColor.ctmMilkGreen,
        centerTitle: true,
        title: const BigText(
          txt: "Profile",
          clr: CustomColor.primaryBgColor,
        ),
      ),
      backgroundColor: CustomColor.primaryBgColor,
      body: GetBuilder<UserController>(
        builder: (userController){
          return _userLoggedIn
              ?
          (userController.isLoading
              ?
          ListView(
            padding: EdgeInsets.only(
              top: Dimensions.OneUnitHeight * 20,
              bottom: Dimensions.OneUnitHeight * 100,
            ),
            children: [
              AppIcon(
                icn: Icons.person,
                bgClr: CustomColor.ctmMilkGreen,
                icnClr: CustomColor.primaryBgColor,
                icnSize: Dimensions.OneUnitHeight * 80,
                padd: Dimensions.OneUnitHeight * 35,
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 20,),
              AccountWidget(
                appIcon: AppIcon(
                  icn: Icons.person,
                  bgClr: CustomColor.ctmMilkGreen,
                  icnClr: CustomColor.primaryBgColor,
                  icnSize: Dimensions.OneUnitHeight * 26,
                ),
                bigText: BigText(
                  txt: userController.userModel!.name,
                ),
              ),

              SizedBox(height: Dimensions.OneUnitHeight * 20,),
              AccountWidget(
                appIcon: AppIcon(
                  icn: Icons.phone,
                  bgClr: Colors.yellow,
                  icnClr: CustomColor.primaryBgColor,
                  icnSize: Dimensions.OneUnitHeight * 26,
                ),
                bigText: BigText(
                  txt: userController.userModel!.phone,
                ),
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 20,),
              AccountWidget(
                appIcon: AppIcon(
                  icn: Icons.email,
                  bgClr: Colors.orange,
                  icnClr: CustomColor.primaryBgColor,
                  icnSize: Dimensions.OneUnitHeight * 26,
                ),
                bigText: BigText(
                  txt: userController.userModel!.email,
                ),
              ),

              // SizedBox(height: Dimensions.OneUnitHeight * 20,),
              // AccountWidget(
              //   appIcon: AppIcon(
              //     icn: Icons.location_on,
              //     bgClr: Colors.red,
              //     icnClr: CustomColor.primaryBgColor,
              //     icnSize: Dimensions.OneUnitHeight * 26,
              //   ),
              //   bigText: BigText(
              //     txt: "Fill in your address",
              //   ),
              // ),

              SizedBox(height: Dimensions.OneUnitHeight * 20,),
              AccountWidget(
                appIcon: AppIcon(
                  icn: Icons.person,
                  bgClr: Colors.purpleAccent,
                  icnClr: CustomColor.primaryBgColor,
                  icnSize: Dimensions.OneUnitHeight * 26,
                ),
                bigText: const BigText(
                  txt: "Send Message",
                ),
              ),

              SizedBox(height: Dimensions.OneUnitHeight * 20,),
              AccountWidget(
                appIcon: AppIcon(
                  icn: Icons.logout,
                  bgClr: Colors.blue,
                  icnClr: CustomColor.primaryBgColor,
                  icnSize: Dimensions.OneUnitHeight * 26,
                  fun: (){
                    if(Get.find<AuthController>().userLoggedIn()){
                      Get.find<AuthController>().clearSharedData();
                      Get.find<CartController>().clear();
                      Get.find<CartController>().clearCartHistory();
                      Get.offNamed(RouteHelper.getSignInPage());
                    }else{
                      showCustomSnackbar("You need to Sign in to Log out", title: "No account", isError: true);
                    }

                  },
                ),
                bigText: const BigText(
                  txt: "Log Out",
                ),
              ),
            ],
          )
              :
          const Center(
            child: CircularProgressIndicator(
              color: CustomColor.ctmMilkGreen,
            ),
          ))
              :
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BigText(
                  txt: "You need to log in to continue",
                  clr: CustomColor.ctmMilkGreen,
                  fontsize: Dimensions.OneUnitHeight * 20,
                ),
                SizedBox(height: Dimensions.OneUnitHeight * 20,),
                ElevatedButton(
                  onPressed: (){
                    Get.toNamed(RouteHelper.getSignInPage());
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                      horizontal: Dimensions.OneUnitWidth * 60,
                      vertical: Dimensions.OneUnitHeight * 18,
                    )),
                    backgroundColor: MaterialStateProperty.all(CustomColor.ctmMilkGreen),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 10)),
                    )),
                  ),
                  child: BigText(
                    txt: "Sign In",
                    clr: CustomColor.primaryBgColor,
                    fontsize: Dimensions.OneUnitHeight * 20,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
