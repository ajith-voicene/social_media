import 'package:dio/dio.dart';

class Constant {
  static String token;
  static String devicename;
  static String provider;
  
  static String name;
  static String photoUrl;
  static String email;
  static final Options options = Options(
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
}
