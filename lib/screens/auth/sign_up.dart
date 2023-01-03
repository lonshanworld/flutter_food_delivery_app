import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/global_base/show_custom_message.dart';
import 'package:food_delivery_app/models/signup_body.dart';
import 'package:food_delivery_app/screens/auth/sign_in.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:flutter/gestures.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";

import '../../routes/routeHelpers.dart';
import '../../ui/dimensions.dart';
import '../../widgets/bigtext.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      "t.png",
      "f.png",
      "g.png"
    ];

    void _registration(AuthController authController){
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if(name.isEmpty){
        showCustomSnackbar("Please enter your name.",title: "Name");
      }else if(phone.isEmpty){
        showCustomSnackbar("Please enter your phone number.",title: "Phone number");
      }else if(email.isEmpty){
        showCustomSnackbar("Please enter your email.",title: "Email");
      }else if(!GetUtils.isEmail(email)){
        showCustomSnackbar("Please enter your valid email address.",title: "Valid Email");
      }else if (password.isEmpty){
        showCustomSnackbar("Please enter your password.",title: "Password");
      }else if(password.length < 7){
        showCustomSnackbar("Password cannot be less than 7.",title: "Password");
      }else{
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            // print("Success");
            showCustomSnackbar("Thanks for signing up",title: "Perfect",isError: false);
            // Get.toNamed(RouteHelper.getCartPage());
            Get.toNamed(RouteHelper.getInitial());
          }else{
            showCustomSnackbar(status.message,title: "Server Registration Error");
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (_authController){
        return !_authController.isLoading
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
              SizedBox(height: Dimensions.OneUnitHeight * 15,),
              AppTextField(
                txtController: emailController,
                hinttxt: "Email",
                icn: Icons.email,
                icnClr: Colors.orange,
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 15,),
              AppTextField(
                txtController: passwordController,
                hinttxt: "Password",
                icn: Icons.password_rounded,
                icnClr: Colors.orange,
                isPassword: true,
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 15,),
              AppTextField(
                txtController: nameController,
                hinttxt: "Name",
                icn: Icons.person,
                icnClr: CustomColor.ctmMilkGreen,
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 15,),
              AppTextField(
                txtController: phoneController,
                hinttxt: "Phone",
                icn: Icons.phone,
                icnClr: Colors.yellow,
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 30,),
              ElevatedButton(
                onPressed: (){
                  _registration(_authController);
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
                  txt: "Sign Up",
                  clr: CustomColor.primaryBgColor,
                  fontsize: Dimensions.OneUnitHeight * 20,
                ),
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 10,),
              RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = ()=> Get.to(() => const SignInPage(),transition: Transition.zoom,),
                    text: "Have an Account Already?",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: Dimensions.OneUnitHeight * 18,
                        fontFamily: "Nunito"
                    )
                ),
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 30,),
              Text(
                "Use one of the following method",
                style: TextStyle(
                  fontSize: Dimensions.OneUnitHeight * 14,
                  fontFamily: "Nunito",
                  color: Colors.black54,
                ),
              ),
              Wrap(
                children: List.generate(3, (index) => Padding(
                  padding: EdgeInsets.only(
                    top: Dimensions.OneUnitHeight * 5,
                    left: Dimensions.OneUnitHeight * 5,
                    right: Dimensions.OneUnitHeight * 5,
                  ),
                  child:  CircleAvatar(
                    radius: Dimensions.OneUnitHeight * 30,
                    backgroundImage: AssetImage(
                        "assets/images/${signUpImages[index]}"
                    ),
                  ),
                )),
              ),
              SizedBox(height: Dimensions.OneUnitHeight * 100,),
            ],
          ),
        )
            :
        const Center(child: CircularProgressIndicator(
          color: CustomColor.ctmMilkGreen,
        ));
      },),
    );

  }
}
