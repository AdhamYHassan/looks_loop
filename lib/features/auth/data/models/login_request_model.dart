import 'package:equatable/equatable.dart';

class LoginRequestModel extends Equatable {
  final String phone;
  final String password;
  final String? cartToken;

  const LoginRequestModel({
    required this.phone,
    required this.password,
    this.cartToken,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'phone': phone,
      'password': password,
    };
    if (cartToken != null && cartToken!.trim().isNotEmpty) {
      map['cart_token'] = cartToken!.trim();
    }
    return map;
  }

  @override
  List<Object?> get props => [phone, password, cartToken];
}
