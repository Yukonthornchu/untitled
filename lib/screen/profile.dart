import 'package:flutter/material.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/utils/user_preferences.dart';
import 'package:untitled/widget/button_widget.dart';
import 'package:untitled/widget/profile_widget.dart';

class profile extends StatefulWidget {
  const profile({Key? key}) : super(key: key);

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {

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
            onClick: () async {  },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),

        ],
      ),
    );
  }

 Widget buildName(User user) => Column(
   children: [
     Text(
       user.name,
       style: TextStyle(fontWeight: FontWeight.bold, fontSize:20),
     )

   ],
 );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To Pro',
    onClicked:(){},
  );
}
