import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:untitled/model/RegisReq_model.dart';
import 'package:untitled/services/api_services.dart';

import '../config.dart';


class testRegis extends StatefulWidget {
  const testRegis({Key? key}) : super(key: key);

  @override
  _testRegisState createState() => _testRegisState();
}

class _testRegisState extends State<testRegis> {
  bool isAPIcallProcess = false;
  bool hidePassword = true;
  bool hidePassword2 = true;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? username;
  String? password;
  String? email;
  String? con_password;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor("#191970"),
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: _regisUI(context),
          ),
          inAsyncCall: isAPIcallProcess,
          opacity: 0.3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _regisUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 10,
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
                //รูป
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      "Register",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ) ,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              top: 50,
              bottom: 15,
            ),
            // child: Text(
            //   "Register",
            //   style: TextStyle(
            //     // fontWeight: FontWeight.bold,
            //     fontSize: 20,
            //     color: Colors.white,
            //   ),
            // ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "email",
            "Email",
                (onValidate) {
              if (onValidate.isEmtry) {
                return "Email can\'t be Emtry";
              }
              return null;
            },
                (onSavedVal) {
              email = onSavedVal;
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
            padding: const EdgeInsets.only(
              top: 10,
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "con_password",
            "Confirm Password",
                (onValidate) {
              if (onValidate.isEmtry) {
                return "Confirm Password can\'t be Emtry";
              }
              return null;
            },
                (onSavedVal) {
              con_password = onSavedVal;
            },
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.5),
            borderRadius: 17,
            obscureText: hidePassword2,
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidePassword2 = !hidePassword2;
                  });
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                  hidePassword2
                      ? Icons.visibility_off_outlined
                      : Icons.visibility,
                )),
          ),

          //
          SizedBox(
            height: 20,
          ),
          Center(
              child: FormHelper.submitButton(
                "Register",
                    () {
                      if(validateAndSave()){
                        setState(() {
                          isAPIcallProcess = true;
                        });
                        RegisReq_model model = RegisReq_model(
                          username: username!,
                          password: password!,
                          email: email!,
                        );

                        APIServices.register(model).then((response)  {
                          if (response.data != null) {
                            FormHelper.showSimpleAlertDialog(context,
                                Config.appName,
                                'Registation Successfull !',
                                'OK',
                                    (){
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/login',
                                            (route) => false,
                                      );
                                });

                          }
                          else{
                            FormHelper.showSimpleAlertDialog(context,
                                Config.appName,
                                response.message,
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
              )
          ),
          SizedBox(
            height: 20,
          ),
          //
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

