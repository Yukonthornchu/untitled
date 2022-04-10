import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/model/coin_model.dart';
import 'package:untitled/model/get_time.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/services/base_auth.dart';

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
  final DateFormat fIndex = DateFormat('dd/mm/yyyy HH:mm');
  Future<List<TimeModel>>? _loadM1;
  TimeListModel? coinListM1;
  String? height = '0.0';
  String? low = '0.0';

  @override
  void initState() {
    baseAuth = Auth();
    _loadM1 = setBetweenData(widget.symbol);
  }

  Future<CoinModel?> getCoin(String symbol) async {
    try {
      final coin = await APIServices.getCoin(symbol);
      return coin;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<TimeModel>> setBetweenData(String symbol) async {
    var betweenHour = <TimeModel>[];
    var betweenHourSort = <TimeModel>[];
    coinListM1 = await APIServices.getM1(symbol);
    var oneHourAgo = today.add(new Duration(hours: -1));
    var twoHourAgo = oneHourAgo.add(new Duration(hours: -1));
    final DateFormat formatter = DateFormat('HH:mm');
    for (var i = 0; i < coinListM1!.data!.length; i += 1) {
      var date = DateTime.parse(coinListM1!.data![i].date!);
      if (date.compareTo(twoHourAgo) >= 0 && date.compareTo(oneHourAgo) <= 0) {
        betweenHour.add(coinListM1!.data![i]);
        betweenHourSort.add(coinListM1!.data![i]);
      }
    }
    betweenHour.sort((a, b) => formatter
        .format(DateTime.parse(b.date!))
        .compareTo(formatter.format(DateTime.parse(a.date!))));
    betweenHourSort.sort((a, b) =>
        double.parse(b.priceUsd!).compareTo(double.parse(a.priceUsd!)));
    height = betweenHourSort.first.priceUsd.toString();
    low = betweenHourSort.last.priceUsd.toString();
    setState(() {});
    return betweenHour;
  }

  List<Widget> data = [];
  @override
  Widget build(BuildContext context) {
    var fiftyDaysFromNow = fIndex.format(today.add(new Duration(hours: -1)));
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          // padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: FutureBuilder(
            future: getCoin(widget.symbol),
            builder: (
              BuildContext context,
              AsyncSnapshot<CoinModel?> snapshot,
            ) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  String price = num.tryParse(snapshot.data!.priceUsd!)!
                      .toStringAsFixed(2);

                  return Card(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${snapshot.data!.symbol}',
                                style: TextStyle(fontSize: 20),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '\$$price',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    '1Hour สูงสุด: ${num.tryParse(height!)!.toStringAsFixed(2)}',
                                  ),
                                  Text(
                                    '1Hour ต่ำสุุด:  ${num.tryParse(low!)!.toStringAsFixed(2)}',
                                  ),
                                ],
                              )
                            ],
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          new Divider(color: Colors.grey),
                          Text('${fiftyDaysFromNow}'),

                          FutureBuilder(
                            future: _loadM1,
                            builder: (
                              BuildContext context,
                              AsyncSnapshot<List<TimeModel>?> snapshot,
                            ) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return const Text('Error');
                                } else if (snapshot.hasData) {
                                  for (var i = 0;
                                      i < snapshot.data!.length;
                                      i++) {
                                    String price = num.tryParse(
                                            snapshot.data![i].priceUsd!)!
                                        .toStringAsFixed(2);
                                    data.add(Column(
                                      children: [
                                        new Divider(color: Colors.grey),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                                '${formatter.format(DateTime.parse(snapshot.data![i].date!).toLocal())}'),
                                            Text('\$$price'),
                                          ],
                                        )
                                      ],
                                    ));
                                  }
                                  return Column(
                                    children: data,
                                  );
                                } else {
                                  return const Text('Empty data');
                                }
                              } else {
                                return Text(
                                    'State: ${snapshot.connectionState}');
                              }
                            },
                          ),
                          // for (var coin in betweenHour)
                          //   Row(
                          //     mainAxisAlignment:
                          //         MainAxisAlignment.spaceAround,
                          //     children: [
                          //       Text(
                          //           '${formatter.format(DateTime.parse(coin.date!).toLocal())}'),
                          //       Text('${coin.priceUsd}'),
                          //     ],
                          //   )
                        ],
                      ));
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

List<String> itemsBetweenDates({
  required List<String> dates,
  required List<String> items,
  required DateTime start,
  required DateTime end,
}) {
  assert(dates.length == items.length);

  var dateFormat = DateFormat('y-MM-dd');

  var output = <String>[];
  for (var i = 0; i < dates.length; i += 1) {
    var date = dateFormat.parse(dates[i], true);
    if (date.compareTo(start) >= 0 && date.compareTo(end) <= 0) {
      output.add(items[i]);
    }
  }
  return output;
}
