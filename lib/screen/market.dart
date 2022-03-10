import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class market extends StatefulWidget {
  const market({Key? key}) : super(key: key);

  @override
  _marketState createState() => _marketState();
}

class _marketState extends State<market> {

  List _Data = [];

  // var _newCase = 0;
  // var _total = 0;

  @override
  void initState() {
    super.initState();
    getData().then((value) => print(value));
    getData();
  }

  Future<String> getData() async {

    // var url = Uri.http('https//covid19.ddc.moph.go.th','/api/Cases/today-cases-all');
    // var response = await http.get("https://covid19.ddc.moph.go.th/api/Cases/today-cases-all");
    var url = Uri.https(
        'dapi.binance.com', '/dapi/v1/ticker/24hr');
    // covid19.ddc.moph.go.th , /api/Cases/today-cases-by-provinces

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print(jsonResponse);
      this.setState(() {
        _Data = jsonResponse;
        // _newCase = jsonResponse[0]['new_case'];
        // _total = jsonResponse[0]['total_case'];
        // print(jsonResponse);
        // print("----------------");
        // print(jsonResponse[0]['new_case']);
      });
    }

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
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

//return ข้อมูลแบบหลายชุด หรือ ข้อมูลแบบเป็นList

                return
                  // Padding(
                  // padding: const EdgeInsets.all(2),
                  // child: Column(
                  //   children: [

                      ListTile(
                      // Icon(Icons.star_border_sharp)
                        leading: Icon(Icons.star_border_sharp),
                        title: Text('${_Data[index]['pair']}'),
                        trailing: Text('${_Data[index]['lastPrice']}'),

                          // mainAxisAlignment: MainAxisAlignment.end,
                          // children: [Text('${_Data[index]['lastPrice']}')],
                        // ),
                      );
                //     ],
                //   ),
                // );
                },
            ),
          ),
        ),
      );
}





// ใส่แบ่งเป็นช่องๆในกรอบ
//   padding: const EdgeInsets.all(1),
//   child: Container(
//       height: 65,
//       width: MediaQuery.of(context).size.width,
//       padding: EdgeInsets.all(20),
//       decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(20)),
//       child: Row(
//         children: [
//           Container(
//             child: Wrap(
//               children: [
//                 Container(
//             // child: Align(
//             // alignment: Alignment.centerLeft,
//                   child: Text('${_Data[index]['province']}' , style: TextStyle(fontSize: 16)),
//                 // ),
//                 ),
//
//                 Container(
//                   // child: Align(
//                   //   alignment: Alignment.centerRight,
//                   child: Text('${_Data[index]['new_case']}' , style: TextStyle(fontSize: 16)),
// // ),
// ),
//               ],
//             ),
//           ),
//         ],
//       )
//   ),
//     Text('Update_Data: ${_Data[0]['update_date'] ?? ''}'),
//   ],
// ),
