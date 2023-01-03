import 'address_model.dart';

class UserModel{
  final String id;
  final String name;
  final String email;
  final String phone;
  final int orderCount;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.orderCount,
  });
}