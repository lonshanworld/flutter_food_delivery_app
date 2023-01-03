import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/user_controller.dart';
import 'package:food_delivery_app/global_base/custom_address_loader.dart';

import 'package:food_delivery_app/routes/routeHelpers.dart';

import 'package:food_delivery_app/ui/customColor.dart';
import 'package:food_delivery_app/ui/dimensions.dart';
import 'package:food_delivery_app/widgets/app_text_field.dart';
import 'package:food_delivery_app/widgets/bigtext.dart';
import "package:flutter/material.dart";

import "package:get/get.dart";
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as ll2 ;

class AddAddressScreen extends StatefulWidget {

  final String? addressText;
  final double? lati;
  final double? longi;

  const AddAddressScreen({
    Key? key,
    this.addressText,
    this.lati,
    this.longi,
  }) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonPhone = TextEditingController();
  late bool _isLogged;
  MapController mapController = MapController();
  // late CameraPosition _cameraPosition = const CameraPosition(
  //   target: LatLng(45.51563, -122.677433),
  //   zoom: 17,
  // );

  // ll2.LatLng _cameraPosition = ll2.LatLng(16.8409, 96.1735);
  final double _zoom = 15;

  ll2.LatLng _initialPosition = ll2.LatLng(16.8409, 96.1735); // yangon.
  // late ll2.LatLng _initialPosition = ll2.LatLng( 36.778259, -119.417931); // california


  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   // Use `MapController` as needed
    // });

    if(widget.addressText !=null && widget.lati !=0 && widget.longi !=0){
      _addressController.text = widget.addressText!;
      _initialPosition = ll2.LatLng(widget.lati!, widget.longi!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        // Use `MapController` as needed
        mapController.move(_initialPosition, _zoom);
      });
    }else{
      if(Get.find<LocationController>().deliAddressList.isEmpty){
        Get.find<LocationController>().getDelilocation();
      }
    }

    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel == null){
      Get.find<UserController>().getUserInfo();
    }
    //





  }

  void movemap(ll2.LatLng latLng, double zom){
    mapController.move(latLng, zom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text("Address"),
        backgroundColor: CustomColor.ctmMilkGreen,
      ),
      backgroundColor: CustomColor.primaryBgColor,
      body: SingleChildScrollView(
        child: GetBuilder<UserController>(
          builder: (userController){
            if(userController.userModel != null && _contactPersonName.text.isEmpty){
              _contactPersonName.text = userController.userModel!.name;
              _contactPersonPhone.text = userController.userModel!.phone;
            }
            return GetBuilder<LocationController>(
              builder: (locationController){
                if(locationController.deliAddressList.isNotEmpty && _addressController.text.isEmpty){
                  _addressController.text = locationController.deliAddressList[0].address;
                  _initialPosition = ll2.LatLng(
                    locationController.deliAddressList[0].latitude,
                    locationController.deliAddressList[0].longitude,
                  );
                  movemap(_initialPosition, _zoom);
                }
                return Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: Dimensions.OneUnitHeight * 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.all(
                            //   Radius.circular(Dimensions.OneUnitHeight * 5),
                            // ),
                            border: Border.all(
                              width: 2,color: CustomColor.ctmMilkGreen,
                            ),
                          ),
                          child: Stack(
                            children: [
                              FlutterMap(
                                // mapController: locationController.setMapController(mapController),
                                mapController: mapController,
                                options: MapOptions(
                                  onTap: (offset,degree)async{
                                    setState(() {
                                      _initialPosition = degree;

                                      // print("position $_initialPosition");

                                    });
                                    _addressController.text = await locationController.getAddressfromGeocode(_initialPosition);
                                    movemap(_initialPosition, _zoom);
                                    print("text ${_addressController.text}");
                                  },
                                  onLongPress: (offset,degree){
                                    Get.toNamed(RouteHelper.getfullMap(_initialPosition.latitude, _initialPosition.longitude,_addressController.text));
                                  },
                                  center : _initialPosition,
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
                                        point: _initialPosition,
                                        builder: (context)=>Icon(
                                          Icons.location_on,
                                          color: Colors.red,
                                          size: Dimensions.OneUnitWidth * 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.OneUnitHeight * 30,),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            left: Dimensions.OneUnitWidth * 30,
                          ),
                          child: const BigText(txt: "Delivery Address",clr: Colors.black54,),
                        ),
                        SizedBox(height: Dimensions.OneUnitHeight * 10,),
                        AppTextField(
                          txtController: _addressController,
                          hinttxt: "Enter your delivery address",
                          icn: Icons.map,
                          icnClr: CustomColor.ctmMilkGreen,
                        ),
                        SizedBox(height: Dimensions.OneUnitHeight * 20,),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            left: Dimensions.OneUnitWidth * 30,
                          ),
                          child: const BigText(txt: "Contact Name",clr: Colors.black54,),
                        ),
                        SizedBox(height: Dimensions.OneUnitHeight * 10,),
                        AppTextField(
                          txtController: _contactPersonName,
                          hinttxt: "Enter your name",
                          icn: Icons.person,
                          icnClr: CustomColor.ctmMilkGreen,
                        ),
                        SizedBox(height: Dimensions.OneUnitHeight * 20,),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(
                            left: Dimensions.OneUnitWidth * 30,
                          ),
                          child: const BigText(txt: "Contact Phone Number",clr: Colors.black54,),
                        ),
                        SizedBox(height: Dimensions.OneUnitHeight * 10,),
                        AppTextField(
                          txtController: _contactPersonPhone,
                          hinttxt: "Enter your phone number",
                          icn: Icons.phone,
                          icnClr: CustomColor.ctmMilkGreen,
                        ),
                        SizedBox(height: Dimensions.OneUnitHeight * 20,),
                        ElevatedButton(
                          onPressed: ()async{
                            ll2.LatLng locate = await locationController.getGeocodeFromAddress(_addressController.text);
                            movemap(locate, _zoom);
                            locationController.saveLocationAndInfo(
                              address: _addressController.text,
                              name: _contactPersonName.text,
                              phone: _contactPersonPhone.text,
                              latLng: locate,
                            );
                            Get.toNamed(RouteHelper.getPaymentPage());
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
                          child: const BigText(txt: "Save",clr: CustomColor.primaryBgColor,),
                        ),
                      ],
                    ),
                    if(locationController.loading)const Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: CustomAddressLoader(),
                    ),
                  ],
                );

              },
            );
          },
        ),
      ),
    );
  }
}
