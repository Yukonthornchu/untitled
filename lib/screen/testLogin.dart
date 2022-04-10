import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:untitled/config.dart';
import 'package:untitled/model/LoginReq_model.dart';
import 'package:untitled/screen/mainPage.dart';
import 'package:untitled/screen/testRegis.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/model/profile.dart';

class testLogin extends StatefulWidget {
  const testLogin({Key? key}) : super(key: key);

  @override
  _testLoginState createState() => _testLoginState();
}

class _testLoginState extends State<testLogin> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#191970"),
        body: ProgressHUD(
          child: _loginUI(context),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white,
                      ]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'BitFriend',
                      style:
                          TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
//รูป
                    // Image.network(
                    //   "http://3.bp.blogspot.com/-y51iuvPNlpQ/TdEjEseB-TI/AAAAAAAAAHY/gzY1sLtwQag/s1600/Abyssinians-01.jpg ",
                    //   width: 100,
                    //   fit: BoxFit.contain,
                    // ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                top: 50,
                bottom: 15,
              ),
              child: Text(
                "Login",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              "username",
              "Username",
              MultiValidator([
                RequiredValidator(errorText: "กรุณาป้อนอีเมลด้วยครับ"),
                EmailValidator(errorText: "รูปแบบอีเมลไม่ถูกต้อง")
              ]),
              (onSavedVal) {
                profile.email = onSavedVal!;
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.5),
              borderRadius: 17,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
            ),
            FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
              RequiredValidator(errorText: "กรุณาป้อนรหัสผ่านด้วยครับ"),
              (onSavedVal) {
                profile.password = onSavedVal;
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.5),
              borderRadius: 17,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      hidePassword = !hidePassword;
                    });
                  },
                  color: Colors.white.withOpacity(0.7),
                  icon: Icon(
                    hidePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility,
                  )),
            ),
            Padding(
                padding: const EdgeInsets.only(right: 25, top: 10),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15.0,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Forget Password ?',
                          style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Forget Password");
                            },
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Center(
                child: FormHelper.submitButton(
              "Login",
              () async {
                if (validateAndSave()) {
                  setState(() => isAPIcallProcess = true);
                  try {
                    final value = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: profile.email, password: profile.password);
                    setState(() => isAPIcallProcess = false);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return mainPage(); // WelcomeScreen
                    }));
                    // formKey.currentState!.reset();
                  } on FirebaseAuthException catch (e) {
                    setState(() => isAPIcallProcess = false);
                    Fluttertoast.showToast(
                        msg: e.message!, gravity: ToastGravity.CENTER);
                  }
                }
                // print('test');
                // if(validateAndSave()){
                //   setState(() {
                //     isAPIcallProcess = true;
                //   });
                //   LoginReq_model model = LoginReq_model(
                //     username: username!,
                //     password: password!,
                //   );
                //
                //   APIServices.login(model).then((response)  {
                //
                //     if (response) {
                //       Navigator.pushNamedAndRemoveUntil(
                //           context,
                //           '/home',
                //       (route) => false,
                //       );
                //     }
                //     else{
                //
                //       FormHelper.showSimpleAlertDialog(context,
                //           Config.appName,
                //           'Invalid Username or Password !',
                //           'OK',
                //               (){
                //         Navigator.pop(context);
                //       });
                // }
                //   });
                // }
              },
              btnColor: HexColor("#FFFF00"),
              borderColor: Colors.white,
              txtColor: Colors.black,
              borderRadius: 25,
            )),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                "OR",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 25, top: 5),
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
                              color: Colors.white,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigator.push(context, testRegis());
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return testRegis(); // WelcomeScreen
                                }));
                              },
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
