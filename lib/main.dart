import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screen/login.dart';
import 'package:untitled/screen/mainPage.dart';
import 'package:untitled/screen/testLogin.dart';

import 'provider/favorite_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // Replace with actual values
    options: FirebaseOptions(
      apiKey: "AIzaSyCWsCkdAjR7hfHBaqpbetuHETdtNAOj_lM",
      appId: "1:881072041699:android:52d90631b88dde2ead1fd6",
      messagingSenderId: "881072041699",
      projectId: "bitfriend-6914a",
    ),
  );
  runApp(MyApp());
}

// void main(){
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: testLogin()));
  }
}

// import 'dart:js';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// // import 'package:untitled/provider/bookmark_model.dart';
// import 'package:untitled/screen/home.dart';
// // import 'package:untitled/screen/home_page.dart';
// import 'package:untitled/screen/login.dart';
// import 'package:untitled/screen/mainPage.dart';
// import 'package:untitled/screen/market.dart';
// import 'package:untitled/screen/profile.dart';
// import 'package:untitled/screen/sign_up.dart';
// import 'package:untitled/screen/testLogin.dart';
// import 'package:untitled/screen/testRegis.dart';
// import 'package:untitled/services/shared_service.dart';
// import 'package:untitled/utils/edit_profile.dart';
//
// // Widget _defaultHome = const testLogin();
//
//
//
// Future<void> main() async {
//   // void main () => runApp(ChangeNotifierProvider(
//   //   create: (context) => BookmarkBloc(),child: MyApp()));
//
//   // WidgetsFlutterBinding.ensureInitialized();
//   //
//   // bool _result = await SharedService.isLoggedIn();
//   // if(_result){
//   //   _defaultHome = const mainPage();
//   // }
//
//   runApp(const MyApp());
// }
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Flutter Demo',
//
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//
//         ),
//         // routes: {
//         //
//         //   '/':(context) => _defaultHome,
//         //   '/home':(context) => const mainPage(),
//         //   '/login':(context) => const testLogin(),
//         //   '/regis':(context) => const testRegis(),
//         // },
//         home: LoginScreen()
//     );
//   }
// }

//นาฬิกา Realtime
//import 'dart:async';
//import 'package:flutter/material.dart';
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatefulWidget{
//  @override
//  _MyAppState createState() => _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//  String time = "";
//
//  @override
//  void initState() {
//    Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
//      DateTime timenow = DateTime.now();  //get current date and time
//      time = timenow.hour.toString() + ":" + timenow.minute.toString() + ":" + timenow.second.toString();
//      setState(() {
//
//      });
//      //mytimer.cancel() //to terminate this timer
//    });
//    super.initState();
//  }
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//        title: "Test App",
//        home: Scaffold(
//            appBar: AppBar(
//              title:Text("Execute Code With Timer"),
//              backgroundColor: Colors.redAccent,
//            ),
//            body: Container(
//                height: 260,
//                color: Colors.red.shade50,
//
//                child: Center(
//
//                  child: Text(time, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
//                  //show time on UI
//                )
//            )
//        )
//    );
//  }
//}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:untitled/screen/mainPage.dart';
// import 'package:untitled/screen/sign_up.dart';
// import 'package:flutter/src/material/flat_button.dart';
//
//
// void main()  async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     // Replace with actual values
//     options: FirebaseOptions(
//       apiKey: "AIzaSyAf0tfb7A0-LWi8n1jNhxtpsb8bhs5usNA",
//       appId: "1:537254237967:android:2fa4d0c89d5574d277907a",
//       messagingSenderId: "537254237967",
//       projectId: "flutter-login-33887",
//     ),
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//
//     );
//   }
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//
//   Future<FirebaseApp> _initializeFirebase() async {
//     FirebaseApp firebaseApp = await Firebase.initializeApp();
//     return firebaseApp;
//   }
//
// @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       body: FutureBuilder(
//         future: _initializeFirebase(),
//         builder: (context, snapshot){
//           if(snapshot.connectionState == ConnectionState.done) {
//             return LoginScreen();
//           }
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//
//       ),
//     );
//   }
// }
//
//
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   String? message;
//
//   //Loginfuntion
//   static Future<Object?> loginUsingEmailPassword(
//       {required String email, required String password, required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;
//     try {
//       UserCredential userCredential = await auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       user = userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == "user-not-found") {
//         print("No User found for that email");
//          return AlertDialog(
//           title: Text("message"),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Ok'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//
//       }
//     }
//     return user;
//   }
//
// //   @override
// //   Widget build(BuildContext context) {
// //     // TODO: implement build
// //     throw UnimplementedError();
// //   }
// // }
//   void _showAlertDialog(String message) async {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(message),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Ok'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     //create the textfild controller
//     TextEditingController _emailController = TextEditingController();
//     TextEditingController _passwordController = TextEditingController();
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             "MyApp Title",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 28.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const Text(
//             "Login to Your App",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 44.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(
//             height: 44.0,
//           ),
//           TextField(
//             controller: _emailController,
//             keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(
//               hintText: "User Email",
//               prefixIcon: Icon(Icons.mail, color: Colors.black),
//             ),
//           ),
//           const SizedBox(
//             height: 26.0,
//           ),
//           TextField(
//             controller: _passwordController,
//             obscureText: true,
//             //keyboardType: TextInputType.emailAddress,
//             decoration: const InputDecoration(
//               hintText: "User Password",
//               prefixIcon: Icon(Icons.lock, color: Colors.black),
//             ),
//           ),
//           const SizedBox(height: 12.0,
//           ),
//
//           SizedBox(
//             child: RichText(
//               text: TextSpan(
//                 style: const TextStyle(
//                   color: Colors.grey,
//                   fontSize: 15.0,
//                 ),
//                 children: <TextSpan>[
//                   TextSpan(text: "Don't have an account? "),
//                   TextSpan(
//                     text: 'SignUp',
//                     style: TextStyle(
//                       color: Colors.black,
//                       decoration: TextDecoration.underline,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         // Navigator.push(context, testRegis());
//                         // Navigator.pushName(context, '/Register');
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                               const sign_up()),
//                         );
//                       },
//
//                   ),
//                 ],
//               ),
//             ),
//           ),
//
//           const SizedBox(
//             height: 88.0,
//           ),
//           Container(
//             width: double.infinity,
//             child: RawMaterialButton(
//               fillColor: const Color(0xFF0069FE),
//               elevation: 0.0,
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12.0)),
//               onPressed: () async {
//               //let;s test the app
//               User? user = (await loginUsingEmailPassword(
//                   email: _emailController.text,
//                   password: _passwordController.text ,context: context)) as User?;
//               print(user);
//               if (user != null) {
//
//                 Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (context) => mainPage()));
//               }
//               },
//               child: const Text("Login",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: 18.0,
//
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
