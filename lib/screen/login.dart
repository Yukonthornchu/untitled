import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:untitled/model/profile.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/provider/api_provider.dart';
import 'package:untitled/screen/mainPage.dart';
import 'package:untitled/screen/market.dart';
import 'package:untitled/screen/register.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  // final TextEditingController _confirmPass = TextEditingController();
  Profile profile = Profile(Username: '', Password: '', Email: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  ApiProvider apiProvider = ApiProvider();

  Future doLogin() async {
    if (formKey.currentState!.validate()) {
      try {
        var rs = await apiProvider.doLogin(_username.text, _password.text);
        if (rs.statusCode == 200) {
          var jsonRes = json.decode(rs.body);
          print(rs.body);
          if (jsonRes['ok']) {
            String token = jsonRes['token'];
            print(token);
          } else {
            print(jsonRes['Error']);
          }
        } else {
          print('Server Error!');
        }
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //     future: firebase,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         return Scaffold(
    //           appBar: AppBar(
    //             title: Text("Error"),
    //           ),
    //           body: Center(
    //             child: Text("${snapshot.error}"),
    //           ),
    //         );
    //       }
    //       if (snapshot.connectionState == ConnectionState.done) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign-in"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 330,
                        child: TextFormField(
                          controller: _username,
                          //ปิดเช้ค email ไว้ก่อน

                          // validator: MultiValidator([
                          // EmailValidator(errorText: "Invalid email format"),
                          //   RequiredValidator(
                          //       errorText: "Email is required"),
                          //   MinLengthValidator(6,
                          //       errorText:
                          //       "Email must be at least 6 digits long")
                          // ]),
                          onSaved: (Email) {
                            profile.Email = Email!;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 330,
                        child: TextFormField(
                          controller: _password,
                          obscureText: true,
                          //ปิดเช้ค password ไว้ก่อน

                          // validator: MultiValidator([
                          //   RequiredValidator(
                          //       errorText: "Password is required"),
                          //   MinLengthValidator(8,
                          //       errorText:
                          //       "Password must be at least 8 digits long"),
                          //   PatternValidator(
                          //       r'(?=.*?[0-9].*?[#?!@$%^&*-])',
                          //       errorText:
                          //       'Password require at least one number and special characters.'),
                          // ]),
                          onSaved: (Password) {
                            profile.Password = Password!;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        child: ElevatedButton(
                          child: Text("Login"),
                            onPressed: (){
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) => mainPage()),);
                            }
                          // onPressed: () => doLogin(),
                          // {
                          //   if (formKey.currentState!.validate()) {
                          //     formKey.currentState!.save();
                          //     formKey.currentState!.reset();
                          //     print(
                          //         "Email = ${profile.Email} Password = ${profile.Password}");
                          //   }
                          // },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      SizedBox(
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                            ),
                            children: <TextSpan>[
                              TextSpan(text: "Don't have an account? "),
                              TextSpan(
                                text: 'SignUp',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Navigator.push(context, testRegis());
                                    // Navigator.pushName(context, '/Register');
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Register()),
                                    );
                                  },

                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//        return Scaffold(
//          body: Center(
//            child: CircularProgressIndicator(),
//          ),
//        );
//      });
// }
}
