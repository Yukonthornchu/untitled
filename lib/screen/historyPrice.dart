import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/coin_model.dart';
import 'package:untitled/model/get_time.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/services/base_auth.dart';
import 'package:untitled/config.dart';

import '../model/market_model.dart';

class historyPrice extends StatefulWidget {
  historyPrice({Key? key, required this.symbol}) : super(key: key);
  String symbol;

  @override
  _historyPriceState createState() => _historyPriceState();
}

class _historyPriceState extends State<historyPrice> {
  BaseAuth? baseAuth;
  List<String> favoriteList = [];
  var today = new DateTime.now();
  final DateFormat formatter = DateFormat('HH:mm');

  @override
  void initState() {
    baseAuth = Auth();
  }

  TimeListModel? coinListM1;

  Future<List<CoinModel>?> getCoin(String symbol) async {
    try {
      final coinList = await APIServices.getCoin();
      final coinData = coinList!.data!
          .where((currentName) => currentName.symbol!.contains(symbol))
          .toList();
      coinListM1 = await APIServices.getM1('${coinData.first.id}');

      return coinData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var fiftyDaysFromNow = today.add(new Duration(hours: -1));
    DateFormat.yMMMEd().format(fiftyDaysFromNow);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Card(
          child: FutureBuilder(
            future: getCoin(widget.symbol),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<CoinModel>?> snapshot,
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
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text('ค่าย้อนหลัง 1 ชั่วโมงที่ผ่านมา'),
                            Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('${snapshot.data![index].symbol}'),
                                        Text(
                                            '${snapshot.data![index].priceUsd}'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text('${fiftyDaysFromNow}'),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    for (var coin in coinListM1!.data!)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                              '${formatter.format(DateTime.parse(coin.date!).toLocal())}'),
                                          Text('${coin.priceUsd}'),
                                        ],
                                      )
                                  ],
                                ))
                          ],
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
      ),
    );
  }
}
