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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/model/LoginReq_model.dart';
import 'package:untitled/model/LoginResponse_model.dart';
import 'package:untitled/model/RegisReq_model.dart';
import 'package:untitled/model/RegisResponse_model.dart';
import 'package:untitled/model/coin_model.dart';
import 'package:untitled/model/get_time.dart';
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
    return registerResponseJson(
      response.body,
    );
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

  static Future<void> addFavorite(
      {required String uid, required String symbol}) async {
    final data = await FirebaseFirestore.instance
        .collection(Config.favorites)
        .doc(uid)
        .get();

    for (var i = 0; i < data.data()!['symbol']; i++) {
      print(data.data()!['symbol'][i]);
    }
    final result = await FirebaseFirestore.instance
        .collection(Config.favorites)
        .doc(uid)
        .set({
      "symbol": FieldValue.arrayUnion([symbol])
    });
  }

  static Future<CoinListModel?> getMarket() async {
    try {
      var url = Uri.parse('https://api.coincap.io/v2/assets');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        return CoinListModel.fromJson(jsonResponse['data']);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<CoinModel?> getCoin(String id) async {
    try {
      var url = Uri.parse('https://api.coincap.io/v2/assets/${id}');
      print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['data']);
        return CoinModel.fromJson(jsonResponse['data']);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<TimeListModel?> getM1(String id) async {
    try {
      var url = Uri.parse(
          'https://api.coincap.io/v2/assets/${id}/history?interval=m1');
      // print(url);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        // print(jsonResponse['data']);
        return TimeListModel.fromJson(jsonResponse['data']);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
