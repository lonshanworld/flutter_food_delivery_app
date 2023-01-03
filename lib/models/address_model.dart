
class AddressModel{
  late String? contactPersonName;
  late String? contactPersonNumber;
  late String address;
  late double latitude;
  late double longitude;

  AddressModel({
    required this.contactPersonName,
    required this.contactPersonNumber,
    required this.address,
    required this.latitude,
    required this.longitude,
  });

  // String get gtaddress => address;
  // String? get gtcontactPersonName => contactPersonName;
  // String? get gtcontactPersonNumber => contactPersonNumber;
  // String get gtlatitude => latitude.toString();
  // String get gtlongitude => longitude.toString();

}
