import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:async';

class market extends StatefulWidget {
  const market({Key? key}) : super(key: key);

  @override
  _marketState createState() => _marketState();
}

class _marketState extends State<market> {

  List _Data = [];
  // var _total = 0;
  int starter = 0;
  Timer? timer;
  // String mydata = '';

  // Timer.periodic(Duration(seconds: 15), (Timer t) => checkForNewSharedLists());
 

  void checkForNewSharedLists() {

    // do request here
    setState(() {
      // change state according to result of request
    });
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) => checkForNewSharedLists());
    super.initState();
    getData().then((value) => print(value));
    getData();

  }
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  Future<String> getData() async {
    // const oneSec = Duration(seconds:1);
    //  Timer.periodic(oneSec, (Timer t) => print('$_Data[lastPrice]'));

    // var url = Uri.http('https//covid19.ddc.moph.go.th','/api/Cases/today-cases-all');
    // var response = await http.get("https://covid19.ddc.moph.go.th/api/Cases/today-cases-all");
    var url = Uri.https('dapi.binance.com', '/dapi/v1/ticker/24hr');
    // covid19.ddc.moph.go.th , /api/Cases/today-cases-by-provinces

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);

        _Data = jsonResponse;

        print(jsonResponse);
      // Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
      //   //code to run on every 5 seconds
      //
      // });

        this.setState(() {

          // _newCase = jsonResponse[0]['new_case'];
          // _total = jsonResponse[0]['total_case'];
          // print(jsonResponse);
          // print("----------------");
          // print(jsonResponse[0]['new_case'])
        });
    }
    // Timer mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
    //   mydata = ('${_Data}').toString();
    //   // print('test');
    //   // print("----------------");

    return 'done';
  }

  Widget build(BuildContext context) => Scaffold(

        // appBar: AppBar(
        //   title: Text('Market'),
        //   backgroundColor: Colors.black,
        // )
        body: NestedScrollView(
          //appBar

          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              backgroundColor: Colors.grey,
              // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text('Market',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                      fontWeight: FontWeight.bold)),
              // pinned: true,
              snap: true,
              centerTitle: true,
              forceElevated: innerBoxIsScrolled,
              floating: true,
            ),
          ],


          body: Padding(

            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(

              itemCount: _Data.length,
              itemBuilder: (context, index) {

                // Timer.periodic(Duration(seconds: 1), (Timer t) => checkForNewSharedLists());

                return

                    ListTile(

                  // Icon(Icons.star_border_sharp)
                  leading: Icon(Icons.star_border_sharp),
                  title: Text('${_Data[index]['pair']}'),
                  trailing: Text('${_Data[index]['lastPrice']}'),

                );
              },
            ),
          ),
        ),
      );
}


