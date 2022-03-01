import 'package:flutter/material.dart';
import 'dart:convert'as convert;
import 'package:http/http.dart' as http;



class market extends StatefulWidget {
  const market({Key? key}) : super(key: key);

  @override
  _marketState createState() => _marketState();
}

class _marketState extends State<market> {
  List _Data = [];
  var _newCase = 0;
  var _total = 0;

  @override
  void initState() {
    super.initState();
    getData().then((value) =>
        print(value)
    );
    getData();
  }

  Future<String> getData() async{

    // var url = Uri.http('https//covid19.ddc.moph.go.th','/api/Cases/today-cases-all');
    // var response = await http.get("https://covid19.ddc.moph.go.th/api/Cases/today-cases-all");
    var url =
    Uri.https('covid19.ddc.moph.go.th','/api/Cases/today-cases-all');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      // print(jsonResponse);
      this.setState(() {
        // _Data = jsonResponse;
        _newCase = jsonResponse[0]['new_case'];
        _total = jsonResponse[0]['total_case'];
        print(jsonResponse);
        print("----------------");
        print(jsonResponse[0]['new_case']);

      });
    }

    return 'done';
  }


  Widget build(BuildContext context) =>  Scaffold(
        // appBar: AppBar(
        //   title: Text('Market'),
        //   backgroundColor: Colors.black,
        // )

        body: Column(
          children: [
            Text('Market ${_newCase}', style: TextStyle(fontSize: 40)),
            Text('Market ${_total}', style: TextStyle(fontSize: 40)),

            // Text('Market ${_Data[0]['total_case'] ?? ''}', style: TextStyle(fontSize: 60)),


          ],

        ),


  );
}
