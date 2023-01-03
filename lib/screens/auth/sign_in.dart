import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/screens/auth/sign_up.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/smalltext.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import '../../controllers/auth_controller.dart';
import '../../global_base/show_custom_message.dart';
import '../../ui/dimensions.dart';
import '../../widgets/bigtext.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var passwordController = TextEditingController();
    var emailController = TextEditingController();

    void _login(AuthController authController){
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(email.isEmpty){
        showCustomSnackbar("Please enter your email.",title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackbar("Please enter your valid email address.",title: "Valid Email");
      }else if (password.isEmpty){
        showCustomSnackbar("Please enter your password.",title: "Password");
      }else if(password.length < 7){
        showCustomSnackbar("Password cannot be less than 7.",title: "Password");
      }else{
        // SignUpBody signUpBody = SignUpBody(
        //   name: name,
        //   phone: phone,
        //   email: email,
        //   password: password,
        // );
        authController.login(email,password).then((status){
          if(status.isSuccess){
            // Get.toNamed(RouteHelper.getCartPage());
            showCustomSnackbar("Thanks for signing up",title: "Perfect",isError: false);
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackbar(status.message,title: "Server Registration Error");
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(
        builder: (authController){
          return !authController.isLoading
              ?
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Dimensions.OneUnitHeight * 60,),
                Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: Dimensions.OneUnitHeight * 80,
                    backgroundImage: const AssetImage(
                      "assets/images/logo part 1.png",
                    ),
                  ),
                ),
                // SizedBox(height: Dimensions.OneUnitHeight * 10,),
                Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.OneUnitWidth * 20,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        txt: "Hello",
                        clr: Colors.black,
                        fontsize: Dimensions.OneUnitHeight * 50,
                      ),
                      BigText(
                        txt: "Sign into your account",
                        clr: Colors.grey,
                        fontsize: Dimensions.OneUnitHeight * 18,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.OneUnitHeight * 40,),
                AppTextField(
                  txtController: emailController,
                  hinttxt: "Email",
                  icn: Icons.email,
                  icnClr: Colors.orange,
                ),
                SizedBox(height: Dimensions.OneUnitHeight * 20,),
                AppTextField(
                  txtController: passwordController,
                  hinttxt: "Password",
                  icn: Icons.password,
                  icnClr: Colors.yellow,
                  isPassword: true,
                ),
                SizedBox(height: Dimensions.OneUnitHeight * 20,),
                Container(
                  padding: EdgeInsets.only(
                    right: Dimensions.OneUnitWidth * 20,
                  ),
                  alignment: Alignment.centerRight,
                  child: SmallText(
                    txt: "Sign into your account",
                    clr: Colors.grey,
                    fontsize: Dimensions.OneUnitHeight * 14,
                  ),
                ),
                SizedBox(height: Dimensions.OneUnitHeight * 50,),
                ElevatedButton(
                  onPressed: (){
                    _login(authController);
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                      vertical: Dimensions.OneUnitHeight * 12,
                      horizontal: Dimensions.OneUnitWidth * 24,
                    )),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 30)),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(CustomColor.ctmMilkGreen),
                  ),
                  child: BigText(
                    txt: "Sign In",
                    clr: CustomColor.primaryBgColor,
                    fontsize: Dimensions.OneUnitHeight * 20,
                  ),
                ),
                SizedBox(height: Dimensions.OneUnitHeight * 60,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      txt: "Don't have an account? ",
                      clr: Colors.grey,
                      fontsize: Dimensions.OneUnitHeight * 16,
                    ),
                    RichText(
                      text: TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = ()=> Get.to(() => const SignUpPage(),transition: Transition.zoom),
                          text: "Create",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimensions.OneUnitHeight * 20,
                            fontFamily: "Nunito",
                            fontWeight: FontWeight.w700,
                          )
                      ),
                    )
                  ],
                ),

                SizedBox(height: Dimensions.OneUnitHeight * 100,),
              ],
            ),
          )
              :
          const Center(
            child: CircularProgressIndicator(color: CustomColor.ctmMilkGreen,),
          );
        },
      ),
    );
  }
}
