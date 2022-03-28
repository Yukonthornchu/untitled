// import 'dart:async';
// import 'package:flutter/material.dart';
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget{
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   String time = "";
//
//   @override
//   void initState() {
//     Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
//       DateTime timenow = DateTime.now();  //get current date and time
//       time = timenow.hour.toString() + ":" + timenow.minute.toString() + ":" + timenow.second.toString();
//       setState(() {
//
//       });
//       //mytimer.cancel() //to terminate this timer
//     });
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "Test App",
//         home: Scaffold(
//             appBar: AppBar(
//               title:Text("Execute Code With Timer"),
//               backgroundColor: Colors.redAccent,
//             ),
//             body: Container(
//                 height: 260,
//                 color: Colors.red.shade50,
//
//                 child: Center(
//
//                   child: Text(time, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
//                   //show time on UI
//                 )
//             )
//         )
//     );
//   }
// }

import 'dart:js';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:untitled/provider/bookmark_model.dart';
import 'package:untitled/screen/home.dart';
// import 'package:untitled/screen/home_page.dart';
import 'package:untitled/screen/login.dart';
import 'package:untitled/screen/mainPage.dart';
import 'package:untitled/screen/market.dart';
import 'package:untitled/screen/testLogin.dart';
import 'package:untitled/screen/testRegis.dart';
import 'package:untitled/services/shared_service.dart';

Widget _defaultHome = const testLogin();



Future<void> main() async {
  // void main () => runApp(ChangeNotifierProvider(
  //   create: (context) => BookmarkBloc(),child: MyApp()));

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
        home: mainPage()
    );
  }
}




