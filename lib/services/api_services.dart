// import 'dart:convert';
//
// import 'package:untitled/model/LoginReq_model.dart';
// import 'package:untitled/model/LoginResponse_model.dart';
// import 'package:untitled/model/RegisReq_model.dart';
// import 'package:untitled/model/RegisResponse_model.dart';
// import 'package:http/http.dart' as http;
//
// import '../../config.dart';
// import 'shared_service.dart';
//
// class APIService {
//   static var client = http.Client();
//
//   static Future<bool> login(
//       LoginReq_model model,
//       ) async {
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//     };
//
//     var url = Uri.http(
//       Config.apiURL,
//       Config.loginAPI,
//     );
//
//     var response = await client.post(
//       url,
//       headers: requestHeaders,
//       body: jsonEncode(model.toJson()),
//     );
// return true;}
//   //   if (response.statusCode == 200) async {
//   //     await SharedService.setLoginDetails(loginResponseJson(response.body,),);
//   //
//   //     return true;
//   //   } else {
//   //     return false;
//   //   }
//   // }
//
//   static Future<RegisResponse_model> register(
//       RegisReq_model model,
//       ) async {
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//     };
//
//     var url = Uri.http(
//       Config.apiURL,
//       Config.registerAPI,
//     );
//
//     var response = await client.post(
//       url,
//       headers: requestHeaders,
//       body: jsonEncode(model.toJson()),
//     );
//
//     return registerResponseJson(
//       response.body,
//     );
//   }
//
//   static Future<String> getUserProfile() async {
//     var loginDetails = await SharedService.loginDetails();
//
//     Map<String, String> requestHeaders = {
//       'Content-Type': 'application/json',
//       'Authorization': 'Basic ${loginDetails!.data.token}'
//     };
//
//     var url = Uri.http(Config.apiURL, Config.userProfileAPI);
//
//     var response = await client.get(
//       url,
//       headers: requestHeaders,
//     );
//
//     if (response.statusCode == 200) {
//       return response.body;
//     } else {
//       return "";
//     }
//   }
//
// }





import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:untitled/model/LoginReq_model.dart';
import 'package:untitled/model/LoginResponse_model.dart';
import 'package:untitled/model/RegisReq_model.dart';
import 'package:untitled/model/RegisResponse_model.dart';
import 'shared_service.dart';

import '../config.dart';

class APIServices {
  static var client = http.Client();

  static Future<bool> login(LoginReq_model model) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.loginAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      //SHARED
      print(response.body);
      // await SharedService.setLoginDetails(loginResponseJson(response.body));

      return true;
    } else {
      return false;
    }
  }

  static Future<RegisResponse_model> register(
      RegisReq_model model,
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(Config.apiURL, Config.registerAPI);

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return registerResponseJson(response.body,);
  }
  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data.token}'
    };

    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "";
    }
  }
}
