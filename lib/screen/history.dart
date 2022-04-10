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
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/model/coin_model.dart';
import 'package:untitled/provider/favorite_provider.dart';
import 'package:untitled/screen/favorite.dart';
import 'package:untitled/screen/historyPrice.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/services/base_auth.dart';
import 'package:untitled/config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel? channel;

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  _historyState createState() => _historyState();
}

class _historyState extends State<history> {
  BaseAuth? baseAuth;
  List<CoinModel> favoriteList = [];
  CoinListModel? marketData;
  List<dynamic> favoritesId = [];
  Future<List<dynamic>>? _getAssets;
  bool historyM1 = false;
  String symbol = "";

  Future<List<dynamic>> getAssets() async {
    final url = Uri.parse('https://api.coincap.io/v2/assets');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final json = convert.jsonDecode(response.body);
      final List<dynamic> cryptoAssets = json['data'];
      listenToCryptoAssets(cryptoAssets);
      return cryptoAssets;
    } else {
      throw Exception('Failed to load assets');
    }
  }

  void listenToCryptoAssets(List cryptoAssets) {
    channel = WebSocketChannel.connect(
        Uri.parse('wss://ws.coincap.io/prices?assets=ALL'));
  }

  @override
  void initState() {
    baseAuth = Auth();
    _getAssets = getAssets();
  }

  Future<List<dynamic>> getFavorites() async {
    final userData = await baseAuth!.getCurrentUser();
    marketData = await APIServices.getMarket();
    var ds = await FirebaseFirestore.instance
        .collection(Config.favorites)
        .doc(userData!.uid)
        .get();
    if (ds.exists) {
      favoritesId = ds.data()!['symbol'];
    }

    return favoritesId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<FavoriteProvider>(builder: (_, favorites, child) {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xff02051A),
            Color(0xff030933),
            Color(0xff0B2666),
          ],
        )),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Text('ค่าย้อนหลัง 1 ชั่วโมงที่ผ่านมา',
                  style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
            historyM1
                ? Expanded(
                    child: historyPrice(
                    symbol: symbol,
                  ))
                : Expanded(
                    child: FutureBuilder(
                        future: _getAssets,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return StreamBuilder(
                                stream: channel!.stream,
                                builder: (context, streamSnapshot) {
                                  Map? streamData;
                                  if (streamSnapshot.hasData) {
                                    streamData = convert.jsonDecode(
                                        streamSnapshot.data as String) as Map;
                                  }

                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      final dynamic cyptoAsset =
                                          (snapshot.data as List)[index];
                                      String price =
                                          num.tryParse(cyptoAsset['priceUsd'])!
                                              .toStringAsFixed(2);

                                      if (streamData != null &&
                                          streamData
                                              .containsKey(cyptoAsset['id'])) {
                                        price = streamData[cyptoAsset['id']]
                                            .toString();
                                      }
                                      return favorites.favoritesId
                                                  .contains(cyptoAsset['id']) ==
                                              true
                                          ? Card(
                                              child: ListTile(
                                                onTap: () {
                                                  setState(() {
                                                    historyM1 = true;
                                                    symbol = cyptoAsset['id'];
                                                  });
                                                },
                                                title: Text(
                                                  cyptoAsset['symbol'],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                trailing: Text(
                                                  '\$$price',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container();
                                    },
                                    itemCount: (snapshot.data as List).length,
                                  );
                                });
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          } else {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                        }),
                  )
          ],
        ),
      );
    }));
  }
}
