import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class ApiProvider {
  ApiProvider();

  String endPoint = 'localhost:80/login-mem';

  Future<http.Response> doLogin(var Username ,var Password) async {
    String _url = '$endPoint/localhost:80/login-mem';

    var body = {
      "username": Username,
      "password": Password,
    };
    // print('userName: ' +Username);
    // print('userName: ' +Password);
    // try{
    //   var url =Uri.parse('localhost:80/login-mem');
    //
    //   var client =http.Client();
    //   var response = await client.get(url);
    //   print('Response from server'+e.toString());
    // }catch(e){
    //   print("ExceptionKKKKKKKKK" +e.toString());
    // }

    // var a = http.get(Uri.parse('http://localhost:80/login-mem'));
    return  http.get(Uri.parse('localhost:80/Signup-mem'));
    // print(a);
    // return a ;
  }
}

