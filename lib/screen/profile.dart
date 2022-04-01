import 'package:firebase/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/screen/login.dart';
import 'package:untitled/utils/edit_profile.dart';
import 'package:untitled/utils/user_preferences.dart';
import 'package:untitled/widget/profile_widget.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = UserPreferences.myUser;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      // ),

      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 80,
          ),

          ProfileWidget(
            imagePath: user.imagePath,
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfile()),
              );
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          // const SizedBox(height: 24),
          // Center(child: buildUpgradeButton()),
        ],
      ),
    );
  }

  Widget buildName(user) => Column(
        children: [

          SizedBox(height: 45),
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          SizedBox(height: 25),
          // Text(
          //   user.email,
          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          // ),
          Text(
            auth().currentUser!.email,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),

          SizedBox(height: 25),

          ElevatedButton(
            child: Text("ออกจากระบบ"),
            onPressed: () {
              auth().signOut().then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }));
              });
            },
          )
        ],

      );

  // Widget buildUpgradeButton() => ButtonWidget(
  //   text: 'Upgrade To Pro',
  //   onClicked:(){},
  // );
}


