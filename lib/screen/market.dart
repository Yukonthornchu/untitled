import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:untitled/provider/favorite_provider.dart';
import 'package:untitled/services/api_services.dart';
import 'dart:async';

import 'package:untitled/services/base_auth.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel? channel;

class market extends StatefulWidget {
  const market({Key? key}) : super(key: key);

  @override
  _marketState createState() => _marketState();
}

class _marketState extends State<market> {
  //oil
  BaseAuth? baseAuth;
  List<String> favorite = [];
  Future<List<dynamic>>? _getAssets;

  Future<List<dynamic>> getAssets() async {
    final result = await Provider.of<FavoriteProvider>(context, listen: false)
        .getFavoriteList();
    print(result);
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
    _getAssets = getAssets();
    super.initState();
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
        child: FutureBuilder(
            future: _getAssets,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StreamBuilder(
                    stream: channel!.stream,
                    builder: (context, streamSnapshot) {
                      Map? streamData;
                      if (streamSnapshot.hasData) {
                        streamData = convert
                            .jsonDecode(streamSnapshot.data as String) as Map;
                      }

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final dynamic cyptoAsset =
                              (snapshot.data as List)[index];
                          String price = num.tryParse(cyptoAsset['priceUsd'])!
                              .toStringAsFixed(2);

                          if (streamData != null &&
                              streamData.containsKey(cyptoAsset['id'])) {
                            price = streamData[cyptoAsset['id']].toString();
                          }
                          return Card(
                            child: ListTile(
                              leading: favorites.favoritesId
                                          .contains(cyptoAsset['id']) ==
                                      false
                                  ? TextButton(
                                      onPressed: () {
                                        favorites.addFavoriteId(
                                            cyptoAsset['id'].toString());

                                        favorites
                                            .addFavorite(favorites.favoritesId);
                                      },
                                      child: Icon(Icons.star_border_sharp))
                                  : TextButton(
                                      onPressed: () {
                                        favorites.removeFavoriteId(
                                            cyptoAsset['id'].toString());

                                        favorites
                                            .addFavorite(favorites.favoritesId);
                                      },
                                      child: Icon(
                                        Icons.star_border_purple500,
                                        color: Colors.yellow,
                                      ),
                                    ),
                              title: Text(
                                cyptoAsset['name'],
                                style: TextStyle(
                                    // color: Colors.orange.shade800,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(cyptoAsset['symbol']),
                              trailing: Text(
                                '\$$price',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: (snapshot.data as List).length,
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  '${snapshot.error}',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      );
    }));
  }
}
