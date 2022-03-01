import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/model/LoginReq_model.dart';
import 'package:untitled/model/LoginResponse_model.dart';
import 'package:untitled/model/RegisResponse_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("login_details");

    return isCacheKeyExist;
  }

  static Future<LoginResponse_model?> loginDetails() async {
    var isCacheKeyExist =
    await APICacheManager().isAPICacheKeyExist("login_details");

    if (isCacheKeyExist) {
      var cacheData = await APICacheManager().getCacheData("login_details");

      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(
      LoginReq_model loginResponse,
      ) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(loginResponse.toJson()),
    );

    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login',
          (route) => false,
    );
  }
}
