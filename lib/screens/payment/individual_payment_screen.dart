import 'package:food_delivery_app/global_base/show_custom_message.dart';
import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import "package:flutter/material.dart";
import 'package:webview_flutter/webview_flutter.dart';
import "package:get/get.dart";

import '../../ui/customColor.dart';
import '../../widgets/bigtext.dart';

class IndividualPaymentScreen extends StatefulWidget {

  final int uri;
  final String txt;

  const IndividualPaymentScreen({
    Key? key,
    required this.uri,
    required this.txt,
  }) : super(key: key);

  @override
  State<IndividualPaymentScreen> createState() => _IndividualPaymentScreenState();
}

class _IndividualPaymentScreenState extends State<IndividualPaymentScreen> {

  WebViewController webViewController = WebViewController();
  var loadingPercentage = 0;


  @override
  void initState() {
    super.initState();
    late String URL;
    if(widget.uri == 1){
      URL = "https://www.paypal.com/us/signin";
    }else if(widget.uri == 2){
      URL = "https://myanmar.visa.com";
    }

    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.loadRequest(Uri.parse(URL));
    webViewController.enableZoom(true);
    webViewController.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress){
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageStarted: (url){
          setState(() {
            loadingPercentage = 0;
          });
        },
        onPageFinished: (url){
          setState(() {
            loadingPercentage = 100;
          });
        }
      ),
    );
    webViewController.clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: BigText(txt: widget.txt,clr: CustomColor.primaryBgColor,),
        backgroundColor: CustomColor.ctmMilkGreen,
      ),
      backgroundColor: CustomColor.primaryBgColor,
      body: Stack(
        children: [
          if(loadingPercentage < 100)LinearProgressIndicator(
            value: loadingPercentage / 100,
          ),
          WebViewWidget(
            controller: webViewController,
          ),
          Positioned(
            bottom: Dimensions.OneUnitHeight * 50,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: (){
                  showCustomSnackbar("Thank you for your purchases", title: "Purchased",isError: false);
                  Get.toNamed(RouteHelper.cartPage);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(CustomColor.ctmMilkGreen),
                  padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                    vertical: Dimensions.OneUnitHeight * 7,
                    horizontal: Dimensions.OneUnitWidth * 25,
                  )),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 10)),
                  )),
                ),
                child: BigText(txt: "Purchase",clr: CustomColor.primaryBgColor,fontsize: Dimensions.OneUnitHeight * 22,),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
