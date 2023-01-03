import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/models/currentLocation_model.dart';
import 'package:food_delivery_app/routes/routeHelpers.dart';
import 'package:food_delivery_app/screens/address/add_address_screen.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import "package:flutter/material.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import "package:latlong2/latlong.dart";

import '../../global_base/custom_address_loader.dart';
import '../../ui/customColor.dart';
import '../../ui/dimensions.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/bigtext.dart';

class FullMap extends StatefulWidget {

  final double lat;
  final double lang;
  final String text;

  const FullMap({
    Key? key,
    required this.lat,
    required this.lang,
    required this.text,
  }) : super(key: key);

  @override
  State<FullMap> createState() => _FullMapState();
}

class _FullMapState extends State<FullMap> {

  TextEditingController inputController = TextEditingController();
  MapController mapController = MapController();

  late LatLng startPosition;
  double _zoom = 15;

  @override
  void initState() {
    super.initState();
    startPosition = LatLng(widget.lat, widget.lang);
    inputController.text = widget.text;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Use `MapController` as needed
      mapController.move(startPosition, _zoom);
    });
  }

  void movemap(LatLng latLng, double zom){
    setState(() {
      mapController.move(latLng, zom);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LocationController>(
        builder: (locationController){
          return Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        onTap: (offset,degree)async{
                          setState(() {
                            startPosition = degree;
                            // print("startPosition $startPosition");
                          });
                          inputController.text = await locationController.getAddressfromGeocode(startPosition);
                        },
                        center: startPosition,
                        zoom: _zoom,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.food_delivery_app',
                        ),
                        MarkerLayer(
                          markers: [
                            Marker(
                              point: startPosition,
                              builder: (context)=>Icon(
                                Icons.location_on,
                                color: Colors.red,
                                size: Dimensions.OneUnitWidth * 45,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                top: Dimensions.OneUnitHeight * 50,
                left: Dimensions.OneUnitWidth * 10,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppIcon(
                      icn: Icons.search,
                      bgClr: CustomColor.primaryBgColor,
                      icnClr: CustomColor.ctmMilkGreen,
                      icnSize: Dimensions.OneUnitWidth * 30,
                      fun: ()async{
                        LatLng degrees = await locationController.getGeocodeFromAddress(inputController.text);
                        setState(()  {
                          startPosition = degrees;
                          _zoom = 15;
                          // print("startposition $startPosition");

                        });
                        movemap(startPosition, _zoom);
                      },
                    ),
                    SizedBox(
                      width: Dimensions.OneUnitWidth * 300,
                      child: AppTextField(
                        txtController: inputController,
                        hinttxt: "Enter your delivery address",
                        icn: Icons.location_on,
                        icnClr: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: Dimensions.OneUnitWidth * 10,
                bottom: Dimensions.OneUnitHeight * 120,
                child: Column(
                  children: [
                    AppIcon(
                      icn: Icons.add,
                      bgClr: CustomColor.ctmMilkGreen,
                      icnClr: CustomColor.primaryBgColor,
                      icnSize: Dimensions.OneUnitWidth * 30,
                      fun: (){
                        setState(() {
                          if(_zoom < 18){
                            _zoom = _zoom + 0.5;
                          }else{
                            _zoom = 18;
                          }

                          movemap(startPosition, _zoom);
                        });
                      },
                    ),
                    SizedBox(height: Dimensions.OneUnitHeight * 10,),
                    AppIcon(
                      icn: Icons.remove,
                      bgClr: CustomColor.ctmMilkGreen,
                      icnClr: CustomColor.primaryBgColor,
                      icnSize: Dimensions.OneUnitWidth * 30,
                      fun: (){
                        setState(() {
                          if(_zoom > 0){
                            _zoom = _zoom - 0.5;
                          }else{
                            _zoom = 0;
                          }
                          movemap(startPosition, _zoom);
                        });
                      },
                    ),
                  ],
                ),
              ),
              Positioned(
                right: Dimensions.OneUnitWidth * 20,
                bottom: Dimensions.OneUnitHeight * 135,
                child: AppIcon(
                  icn: Icons.my_location,
                  bgClr: CustomColor.primaryBgColor,
                  icnClr: CustomColor.ctmMilkGreen,
                  icnSize: Dimensions.OneUnitWidth * 40,
                  padd: Dimensions.OneUnitHeight * 12,
                  fun: ()async{
                    CurrentLocationModel _currentLocation =  await locationController.getUserCurrentLocation();
                    startPosition = _currentLocation.latLng;
                    inputController.text = _currentLocation.address;
                    _zoom = 15;
                    // setState(() {
                    //
                    //
                    // });
                    movemap(startPosition, _zoom);
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.maxFinite,
                  height: Dimensions.OneUnitHeight * 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.OneUnitHeight * 20),
                      topRight: Radius.circular(Dimensions.OneUnitHeight * 20),
                    ),
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          Get.back();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColor.primaryBgColor),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: Dimensions.OneUnitHeight * 10,
                            horizontal: Dimensions.OneUnitWidth * 25,
                          )),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 10)),
                          )),
                        ),
                        child: const BigText(txt: "Cancel",clr: CustomColor.ctmMilkGreen,),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          // Get.to(() => AddAddressScreen(
                          //   addressText: inputController.text,
                          //   lati: startPosition.latitude,
                          //   longi: startPosition.longitude,
                          // ));
                          // Get.toNamed(RouteHelper.getAddressPage(inputController.text, startPosition.latitude, startPosition.longitude));
                          Get.toNamed(RouteHelper.getAddressPage(inputController.text, startPosition.latitude, startPosition.longitude));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(CustomColor.ctmMilkGreen),
                          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                            vertical: Dimensions.OneUnitHeight * 10,
                            horizontal: Dimensions.OneUnitWidth * 25,
                          )),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.OneUnitHeight * 10)),
                          )),
                        ),
                        child: const BigText(txt: "Save",clr: CustomColor.primaryBgColor,),
                      ),
                    ],
                  ),
                ),
              ),
              if(locationController.loading) const Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: CustomAddressLoader(),
              ),
            ],
          );
        },
      ),
    );
  }
}
