import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/model/coin_model.dart';
import 'package:untitled/provider/favorite_provider.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/services/base_auth.dart';
import 'package:untitled/config.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel? channel;

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  _favoriteState createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
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
            SizedBox(
              height: 20,
            ),
            Expanded(
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
                                    streamData.containsKey(cyptoAsset['id'])) {
                                  price =
                                      streamData[cyptoAsset['id']].toString();
                                }
                                return favorites.favoritesId
                                            .contains(cyptoAsset['id']) ==
                                        true
                                    ? Card(
                                        child: ListTile(
                                          title: Text(
                                            cyptoAsset['symbol'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
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
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            )
          ],
        ),
      );
    }));
  }
}
