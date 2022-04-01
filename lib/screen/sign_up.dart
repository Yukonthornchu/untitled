// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:untitled/model/profile.dart';
// import 'package:untitled/screen/login.dart';
// import 'package:untitled/screen/sign_up.dart';
// import 'package:firebase_core_web/firebase_core_web.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'dart:html';
//
// void main()  async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     // Replace with actual values
//     options:
//     FirebaseOptions(
//       apiKey: "AIzaSyCWsCkdAjR7hfHBaqpbetuHETdtNAOj_lM",
//       appId: "1:881072041699:android:52d90631b88dde2ead1fd6",
//       messagingSenderId: "881072041699",
//       projectId: "bitfriend-6914a",
//     ),
//   );
//  runApp(sign_up());
//  }
//
// class sign_up extends StatefulWidget {
//   const sign_up({Key? key}) : super(key: key);
//
//   @override
//   _sign_upState createState() => _sign_upState();
// }
//
// class _sign_upState extends State<sign_up> {
//   final formKey = GlobalKey<FormState>();
//   final TextEditingController _pass = TextEditingController();
//   final TextEditingController _confirmPass = TextEditingController();
//   Profile profile = Profile(email: '', password: '');
//   final Future<FirebaseApp> firebase = Firebase.initializeApp();
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: firebase,
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text("Error"),
//               ),
//               body: Center(
//                 child: Text("${snapshot.error}"),
//               ),
//             );
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text("Sign-Up"),
//               ),
//               body: Container(
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Form(
//                     key: formKey,
//                     child: SingleChildScrollView(
//                       child: Center(
//                         child: Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 50,
//                               ),
//                               Text(
//                                 "Email",
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               SizedBox(
//                                 width: 330,
//                                 child: TextFormField(
//                                   // validator: MultiValidator([
//                                   //   EmailValidator(errorText: "Invalid email format"),
//                                   //   RequiredValidator(
//                                   //       errorText: "Email is required"),
//                                   //   MinLengthValidator(6,
//                                   //       errorText:
//                                   //           "Email must be at least 6 digits long")
//                                   // ]),
//                                   onSaved: (email) {
//                                     profile.email = email!;
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               Text(
//                                 "Password",
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               SizedBox(
//                                 width: 330,
//                                 child: TextFormField(
//                                   controller: _pass,
//                                   obscureText: true,
//                                   //   validator: MultiValidator([
//                                   //   RequiredValidator(
//                                   //       errorText: "Password is required"),
//                                   //   MinLengthValidator(8,
//                                   //       errorText:
//                                   //       "Password must be at least 8 digits long"),
//                                   //   PatternValidator(
//                                   //       r'(?=.*?[0-9].*?[#?!@$%^&*-])',
//                                   //       errorText:
//                                   //       'Password require at least one number and special characters.'),
//                                   // ]),
//                                   onSaved: (password) {
//                                     profile.password = password!;
//                                   },
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               Text(
//                                 "Confirm Password",
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                               // SizedBox(
//                               //   width: 330,
//                               //   child: TextFormField(
//                               //     controller: _confirmPass,
//                               //     obscureText: true,
//                               //     validator: (val) {
//                               //       if (val!.isEmpty) {
//                               //         return 'Please verify your password';
//                               //       }
//                               //       if (val != _pass.text)
//                               //         return 'Password does Not Match';
//                               //       return null;
//                               //     },
//                               //
//                               //
//                               //     onSaved: (Password) {
//                               //       profile.Password = Password!;
//                               //     },
//                               //   ),
//                               // ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                               SizedBox(
//                                 child: ElevatedButton(
//                                   child: Text("ลงทะเบียน"),
//                                   onPressed: () {
//                                     if (formKey.currentState!.validate()) {
//                                       formKey.currentState!.save();
//                                       formKey.currentState!.reset();
//                                       print(
//                                           "Email = ${profile.email} Password = ${profile.password}");
//                                     }
//                                   },
//                                 ),
//                               ),
//
//                               SizedBox(
//                                 width: double.infinity,
//                                 child: ElevatedButton(
//                                   child: Text("ลงทะเบียน",
//                                       style: TextStyle(fontSize: 20)),
//                                   onPressed: () async {
//                                     if (formKey.currentState!.validate()) {
//                                       formKey.currentState!.save();
//                                       try {
//                                         await FirebaseAuth.instance
//                                             .createUserWithEmailAndPassword(
//                                                 email: profile.email,
//                                                 password: profile.password)
//                                             .then((value) {
//                                           formKey.currentState!.reset();
//                                           Fluttertoast.showToast(
//                                               msg:
//                                                   "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
//                                               gravity: ToastGravity.TOP);
//                                           Navigator.pushReplacement(context,
//                                               MaterialPageRoute(
//                                                   builder: (context) {
//                                             return LoginScreen();
//                                           }));
//                                         });
//                                       } on FirebaseAuthException catch (e) {
//                                         print(e.code);
//                                         String? message;
//                                         if (e.code == 'email-already-in-use') {
//                                           message =
//                                               "มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน";
//                                         }
//                                         // else if(e.code == 'weak-password'){
//                                         //   message = "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
//                                         //}
//                                         else {
//                                           message = e.message;
//                                         }
//                                         Fluttertoast.showToast(
//                                             msg: 'message',
//                                             gravity: ToastGravity.CENTER);
//                                       }
//                                     }
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           }
//
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         });
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:untitled/model/profile.dart';
import 'package:untitled/screen/login.dart';


import 'home.dart';

class sign_up extends StatefulWidget {
  @override
  _sign_upState createState() => _sign_upState();
}

class _sign_upState extends State<sign_up> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(password: '', email: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(
                title: Text("สร้างบัญชีผู้ใช้"),
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("อีเมล", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                              EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? email) {
                              profile.email = email!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text("รหัสผ่าน", style: TextStyle(fontSize: 20)),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
                            obscureText: true,
                            onSaved: (String? password) {
                              profile.password = password!;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("ลงทะเบียน",
                                  style: TextStyle(fontSize: 20)),
                              onPressed: () async {
                                print("Test");
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  print(
                                      "email = ${profile.email} password = ${profile.password}");
                                  try {
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password)
                                        .then((value) {
                                      formKey.currentState!.reset();
                                      Fluttertoast.showToast(
                                          msg: "สร้างบัญชีผู้ใช้เรียบร้อยแล้ว",
                                          gravity: ToastGravity.TOP);
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context) {
                                            return LoginScreen();
                                          }));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    print(e.code);
                                    String message;
                                    if (e.code == 'email-already-in-use') {
                                      message =
                                      "มีอีเมลนี้ในระบบแล้วครับ โปรดใช้อีเมลอื่นแทน";
                                    } else if (e.code == 'weak-password') {
                                      message =
                                      "รหัสผ่านต้องมีความยาว 6 ตัวอักษรขึ้นไป";
                                    } else {
                                      message = e.message!;
                                    }
                                    Fluttertoast.showToast(
                                        msg: message,
                                        gravity: ToastGravity.CENTER);
                                  }
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}