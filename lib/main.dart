

import 'package:flutter/material.dart';
import 'package:untitled/screen/home.dart';
import 'package:untitled/screen/login.dart';
import 'package:untitled/screen/mainPage.dart';
import 'package:untitled/screen/market.dart';
import 'package:untitled/screen/testLogin.dart';
import 'package:untitled/screen/testRegis.dart';
import 'package:untitled/services/shared_service.dart';

Widget _defaultHome = const testLogin();

Future<void> main() async {

  // WidgetsFlutterBinding.ensureInitialized();
  //
  // bool _result = await SharedService.isLoggedIn();
  // if(_result){
  //   _defaultHome = const mainPage();
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',

        theme: ThemeData(
          primarySwatch: Colors.blue,

        ),
        // routes: {
        //
        //   '/':(context) => _defaultHome,
        //   '/home':(context) => const mainPage(),
        //   '/login':(context) => const testLogin(),
        //   '/regis':(context) => const testRegis(),
        // },
        home:mainPage()
    );
  }
}




