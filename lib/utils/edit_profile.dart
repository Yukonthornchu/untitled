import 'package:flutter/material.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/utils/user_preferences.dart';
import 'package:untitled/widget/appbar_widget.dart';
import 'package:untitled/widget/profile_widget.dart';
import 'package:untitled/widget/textfield_widget.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar : buildAppBar(context),
    body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 32),
      physics: BouncingScrollPhysics(),
      children: [
        ProfileWidget(
          imagePath: user.imagePath,
          isEdit: true ,
          onClick: () async {  },
        ),

        const SizedBox(height: 24),
        TextFieldWidget(
          label:'User Name',
          text: user.name,
          onChanged: (name){},
        ),

    // ElevatedButton(
    //     child: Text("Login"),
    //     onPressed: (){
    //       Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => mainPage()),);
    //     }
    //     ),

      ],
    ),
  );


}
