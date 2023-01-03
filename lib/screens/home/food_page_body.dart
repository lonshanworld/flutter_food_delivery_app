import 'package:dots_indicator/dots_indicator.dart';
import 'package:food_delivery_app/constants/app_constants.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommende_product_controller.dart';
import 'package:food_delivery_app/models/product_model.dart';
import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import 'package:food_delivery_app/widgets/app_column.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import 'package:food_delivery_app/widgets/icon_with_text.dart';
import 'package:food_delivery_app/widgets/smalltext.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _curPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.OneUnitHeight * 200;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _curPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Dimensions.OneUnitHeight * 10,),
        // Slider section
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return popularProducts.isloaded
              ?
          SizedBox(
            // color: Colors.green,
            height: Dimensions.OneUnitHeight * 270,
            child: PageView.builder(
                controller: pageController,
                itemCount: popularProducts.popularProductList.length,
                itemBuilder: (context, position) {
                  return _buildPageItem(
                    position,
                    popularProducts.popularProductList[position],
                  );
                },
            ),
          )
              :
          const Center(
            child: CircularProgressIndicator(
              color: CustomColor.ctmMilkGreen,
            ),
          );
        }),
        // SizedBox(
        //   height: Dimensions.OneUnitHeight * 5,
        // ),

        // dots indicators
        GetBuilder<PopularProductController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty ? 1 : popularProducts.popularProductList.length,
            position: _curPageValue,
            decorator: DotsDecorator(
              color: Colors.grey,
              activeColor: CustomColor.ctmMilkGreen,
              size: Size.square(Dimensions.OneUnitHeight * 9.0),
              activeSize: Size(Dimensions.OneUnitHeight * 20.0,
                  Dimensions.OneUnitHeight * 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(
          height: Dimensions.OneUnitHeight * 15,
        ),

        // Pupular Text
        Container(
          margin: EdgeInsets.only(
            left: Dimensions.OneUnitWidth * 30,
          ),
          child: Row(
            children: <Widget>[
              const BigText(txt: "Recommended"),
              SizedBox(
                width: Dimensions.OneUnitWidth * 10,
              ),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.OneUnitHeight * 5),
                child: const BigText(
                  txt: ".",
                  clr: Colors.grey,
                ),
              ),
              SizedBox(
                width: Dimensions.OneUnitWidth * 10,
              ),
              Container(
                margin: EdgeInsets.only(top: Dimensions.OneUnitHeight * 5),
                child: const SmallText(
                  txt: "Food Pairing",
                  clr: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        // List of food and images
        GetBuilder<RecommendedProductController>(
          builder: (recommendedProducts){
            return recommendedProducts.isloaded
                ?
              ListView.builder(
              padding: EdgeInsets.only(
                top: Dimensions.OneUnitHeight * 10,
                bottom: Dimensions.OneUnitHeight * 80,
              ),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: recommendedProducts.recommendedProductList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getRecommendedFood(index,"home"));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: Dimensions.OneUnitWidth * 20,
                        vertical: Dimensions.OneUnitHeight * 5
                    ),
                    child: Row(
                      children: <Widget>[
                        // images section
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(Dimensions.OneUnitHeight * 20)),
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                AppConstants.Img_BASE_URL+AppConstants.UPLOAD_URL+recommendedProducts.recommendedProductList[index].img,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          width: Dimensions.OneUnitHeight * 120,
                          height: Dimensions.OneUnitHeight * 120,
                        ),

                        // text section
                        Expanded(
                          child: Container(
                            // width: Dimensions.OneUnitWidth * 230,
                            height: Dimensions.OneUnitHeight * 95,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(Dimensions.OneUnitHeight * 15),
                                bottomRight: Radius.circular(Dimensions.OneUnitHeight * 15),
                              ),
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.only(
                              left: Dimensions.OneUnitWidth * 5,
                              right: Dimensions.OneUnitWidth * 3,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                BigText(txt: recommendedProducts.recommendedProductList[index].name),
                                const SmallText(txt: "with Chinese Characters", clr: Colors.grey,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const <Widget>[
                                    IconWithText(
                                      txt: "Normal",
                                      icn: Icons.circle_sharp,
                                      icnclr: CustomColor.ctmYellowOrange,
                                    ),
                                    IconWithText(
                                      txt: "1.7 km",
                                      icn: Icons.location_pin,
                                      icnclr: CustomColor.ctmMilkGreen,
                                    ),
                                    IconWithText(
                                      txt: "32 mins",
                                      icn: Icons.watch_later_outlined,
                                      icnclr: CustomColor.ctmsoftRed,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              },
            )
                :
              const Center(
                child: CircularProgressIndicator(
                  color: CustomColor.ctmMilkGreen,
                ),
              );
          },
        ),
      ],
    );
  }

  Widget _buildPageItem(int index,ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _curPageValue.floor()) {
      var currScale = 1 - (_curPageValue - index) * (1 - _scaleFactor);
      var curTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else if (index == _curPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_curPageValue - index + 1) * (1 - _scaleFactor);
      var curTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else if (index == _curPageValue.floor() - 1) {
      var currScale = 1 - (_curPageValue - index) * (1 - _scaleFactor);
      var curTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, curTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(1, _height * (1 - _scaleFactor) / 2, 1);
    }
    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: (){
          Get.toNamed(RouteHelper.getPopularFood(index,"home"));
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.OneUnitHeight * 210,
              margin: EdgeInsets.only(
                left: Dimensions.OneUnitWidth * 10,
                right: Dimensions.OneUnitWidth * 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(Dimensions.OneUnitHeight * 30)),
                color: index.isEven ? Colors.cyan.shade200 : Colors.orangeAccent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    AppConstants.Img_BASE_URL+AppConstants.UPLOAD_URL+popularProduct.img!
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.OneUnitHeight * 110,
                margin: EdgeInsets.only(
                  left: Dimensions.OneUnitWidth * 30,
                  right: Dimensions.OneUnitWidth * 30,
                  bottom: Dimensions.OneUnitHeight * 10,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(Dimensions.OneUnitHeight * 20)),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade300,
                      blurRadius: 5,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.OneUnitHeight * 12,
                    right: Dimensions.OneUnitWidth * 15,
                    left: Dimensions.OneUnitWidth * 15,
                    bottom: Dimensions.OneUnitHeight * 12,
                  ),
                  child: AppColumn(txt: popularProduct.name!,),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
