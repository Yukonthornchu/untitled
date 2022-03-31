import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:untitled/config.dart';
import 'package:untitled/model/LoginReq_model.dart';
import 'package:untitled/screen/testRegis.dart';
import 'package:untitled/services/api_services.dart';

class testLogin extends StatefulWidget {
  const testLogin({Key? key}) : super(key: key);

  @override
  _testLoginState createState() => _testLoginState();
}

class _testLoginState extends State<testLogin> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#191970"),
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: _loginUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
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
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
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
            (onValidate) {
              if (onValidate.isEmtry) {
                return "Username can\'t be Emtry";
              }
              return null;
            },
            (onSavedVal) {
              username = onSavedVal;
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
            (onValidate) {
              if (onValidate.isEmtry) {
                return "Password can\'t be Emtry";
              }
              return null;
            },
            (onSavedVal) {
              password = onSavedVal;
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
            () {
              print('test');
              if(validateAndSave()){
                setState(() {
                  isAPIcallProcess = true;
                });
                LoginReq_model model = LoginReq_model(
                  username: username!,
                  password: password!,
                );
                
                APIServices.login(model).then((response)  {

                  if (response) {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                    (route) => false,
                    );
                  }
                  else{

                    FormHelper.showSimpleAlertDialog(context,
                        Config.appName,
                        'Invalid Username or Password !',
                        'OK',
                            (){
                      Navigator.pop(context);
                    });
              }
                });
              }
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
                              Navigator.pushNamed(context, "/testRegis");
                            },
                        ),
                      ],
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
  bool validateAndSave(){
    final form = globalKey.currentState;
    if (form!.validate()){
      form.save();
      return true;
    }
    else{
      return false;
    }
  }
}
