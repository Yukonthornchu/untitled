//
// import 'package:favorite_button/favorite_button.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';
//
// class history extends StatefulWidget {
//   const history({Key? key}) : super(key: key);
//
//
//
//   @override
//   _historyState createState() => _historyState();
//
//
//
// }
//
// class _historyState extends State<history> {
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Timer interval(Duration duration, func) {
//       Timer function() {
//         Timer timer = new Timer(duration, function);
//
//         func(timer);
//
//         return timer;
//       }
//
//       return new Timer(duration, function);
//     }
//
//     void main() {
//       int i = 0;
//
//       interval(new Duration(seconds: 1), (timer) {
//         print(i++);
//
//         if (i > 5) timer.cancel();
//       });
//     }
//
//     return Scaffold(
//
//       // appBar: AppBar(
//       //   title: Text('History'),
//       //   backgroundColor: Colors.black,
//       // ),
//
//       body: Row(
//         children: [
//           Column(
//             children: [
//               Center(
//                 child: Text(
//                   'History',
//                   style: TextStyle(fontSize: 60),
//
//                 ),
//
//               ),
//
//
//
//               // IconButton(
//               //   icon: Icon(Icons.bluetooth),
//               //   iconSize: 48,
//               //   tooltip: 'Toggle Bluetooth',
//               //   onPressed: () {
//               //     setState(() {
//               //       _isBluetoothOn = !_isBluetoothOn;
//               //     });
//               //   },
//               // ),
//               // FavoriteButton(
//               //
//               //   isFavorite: false,
//               //   valueChanged: (_isFavorite) {
//               //     print('Is Favorite : $_isFavorite');
//               //   },
//               // ),
//
//
//
//
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// เก็บไว้เผื่อใช้
// TextButton.icon(
// onPressed: () {print("kong");},
// icon: Icon(Icons.email),
// label: Text("Contact me"),
// style: ElevatedButton.styleFrom(
// textStyle: TextStyle(fontSize: 15),
// ),
// ),
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screen/historyPrice.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/services/base_auth.dart';
import 'package:untitled/config.dart';

import '../model/market_model.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  BaseAuth? baseAuth;
  List<String> favoriteList = [];
  @override
  void initState() {
    baseAuth = Auth();
    getFavorites();
  }

  Future<List<MarketModel>?> getFavorites() async {
    List<MarketModel> favoriteList = [];
    final userData = await baseAuth!.getCurrentUser();
    final marketData = await APIServices.getMarket();
    var favorite = await FirebaseFirestore.instance
        .collection(Config.favorites)
        .doc(userData!.uid)
        .get();
    for (var i = 0; i < favorite.data()!['symbol']!.length; i++) {
      favoriteList.add(marketData!.data!
          .where((currentName) =>
              currentName.symbol!.contains(favorite.data()!['symbol'][i]))
          .single);
    }
    return favoriteList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [],
        body: FutureBuilder(
          future: getFavorites(),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<MarketModel>?> snapshot,
          ) {
            print(snapshot.connectionState);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Text('Error');
              } else if (snapshot.hasData) {
                return ListView.builder(
                    key: UniqueKey(),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => historyPrice(
                                        symbol: snapshot.data![index].symbol!
                                            .split('USD')
                                            .first
                                            .toString(),
                                      )));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              // Icon(Icons.star_border_sharp)
                              // leading: Icon(Icons.star_border_sharp),
                              title: Text('${snapshot.data![index].pair}'),
                              trailing:
                                  Text('${snapshot.data![index].lastPrice}'),
                              // subtitle: Text,
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Text('Empty data');
              }
            } else {
              return Text('State: ${snapshot.connectionState}');
            }
          },
        ),
      ),
    );
  }
}
