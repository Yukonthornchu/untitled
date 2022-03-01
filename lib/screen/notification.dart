import 'package:flutter/material.dart';
import 'dart:convert'as convert;
import 'package:http/http.dart' as http;

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  // @override
  // void initState(){
  //   super.initState();
  //   getData().then((value) =>
  //   print(value)
  //   );
  // }
  //
  // Future<String> getData() async{
  //   var response = await http.get("https://covid19.ddc.moph.go.th/api/Cases/today-cases-all");
  //   if(response.statusCode == 200) {
  //     var jsonResponse = convert.jsonDecode(response.body);
  //     this.setState(() {
  //       print(jsonResponse);
  //       print('---------');
  //       print(jsonResponse[0]['new_case']);
  //     });
  //   }
  //   return 'done';
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Notification'),
      //   backgroundColor: Colors.black,
      // ),
      body: Center(
        child: Text(
          'Notification',
          style: TextStyle(fontSize: 60),
        ),
      ),
    );
  }
}
