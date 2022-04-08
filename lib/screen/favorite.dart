import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/services/api_services.dart';
import 'package:untitled/services/base_auth.dart';
import 'package:untitled/config.dart';

import '../model/market_model.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  _favoriteState createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
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
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.grey,
            //สีขาว Theme.of(context).scaffoldBackgroundColor
            title: Text('Favorite',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold)),
            // pinned: true,

            snap: true,
            centerTitle: true,
            floating: true,
          ),
        ],
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
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            // Icon(Icons.star_border_sharp)
                            // leading: Icon(Icons.star_border_sharp),
                            title: Text('${snapshot.data![index].pair}'),
                            trailing:
                                Text('${snapshot.data![index].lastPrice}'),
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
