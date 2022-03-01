import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'as convert;

class market extends StatefulWidget {
  const market({Key? key}) : super(key: key);

  @override
  _marketState createState() => _marketState();
}

class _marketState extends State<market> {
  List _Data = [];
  var _newCase = 0;

  Future<String> getData() async{

    var url =
      Uri.http('covid19.ddc.moph.go.th','/api/Cases/today-cases-all');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // print(jsonResponse);
      this.setState(() {
        _Data = jsonResponse;
        _newCase = jsonResponse[0]['new_case'];

      });
    }

    return 'done';
  }

  @override
  void initState() {

    getData();
  }
  Widget build(BuildContext context) =>  Scaffold(
        // appBar: AppBar(
        //   title: Text('Market'),
        //   backgroundColor: Colors.black,
        // ),
        body: Column(
          children: [
            Text('Market ${_newCase}', style: TextStyle(fontSize: 40)),
            // Text('Market ${_Data[0]['total_case'] ?? ''}', style: TextStyle(fontSize: 60)),


          ],
        ),


  );
}
