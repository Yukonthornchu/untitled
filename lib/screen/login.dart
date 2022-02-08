import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:untitled/model/profile.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  // final TextEditingController _confirmPass = TextEditingController();
  Profile profile = Profile(Email: '', Password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

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
                          validator: MultiValidator([
                            EmailValidator(errorText: "Invalid email format"),
                            RequiredValidator(
                                errorText: "Email is required"),
                            MinLengthValidator(6,
                                errorText:
                                "Email must be at least 6 digits long")
                          ]),
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
                          controller: _pass,
                          obscureText: true,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: "Password is required"),
                            MinLengthValidator(8,
                                errorText:
                                "Password must be at least 8 digits long"),
                            PatternValidator(
                                r'(?=.*?[0-9].*?[#?!@$%^&*-])',
                                errorText:
                                'Password require at least one number and special characters.'),
                          ]),
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
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              formKey.currentState!.reset();
                              print(
                                  "Email = ${profile.Email} Password = ${profile.Password}");
                            }
                          },
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

