import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screen/login.dart';
import 'package:untitled/screen/register.dart';
import 'package:firebase_core_web/firebase_core_web.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BitFriend",style: TextStyle(fontSize: 25)) ,
      ),
      body: Padding(

        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Container(
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 70 ,
                    child: Image.network("https://cdn.pixabay.com/photo/2021/03/14/11/14/fish-6093991_960_720.jpg"),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    child:
                  ElevatedButton.icon(
                    icon: Icon(Icons.login),
                    label: Text("Sign-In",style: TextStyle(fontSize: 16)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return Login();

                          })
                      );
                    },
                   ),
                  ),
                  SizedBox(height: 15,),
                  SizedBox(
                    child:
                    ElevatedButton.icon(
                      icon: Icon(Icons.add),
                      label: Text("Sign-Up",style: TextStyle(fontSize: 16)),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context){
                          return Register();

                        })
                        );
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
}
